import 'dart:convert';
import 'package:apple_music/models_refactor/ArtistModel.dart';
import 'package:apple_music/models_refactor/SongModel.dart';
import 'package:apple_music/services/http_util.dart';
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

    static SongModel getSampleDataSingle() {
        return  SongModel(
            artist: ArtistRawModel(id: '', artist_image_url: '', artist_name: '', artist_description: '', album_list_id: []),
            song_name: '',
            song_key: '',
            id: '',
            lyric_key: '',
            album: AlbumRawModel(album_name: '', songsId: [], id: '', art_url: '', genre: '', album_year: 2019)
        );
    }

    static List < SongModel > getSampleDataList() {
        return [
            SongModel(
                artist: ArtistRawModel(id: '', artist_image_url: '', artist_name: '', artist_description: '', album_list_id: []),
                song_name: '',
                song_key: '',
                id: '',
                lyric_key: '',
                album: AlbumRawModel(album_name: '', songsId: [], id: '', art_url: '', genre: '', album_year: 2019)
            )
        ];
    }

    factory SongCardInPlaylistModel.fromJson(Map<String, dynamic> json) {
        return new SongCardInPlaylistModel(json["song_name"], json["artist"]["artist_name"], json["album"]["art_url"], json["_id"], json["album"]["genre"]);
    }


    static Future<List<SongModel>> convert(json) async {
        List<SongModel> list = [];
        for (var object in json) {
            SongUrlModel? song = await HttpUtil().fetchSongModel(object["_id"]);
            list.add(song!.song);
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