import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import '../constant.dart';

class HScrollSquareCardModel {
  HScrollSquareCardModel(this._albumName, this._albumArtist, this._artURL, this._id);
  String _albumName;
  String _albumArtist;
  String _artURL;
  String _id;

  String get albumName {
    return _albumName;
  }

  String get albumArtist {
    return _albumArtist;
  }

  String get artURL {
    return _artURL;
  }

  String get id {
    return _id;
  }

  static List<HScrollSquareCardModel> getSampleData() {
    return [
      new HScrollSquareCardModel("Red", "Taylor Swift", "https://avatar-ex-swe.nixcdn.com/song/2018/05/21/6/e/e/1/1526887767068_640.jpg", "123456"),
      new HScrollSquareCardModel("Lover", "Taylor Swift", "https://upload.wikimedia.org/wikipedia/vi/c/cd/Taylor_Swift_-_Lover.png", "123456"),
      new HScrollSquareCardModel("At my worst", "Pink Sweat", "https://avatar-ex-swe.nixcdn.com/song/2020/09/15/3/7/8/3/1600184151280_640.jpg", "123456"),
      new HScrollSquareCardModel("Boulevard Of Broken Dreams", "Green Day", "https://images.genius.com/d8a68a3aac2ab79bd4d4c5ee33fd69fa.1000x1000x1.png", "123456")
    ];
  }

  factory HScrollSquareCardModel.fromJson(Map<String, dynamic> json) {
    return new HScrollSquareCardModel(json["album_name"], json["artist"]["artist_name"], json["art_url"], json["_id"]);
  }

  static Future<List<HScrollSquareCardModel>> convert(json) async {
    List<HScrollSquareCardModel> list = [];
    for (var object in json) {
      HScrollSquareCardModel album = await HScrollSquareCardModel.fetchAlbum(object["_id"]);
      list.add(album);
    }
    return list;
  }

  static Future <HScrollSquareCardModel> fetchAlbum(String id) async {
    final Uri httpURI = Uri(scheme: 'http', host: SV_HOSTNAME, port: SV_PORT, path: ALBUM_PATH, queryParameters: {
      '_id': id
    });
    final  response = await http.get(httpURI);
    if (response.statusCode == 200){
      JsonDecoder decoder = JsonDecoder();
      HScrollSquareCardModel album = HScrollSquareCardModel.fromJson(decoder.convert(response.body));
      return album;
    } else {
      return Future.error('No album for Id(${id})');
    }

  }
}