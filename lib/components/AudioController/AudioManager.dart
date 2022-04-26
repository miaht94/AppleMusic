import 'package:apple_music/manager/CurrentUserManager.dart';
import 'package:apple_music/models/LyricModel.dart';
import 'package:apple_music/models/SongModel.dart';
import 'package:apple_music/services/service_locator.dart';
import "package:flutter/material.dart";
import 'package:just_audio/just_audio.dart';
import 'package:apple_music/components/AudioController/AudioStates.dart';
class AudioManager {
  final progressNotifier = ValueNotifier<ProgressBarState>(
    ProgressBarState(
      current: Duration.zero,
      total: Duration.zero,
      dragPosition: Duration.zero,
    ),
  );
  var isDraging = false;
  var isMoving = false;
  final pausePlayButtonNotifier = ValueNotifier<PausePlayButtonState>(PausePlayButtonState.paused);
  final childWindowNotifier = ValueNotifier<ChildWindowState>(ChildWindowState.lyrics);
  final playlistNotifier = ValueNotifier<List<IndexedAudioSource>>([]);
  final currentSongNotifier = ValueNotifier<AudioMetadata>(
      AudioMetadata(artist: "",artwork: "", title: "", lyric: ""));
  final isFirstSongNotifier = ValueNotifier<bool>(true);
  final isLastSongNotifier = ValueNotifier<bool>(true);
  final isShuffleNotifier = ValueNotifier<bool>(false);
  final repeatNotifier = ValueNotifier<RepeatState>(RepeatState.noRepeat);

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
    CurrentUserManager currentUserManager = getIt<CurrentUserManager>();
    var userPlaylists = currentUserManager.getCurrentUser().playLists;
    List<SongModel> listSongs = [];

    for (var playlist in userPlaylists) {
      List<dynamic> listSong = playlist["songs"];
      for (String songUrl in listSong){
        try {
          final SongModel song = await SongModel.fetchSong(songUrl);
          listSongs.add(song);
        } catch(e) {
        }
        
      }
    }

    List<AudioSource> listAudioSources = [];
    for (var value in listSongs) {
      listAudioSources.add(AudioSource.uri(Uri.parse(value.songUrl),
          tag:AudioMetadata(title: value.songName,
              artist: value.artist,
              artwork: value.artwork,
              lyric: value.songLyricUrl)
      ));
    }

    _playlist = ConcatenatingAudioSource(children: listAudioSources);
    await _audioPlayer.setAudioSource(_playlist);
  }

  void _listenForPositionChange(){
    _audioPlayer.positionStream.listen((position) {
      if (!isDraging) {
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
    _audioPlayer.sequenceStateStream.listen((sequenceState) {
      if (sequenceState == null) return;
      final currentItem = sequenceState.currentSource;
      if (!isMoving) {
        final currentSongData = currentItem?.tag;
        currentSongNotifier.value = currentSongData;
        currentLyricNotifier = LyricModel.fetchLyrics(currentSongData.lyric);
      }

      final playlist = sequenceState.effectiveSequence;
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
    isDraging = false;
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
    isDraging = true;
    final oldState = progressNotifier.value;
    progressNotifier.value = ProgressBarState(
      current: position,
      total: oldState.total,
      dragPosition: position,
    );
  }

  void move(currentIndex, newIndex) async {
    isMoving = true;
    await _playlist.move(currentIndex, newIndex).then((value) => {isMoving = false});

  }

  void dispose() {
    _audioPlayer.dispose();
  }
}