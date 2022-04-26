import 'dart:convert';

import 'package:apple_music/components/SongCardInPlaylist/SongCardInPlaylist.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import '../constant.dart';

class SongCardInPlaylistModel {
    SongCardInPlaylistModel(this._songName, this._artistName, this._artURL, this._id, this._genre);
    String _songName;
    String _artURL;
    String _artistName;
    String _genre;
    String _id;

    String get genre {
      return _genre;
    }

    String get songName {
        return _songName;
    }

    String get artistName {
        return _artistName;
    }

    String get artURL {
        return _artURL;
    }

    String get id {
        return _id;
    }

    static SongCardInPlaylistModel getSampleDataSingle() {
        return new SongCardInPlaylistModel("Lover", "Taylor Swift", "https://upload.wikimedia.org/wikipedia/vi/c/cd/Taylor_Swift_-_Lover.png", "123456", "genre_empty");
    }

    static List < SongCardInPlaylistModel > getSampleDataList() {
        return [
            new SongCardInPlaylistModel("Lover", "Taylor Swift", "https://upload.wikimedia.org/wikipedia/vi/c/cd/Taylor_Swift_-_Lover.png", "123456", "genre_empty"),
            new SongCardInPlaylistModel("Red (Taylor's Version)", "Taylor Swift", "https://nld.mediacdn.vn/291774122806476800/2021/6/19/t03-16240818944771485276009.jpg", "123456", "genre_empty"),
            new SongCardInPlaylistModel("Everything Has Changed", "Taylor Swift, Ed Sheeran", "https://nld.mediacdn.vn/291774122806476800/2021/6/19/t03-16240818944771485276009.jpg", "123456", "genre_empty"),
            new SongCardInPlaylistModel("cardigan", "Taylor Swift", "https://upload.wikimedia.org/wikipedia/vi/f/f8/Taylor_Swift_-_Folklore.png", "123456", "genre_empty"),
            new SongCardInPlaylistModel("Everything Has Changed", "Taylor Swift, Ed Sheeran", "https://nld.mediacdn.vn/291774122806476800/2021/6/19/t03-16240818944771485276009.jpg", "123456", "genre_empty")
        ];
    }

    factory SongCardInPlaylistModel.fromJson(Map<String, dynamic> json) {
        return new SongCardInPlaylistModel(json["song_name"], json["artist"]["artist_name"], json["album"]["art_url"], json["_id"], json["album"]["genre"]);
    }


    static Future<List<SongCardInPlaylistModel>> convert(json) async {
        List<SongCardInPlaylistModel> list = [];
        for (var object in json) {
            SongCardInPlaylistModel song = await SongCardInPlaylistModel.fetchSong(object["_id"]);
            list.add(song);
        }
        return list;
    }

    static Future <SongCardInPlaylistModel> fetchSong(String id) async {
        final Uri httpURI = Uri(scheme: 'http', host: SV_HOSTNAME, port: SV_PORT, path: SONG_PATH, queryParameters: {
            '_id': id
        });
        final  response = await http.get(httpURI);
        if (response.statusCode == 200){
            JsonDecoder decoder = JsonDecoder();
            SongCardInPlaylistModel song = SongCardInPlaylistModel.fromJson(decoder.convert(response.body)["song"]);
            return song;
        } else {
            return Future.error('No song for Id(${id})');
        }

    }
}