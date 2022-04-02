import 'package:flutter/material.dart';

class Lyric{
  const Lyric(this.key, this.lyric, this.startingTime);
  final GlobalKey key;
  final String lyric;
  final int startingTime;
}

class Lyrics{
  static const lyric = 'Chẳng phải em là hồn của cây';
  static const lyricSize = 24.0;
  static List<Lyric> getLyrics() {
    return [
      Lyric(GlobalKey(), 'Chẳng phải em là hồn của cây', 0),
      Lyric(GlobalKey(), 'Mang câu hát đi thật xa Mang câu hát đi thật xa Mang câu hát đi thật xa', 1),
      Lyric(GlobalKey(), 'Sống trong bao câu chuyện buồn', 2),
      Lyric(GlobalKey(), lyric, 3),
      Lyric(GlobalKey(), 'Mang câu hát đi thật xa', 4),
      Lyric(GlobalKey(), lyric, 5),
      Lyric(GlobalKey(), 'Mang câu hát đi thật xa', 6),
      Lyric(GlobalKey(), 'Mang câu hát đi thật xa', 7),
      Lyric(GlobalKey(), 'Mang câu hát đi thật xa', 7),
      Lyric(GlobalKey(), 'Mang câu hát đi thật xa', 7),
    ];
  }
}