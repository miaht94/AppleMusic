
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
  final String lyric;
  final String genre;
  final String id;

  // ignore: sort_constructors_first
  AudioMetadata({
    required this.artwork,
    required this.title,
    required this.artist,
    required this.lyric,
    required this.genre,
    required this.id,
  });
}

enum RepeatState{
  repeatPlaylist, repeatCurrentItem, noRepeat
}