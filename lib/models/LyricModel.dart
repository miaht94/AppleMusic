import 'package:flutter/material.dart';

class Lyric{
  const Lyric(this.key, this.lyric, this.startingTime);
  final GlobalKey key;
  final String lyric;
  final Duration startingTime;
}

class Lyrics{
  static const lyric = 'Chẳng phải em là hồn của cây';
  static const lyricSize = 24.0;
  static List<Lyric> getLyrics() {
    return [
      Lyric(GlobalKey(), 'Chẳng phải em là hồn của cây', Duration(seconds: 0 )),
      Lyric(GlobalKey(), 'Mang câu hát đi thật xa Mang câu hát đi thật xa Mang câu hát đi thật xa', Duration(seconds: 5)),
      Lyric(GlobalKey(), 'Sống trong bao câu chuyện buồn', Duration(seconds: 10)),
      Lyric(GlobalKey(), lyric, Duration(seconds: 15)),
      Lyric(GlobalKey(), 'Mang câu hát đi thật xa', Duration(seconds: 20)),
      Lyric(GlobalKey(), lyric, Duration(seconds: 25)),
      Lyric(GlobalKey(), 'Mang câu hát đi thật xa', Duration(seconds: 30)),
      Lyric(GlobalKey(), 'Mang câu hát đi thật xa', Duration(seconds: 35)),
      Lyric(GlobalKey(), 'Mang câu hát đi thật xa', Duration(seconds: 40)),
      Lyric(GlobalKey(), 'Mang câu hát đi thật xa', Duration(seconds: 45)),
    ];
  }
}