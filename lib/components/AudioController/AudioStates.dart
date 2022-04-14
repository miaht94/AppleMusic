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

enum RepeatState{
  repeatPlaylist, repeatCurrentItem, noRepeat
}