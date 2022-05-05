import 'package:apple_music/components/AudioController/AudioStates.dart';
import 'package:apple_music/models/LyricModel.dart';
import 'package:apple_music/models/SongModel.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
class AudioManager {
  final progressNotifier = ValueNotifier<ProgressBarState>(
    ProgressBarState(
      current: Duration.zero,
      total: Duration.zero,
      dragPosition: Duration.zero,
    ),
  );
  var isDragging = false;
  var isMoving = false;
  final pausePlayButtonNotifier = ValueNotifier<PausePlayButtonState>(PausePlayButtonState.paused);
  final childWindowNotifier = ValueNotifier<ChildWindowState>(ChildWindowState.playlist);
  final playlistNotifier = ValueNotifier<List<IndexedAudioSource>>([]);
  final currentSongNotifier = ValueNotifier<AudioMetadata>(
      AudioMetadata(artist: '',artwork: '', title: '', lyric: ''));
  final isFirstSongNotifier = ValueNotifier<bool>(true);
  final isLastSongNotifier = ValueNotifier<bool>(true);
  final isShuffleNotifier = ValueNotifier<bool>(false);
  final repeatNotifier = ValueNotifier<RepeatState>(RepeatState.noRepeat);
  final currentSongIndexNotifier = ValueNotifier<int>(0);

  Future <List<LyricModel>> ? currentLyricNotifier ;
  late AudioPlayer _audioPlayer;
  late ConcatenatingAudioSource _playlist;

  AudioManager(){
  }

  void init() async{
    _audioPlayer = AudioPlayer();
    _initPlaylist();
    _listenForPositionChange();
    _listenForTotalDurationChange();
    _listenForPlayerStateChange();
    _listenForSequenceState();

  }

  void _initPlaylist() async{
    _playlist = ConcatenatingAudioSource(children: []);
    await _audioPlayer.setAudioSource(_playlist);
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
        _audioPlayer.pause();
      }
    });
  }

  void _listenForSequenceState(){
    _audioPlayer.sequenceStateStream.listen((sequenceState) async{
      if (sequenceState == null) return;
      final currentItem = sequenceState.currentSource;
      if (!isMoving && currentItem != null) {
        final currentSongData = currentItem.tag;
        currentSongNotifier.value = currentSongData;

        //first time fetch
        currentLyricNotifier ??= LyricModel.fetchLyrics(currentSongData.lyric);
      }
      // change song fetch
      if(currentSongIndexNotifier.value != _audioPlayer.currentIndex){
        currentSongIndexNotifier.value = _audioPlayer.currentIndex!;
        currentLyricNotifier =  LyricModel.fetchLyrics(currentSongNotifier.value.lyric);
      }

      final playlist = sequenceState.effectiveSequence;
      playlistNotifier.value = playlist;
      print("After insert :  ${_playlist.length}}");

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
  }

  Future<void> move(currentIndex, newIndex) async {
    isMoving = true;
    await _playlist.move(currentIndex, newIndex).then((value) => {isMoving = false});
  }

  Future<void> clear() async {
    await _playlist.clear();
  }

  Future<void> addAndPlayASong(String songId) async {
    print('addddddddd');
    await insertNext(songId);
    int CurrentIndex = _audioPlayer.currentIndex ?? 0;
    if (CurrentIndex != _playlist.length){
      CurrentIndex ++;
    }
    _audioPlayer.seek(Duration(seconds: 0),index : CurrentIndex);
    play();
  }

  Future<void> clearAndAddAList(List<String> playLists) async {
    await clear();
    List<SongModel> listSongs = [];
    bool isFirst = true;
      for (String songUrl in playLists){
        try {
          final SongModel song = await SongModel.fetchSong(songUrl);
          listSongs.add(song);
        } catch(e) {
      }
    }
    for (SongModel value in listSongs){
      await _playlist.add(AudioSource.uri(Uri.parse(value.songUrl),
          tag:AudioMetadata(title: value.songName,
              artist: value.artist,
              artwork: value.artwork,
              lyric: value.songLyricUrl)
      ));
      if (isFirst){
        _audioPlayer.seek(Duration(seconds: 0),index : 0);
        play();
        isFirst = false;
        print("play new playlist");
      }
    }
  }

  Future<void> insertNext(String songId) async {
    late SongModel value;
    try {
      value = await SongModel.fetchSong(songId);
    } catch(e) {
    }
    int CurrentIndex = _audioPlayer.currentIndex ?? 0;
    if (CurrentIndex != _playlist.length){
      CurrentIndex ++;
    }
    await _playlist.insert(CurrentIndex,AudioSource.uri(Uri.parse(value.songUrl),
        tag:AudioMetadata(title: value.songName,
            artist: value.artist,
            artwork: value.artwork,
            lyric: value.songLyricUrl)
    ));
  }

  Future<void> insertTail(String songId) async {
    late SongModel value;
    try {
      value = await SongModel.fetchSong(songId);
    } catch(e) {
    }
    if(_playlist.length == 0){
      await insertNext(songId);
      return;
    }
    await _playlist.insert(_playlist.length ,AudioSource.uri(Uri.parse(value.songUrl),
        tag:AudioMetadata(title: value.songName,
            artist: value.artist,
            artwork: value.artwork,
            lyric: value.songLyricUrl)
    ));
  }

  Future<void> removeSong(int index) async{
    await _playlist.removeAt(index);
  }

  int getCurrentSongIndex(){
    return _audioPlayer.currentIndex ?? 0;
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}