import 'package:apple_music/components/AudioController/AudioStates.dart';
import 'package:apple_music/models/LyricModel.dart';
import 'package:apple_music/models_refactor/SongModel.dart';
import 'package:apple_music/services/http_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:just_audio/just_audio.dart';
class AudioManager {
  final progressNotifier = ValueNotifier<ProgressBarState>(
    ProgressBarState(
      current: Duration.zero,
      total: Duration.zero,
      dragPosition: Duration.zero,
    ),
  );
  final isLoading = ValueNotifier<bool>(false);
  var isMoving = false;
  var isDragging = false;
  final pausePlayButtonNotifier = ValueNotifier<PausePlayButtonState>(PausePlayButtonState.paused);
  final childWindowNotifier = ValueNotifier<ChildWindowState>(ChildWindowState.playlist);
  final playlistNotifier = ValueNotifier<List<IndexedAudioSource>>([]);
  final currentSongNotifier = ValueNotifier<SongUrlModel?>(null);
  final isFirstSongNotifier = ValueNotifier<bool>(true);
  final isLastSongNotifier = ValueNotifier<bool>(true);
  final isShuffleNotifier = ValueNotifier<bool>(false);
  final repeatNotifier = ValueNotifier<RepeatState>(RepeatState.noRepeat);
  final currentSongIndexNotifier = ValueNotifier<int>(0);
  final lyricIndexNotifier = ValueNotifier<int>(0);
  Future <List<LyricModel>> ? currentLyricNotifier ;
  List<LyricModel>? currentLyric;
  late AudioPlayer _audioPlayer;
  late ConcatenatingAudioSource _playlist;
  int _tempCurrentIndex = 0;


  // ignore: avoid_void_async
  void init() async{
    _audioPlayer = AudioPlayer();
    _initPlaylist();
    _listenForPositionChange();
    _listenForTotalDurationChange();
    _listenForPlayerStateChange();
    _listenForSequenceState();

  }

  // ignore: avoid_void_async
  void _initPlaylist() async{
    if(_audioPlayer.shuffleModeEnabled) {
      await _audioPlayer.setShuffleModeEnabled(false);
      isShuffleNotifier.value = false;
    }
    _playlist = ConcatenatingAudioSource(children: []);
    await _audioPlayer.setAudioSource(_playlist);
    _tempCurrentIndex = 0;
  }

  void _listenForPositionChange(){
    _audioPlayer.positionStream.listen((position) {
      if (!isDragging) {
        final oldState = progressNotifier.value;
        progressNotifier.value = ProgressBarState(
          current: position,
          total: oldState.total,
          dragPosition: position,
        );
        const int start =  0;
        if (currentLyric != null) {
          for(int i = start; i < currentLyric!.length; i ++){
            if (position <= currentLyric![i].startTime) {
              lyricIndexNotifier.value = i;
              break;
            }
          }
          if (position > currentLyric![currentLyric!.length - 1].startTime){
            lyricIndexNotifier.value = currentLyric!.length - 1;
          }
        }
      }

    });
  }

  void _listenForTotalDurationChange(){
    _audioPlayer.durationStream.listen((totalDuration) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        total: totalDuration ?? Duration.zero,
        dragPosition: oldState.dragPosition,
      );
    });
  }

  void _listenForPlayerStateChange(){
    _audioPlayer.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        pausePlayButtonNotifier.value = PausePlayButtonState.loading;
      } else if (!isPlaying) {
        pausePlayButtonNotifier.value = PausePlayButtonState.paused;
      } else if (processingState != ProcessingState.completed) {
        pausePlayButtonNotifier.value = PausePlayButtonState.playing;
      } else {
        _audioPlayer.seek(Duration.zero);
        // ignore: cascade_invocations
        _audioPlayer.pause();
      }
    });
  }

  void _listenForSequenceState(){
    _audioPlayer.sequenceStateStream.listen((sequenceState) async{
      if (sequenceState == null) {
        return;
      }
      final currentItem = sequenceState.currentSource;
      if (!isMoving && currentItem != null) {
        final SongUrlModel currentSongData = currentItem.tag;
        currentSongNotifier.value = currentSongData;

        //first time fetch
        currentLyricNotifier ??= HttpUtil().fetchLyrics(currentSongData.lyricURL);
        currentLyric = await currentLyricNotifier;
      }
      // change song fetch
      if( _tempCurrentIndex != _audioPlayer.currentIndex){
        _tempCurrentIndex = _audioPlayer.currentIndex!;
        if (!_audioPlayer.shuffleModeEnabled) {
          currentSongIndexNotifier.value = _audioPlayer.currentIndex!;
        }else{
          currentSongIndexNotifier.value = sequenceState.shuffleIndices.indexOf(_tempCurrentIndex);
        }
        if (currentItem != null) {
          currentLyricNotifier =  HttpUtil().fetchLyrics(currentSongNotifier.value!.lyricURL);
          currentLyric = await currentLyricNotifier;
        }
      }

      if ((isShuffleNotifier.value != sequenceState.shuffleModeEnabled)
      || (sequenceState.shuffleModeEnabled && _tempCurrentIndex == 0)
      ){
        if (!_audioPlayer.shuffleModeEnabled) {
          currentSongIndexNotifier.value = _audioPlayer.currentIndex!;
        }else{
          currentSongIndexNotifier.value = sequenceState.shuffleIndices.indexOf(_tempCurrentIndex);
        }
      }

      final List<IndexedAudioSource> playlist = sequenceState.effectiveSequence;
      playlistNotifier.value = playlist;

      if (playlist.isEmpty || currentItem == null) {
        isFirstSongNotifier.value = true;
        isLastSongNotifier.value = true;
      } else {
        isFirstSongNotifier.value = playlist.first == currentItem;
        isLastSongNotifier.value = playlist.last == currentItem;
      }
      isShuffleNotifier.value = sequenceState.shuffleModeEnabled;
    });
  }

  void play() {
    _audioPlayer.play();
  }

  void pause() {
    _audioPlayer.pause();
  }

  void seek(Duration position) {
    isDragging = false;
    _audioPlayer.seek(position);
  }

  void seekToNext(){
    _audioPlayer.seekToNext();
  }

  void seekToPrevious(){
    _audioPlayer.seekToPrevious();
  }

  void lyricWindow() {
    childWindowNotifier.value = ChildWindowState.lyrics;
  }

  void songWindow() {
    childWindowNotifier.value = ChildWindowState.song;
  }

  void playlistWindow() {
    childWindowNotifier.value = ChildWindowState.playlist;
  }

  // ignore: avoid_void_async
  void shuffle() async{
    final enable = !_audioPlayer.shuffleModeEnabled;
    if (enable) {
      await _audioPlayer.shuffle();
    }
    await _audioPlayer.setShuffleModeEnabled(enable);
  }

  void repeat() {
    final  nextIndex = (repeatNotifier.value.index + 1) % RepeatState.values.length;
    repeatNotifier.value = RepeatState.values[nextIndex];
    switch (repeatNotifier.value) {
      case RepeatState.noRepeat:
        _audioPlayer.setLoopMode(LoopMode.off);
        break;
      case RepeatState.repeatCurrentItem:
        _audioPlayer.setLoopMode(LoopMode.one);
        break;
      case RepeatState.repeatPlaylist:
        _audioPlayer.setLoopMode(LoopMode.all);
    }
  }

  void drag(Duration position) {
    isDragging = true;
    final oldState = progressNotifier.value;
    progressNotifier.value = ProgressBarState(
      current: position,
      total: oldState.total,
      dragPosition: position,
    );
    const int start =  1;
    if (currentLyric != null) {
      for(int i = start; i < currentLyric!.length; i ++){
        if (position < currentLyric![i].startTime) {
          lyricIndexNotifier.value = i;
          break;
        }
      }
    }

  }

  Future<void> move(int currentIndex,int newIndex) async {
    if (!_audioPlayer.shuffleModeEnabled) {
      isMoving = true;
      await _playlist.move(currentIndex, newIndex).then((value) => {isMoving = false});
    }
  }

  Future<void> clear() async {
    _initPlaylist();
    await _playlist.clear();
  }

  Future<void> addAndPlayASong(String songId) async {
    await insertNext(songId);
    // ignore: non_constant_identifier_names
    int CurrentIndex = _audioPlayer.currentIndex ?? 0;
    if (CurrentIndex != _playlist.length && _playlist.length != 1){
      CurrentIndex ++;
    }
    await _audioPlayer.seek(const Duration(),index : CurrentIndex);
    play();
  }

  Future<void> clearAndAddAList(List<String> playLists) async {
    await clear();
    isLoading.value = true;
    final List<SongUrlModel> listSongs = [];
    bool isFirst = true;
      for (final String songUrl in playLists){
        try {
          final SongUrlModel? songUrlModel = await HttpUtil().fetchSongModel(songUrl);
          listSongs.add(songUrlModel!);
        // ignore: empty_catches
        } catch(e) {
      }
    }
    currentLyricNotifier = HttpUtil().fetchLyrics(listSongs[0].lyricURL);
    currentLyric = await currentLyricNotifier;
    for (final SongUrlModel value in listSongs){
      await _playlist.add(AudioSource.uri(Uri.parse(value.song_url),
          tag: value
      ));
      if (isFirst){
         await _audioPlayer.seek(const Duration(),index : 0);
        isFirst = false;
        play();
      }
    }
    if (_playlist.length == listSongs.length) {
      isLoading.value = false;
    }
  }

  Future<void> addAList(List<String> playLists) async {
    final List<SongUrlModel> listSongs = [];
      for (final String songUrl in playLists){
        try {
          final SongUrlModel? songUrlModel = await HttpUtil().fetchSongModel(songUrl);
          listSongs.add(songUrlModel!);
        // ignore: empty_catches
        } catch(e) {
      }
    }
    for (final SongUrlModel value in listSongs){
      await _playlist.add(AudioSource.uri(Uri.parse(value.song_url),
          tag: value
      ));
    }
  }


  Future<void> insertNext(String songId) async {
    if (_playlist.length != 0) {
      isMoving = true;
    }
    late SongUrlModel? value;
    try {
      value = await HttpUtil().fetchSongModel(songId);
    // ignore: empty_catches
    } catch(e) {
    }
    // ignore: non_constant_identifier_names
    int CurrentIndex = _audioPlayer.currentIndex ?? 0;
    if (CurrentIndex != _playlist.length){
      CurrentIndex ++;
    }
    if (value != null) {
      await _playlist.insert(CurrentIndex,AudioSource.uri(Uri.parse(value.song_url),
        tag:value
      ));
    }
    isMoving = false;
  }

  Future<void> insertTail(String songId) async {
    late SongUrlModel? value;
    try {
      value = await HttpUtil().fetchSongModel(songId);
    // ignore: empty_catches
    } catch(e) {
    }
    if(_playlist.length == 0){
      await insertNext(songId);
      return;
    }
    if (value != null) {
      await _playlist.insert(_playlist.length ,AudioSource.uri(Uri.parse(value.song_url),
          tag:value
      ));
    }
  }

  Future<void> removeSong(int index) async{
    if (!_audioPlayer.shuffleModeEnabled) {
      await _playlist.removeAt(index);
    } else {
      index = _playlist.shuffleIndices.indexOf(index);
      await _playlist.removeAt(index);
    }
    await EasyLoading.showToast('Xóa thành công', duration: const Duration(milliseconds: 500));
  }

  int getCurrentSongIndex(){
    return _audioPlayer.currentIndex ?? 0;
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}