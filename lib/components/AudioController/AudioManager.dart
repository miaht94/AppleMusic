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
  final pausePlayButtonNotifier = ValueNotifier<PausePlayButtonState>(PausePlayButtonState.paused);
  final childWindowNotifier = ValueNotifier<ChildWindowState>(ChildWindowState.lyrics);
  final playlistNotifier = ValueNotifier<List<IndexedAudioSource>>([]);
  final currentSongNotifier = ValueNotifier<AudioMetadata>(
      AudioMetadata(artist: "",artwork: "", title: ""));
  final isFirstSongNotifier = ValueNotifier<bool>(true);
  final isLastSongNotifier = ValueNotifier<bool>(true);
  final isShuffleNotifier = ValueNotifier<bool>(false);
  final repeatNotifier = ValueNotifier<RepeatState>(RepeatState.noRepeat);
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
      {
        "link": "https://c1-ex-swe.nixcdn.com/NhacCuaTui918/DongKiemEm-ThaiVu-4373753.mp3",
        "title": "Đông Kiếm Em",
        "artist" : "Thái Vũ",
        "artwork" : "https://i1.sndcdn.com/artworks-000145857756-irf4fe-t500x500.jpg",
      },
      {
        "link": "https://c1-ex-swe.nixcdn.com/NhacCuaTui935/LaLung-Vu-4749614.mp3",
        "title": "Lạ Lùng",
        "artist" : "Thái Vũ",
        "artwork" : "https://i1.sndcdn.com/artworks-000427399239-nqi3tb-t500x500.jpg",
      },
      {
        "link": "https://c1-ex-swe.nixcdn.com/NhacCuaTui1007/ChuyenRang1-ThinhSuy-6465355.mp3",
        "title": "Chuyện Rằng",
        "artist" : "Thịnh Suy",
        "artwork" : "https://i.scdn.co/image/ab67616d0000b2734be34a1e036c97d22b5392d5",
      },
      {
        "link": "https://c1-ex-swe.nixcdn.com/NhacCuaTui1009/SinhRaDaLaThuDoiLapNhau-EmceeLDaLABBadbies-6896982.mp3",
        "title": "Sinh ra đã là thứ đối lập nhau",
        "artist" : "EmceeLDaLABBadbies",
        "artwork" : "https://i.scdn.co/image/ab67616d0000b27368acbddf50a87728633e8932",
      },
    ];
    List<AudioSource> listAudioSources = [];
    for (var value in listSongs) {
      listAudioSources.add(AudioSource.uri(Uri.parse(value['link']!),
          tag:AudioMetadata(title: value['title']!,
              artist: value['artist']!,
              artwork: value['artwork']!,)
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

  void dispose() {
    _audioPlayer.dispose();
  }
}