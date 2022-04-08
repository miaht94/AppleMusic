import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Lyric{
  const Lyric(this.key, this.lyric, this.startTime);
  final GlobalKey key;
  final String lyric;
  final Duration startTime;
  Lyric._({required this.key, required this.lyric, required this.startTime});

  factory Lyric.fromJson(Map<String, dynamic> json) {
    return Lyric._(
        key: GlobalKey(),
        lyric: json['text'],
        startTime: Duration(milliseconds : ((json['start']).toDouble() * 1000).toInt()),
    );
  }
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

  static  Future<List<Lyric>> fetchLyrics(url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes))['scripts'];
      List<Lyric> list = [];
      if (response.body != null) {
        list = data.map((item) => Lyric.fromJson(item)).toList();
      }
      print(list);
      return list;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return [];
  }

  // static List<Lyric> getLyricsFromUrl(url) {
  //   return [
  //
  //   ]
  // }
}