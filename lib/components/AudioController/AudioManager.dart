import "package:flutter/material.dart";
import 'package:just_audio/just_audio.dart';

class AudioManager {
  final progressNotifier = ValueNotifier<ProgressBarState>(
    ProgressBarState(
      current: Duration.zero,
      total: Duration.zero,
      dragPosition: Duration.zero,
    ),
  );
  var isDraging = false;
  final pausePlayButtonNotifier = ValueNotifier<PausePlayButtonState>(PausePlayButtonState.paused);
  final childWindowNotifier = ValueNotifier<ChildWindowState>(ChildWindowState.lyrics);
  final playlistNotifier = ValueNotifier<List<IndexedAudioSource>>([]);
  final currentSongNotifier = ValueNotifier<AudioMetadata>(
      AudioMetadata(artist: "",artwork: "", title: ""));


  late AudioPlayer _audioPlayer;
  late ConcatenatingAudioSource _playlist;

  AudioManager(){
    _init();
  }

  void _init() async{
    _audioPlayer = AudioPlayer();
    _initPlaylist();

    _listenForPositionChange();
    _listenForTotalDurationChange();
    _listenForPlayerStateChange();
    _listenForSequenceState();
  }

  void _initPlaylist() async{
    const listSongs = [
      "https://www.soundhelix.com/examples/mp3//SoundHelix-Song-1.mp3",
      "https://www.soundhelix.com/examples/mp3//SoundHelix-Song-2.mp3",
      "https://www.soundhelix.com/examples/mp3//SoundHelix-Song-3.mp3"
    ];
    List<AudioSource> listAudioSources = [];
    for (var value in listSongs) {
      listAudioSources.add(AudioSource.uri(Uri.parse(value),
          tag:AudioMetadata(title: "Song ${listSongs.indexOf(value)}",
              artist: "Taylor Swift",
              artwork: "https://upload.wikimedia.org/wikipedia/vi/c/cd/Taylor_Swift_-_Lover.png")
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
      final currentSongData = currentItem?.tag;
      currentSongNotifier.value = currentSongData;

      final playlist = sequenceState.effectiveSequence;
      playlistNotifier.value = playlist;
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

  void lyricWindow() {
    childWindowNotifier.value = ChildWindowState.lyrics;
  }

  void songWindow() {
    childWindowNotifier.value = ChildWindowState.song;
  }

  void playlistWindow() {
    childWindowNotifier.value = ChildWindowState.playlist;
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

  void dispose() {
    _audioPlayer.dispose();
  }
}

class ProgressBarState {
  ProgressBarState({
    required this.current,
    required this.total,
    required this.dragPosition,
});

  final Duration current;
  final Duration total;
  final Duration dragPosition;
}

enum PausePlayButtonState{
  paused ,playing,loading
}

enum ChildWindowState{
  lyrics,playlist,song
}

class AudioMetadata {
  final String artwork;
  final String title;
  final String artist;

  AudioMetadata({
    required this.artwork,
    required this.title,
    required this.artist,
  });
}