import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LyricModel{
  const LyricModel(this.key, this.lyric, this.startTime);
  final GlobalKey key;
  final String lyric;
  final Duration startTime;
  // ignore: sort_constructors_first
  LyricModel._({required this.key, required this.lyric, required this.startTime});

  // ignore: sort_constructors_first
  factory LyricModel.fromJson(Map<String, dynamic> json) {
    return LyricModel._(
        key: GlobalKey(),
        lyric: json['content'],
        startTime: Duration(milliseconds : ((json['timestamp']) * 1000).toInt()),
    );
  }
  // ignore: inference_failure_on_untyped_parameter
  static  Future<List<LyricModel>> fetchLyrics(url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes))['scripts'];
      // List<LyricModel> list = [];
      if (kDebugMode) {
        print(data);
      }
      if (kDebugMode) {
        print('fetch lyric');
      }
      // ignore: unnecessary_lambdas
      return data.map((item) => LyricModel.fromJson(item)).toList();
      // return list;
    } else {

      if (kDebugMode) {
        print('Request failed with status: ${response.statusCode}.');
      }
    }
    return [];
  }
}
