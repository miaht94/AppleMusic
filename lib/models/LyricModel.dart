import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LyricModel{
  const LyricModel(this.key, this.lyric, this.startTime);
  final GlobalKey key;
  final String lyric;
  final Duration startTime;
  LyricModel._({required this.key, required this.lyric, required this.startTime});

  factory LyricModel.fromJson(Map<String, dynamic> json) {
    return LyricModel._(
        key: GlobalKey(),
        lyric: json['text'],
        startTime: Duration(milliseconds : ((json['start']).toDouble() * 1000).toInt()),
    );
  }
  static  Future<List<LyricModel>> fetchLyrics(url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes))['scripts'];
      // List<LyricModel> list = [];
      if (response.body != null) {
        print("fetch lyric");
        return data.map((item) => LyricModel.fromJson(item)).toList();
      }
      // return list;
    } else {

      print('Request failed with status: ${response.statusCode}.');
    }
    return [];
  }
}
