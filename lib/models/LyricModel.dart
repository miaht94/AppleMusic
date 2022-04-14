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
      Lyric(GlobalKey(), 'Bài hát: Đông Kiếm Em - Thái Vũ', Duration(seconds: 0 )),
      Lyric(GlobalKey(), 'Tôi hát cho màu xanh mãi xanh,', Duration(seconds: 18)),
      Lyric(GlobalKey(), 'cho một người lặng im biết yêu.', Duration(seconds: 23)),
      Lyric(GlobalKey(), "Và tôi viết cho mùa yêu xốn xang,", Duration(seconds: 30)),
      Lyric(GlobalKey(), 'cho một đời nhớ thương vẹn nguyên.', Duration(seconds: 38)),
      Lyric(GlobalKey(), "Cô đơn đến thê", Duration(seconds: 46)),
      Lyric(GlobalKey(), 'mưa rơi lách tách kì cục đợi ai.', Duration(seconds: 48)),
      Lyric(GlobalKey(), 'Sâu trong ánh mắt', Duration(seconds: 53)),
      Lyric(GlobalKey(), 'tôi ngu ngơ, mơ thời gian dừng trôi.', Duration(seconds: 55)),
      Lyric(GlobalKey(), 'Còn lại đây nhớ mong, còn lại tôi với ai?', Duration(minutes: 1, seconds: 2)),
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

}