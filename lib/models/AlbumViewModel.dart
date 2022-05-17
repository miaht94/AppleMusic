import 'dart:convert';

import 'package:apple_music/models/AlbumSongListViewModel.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import '../constant.dart';

class AlbumViewModel {
  AlbumViewModel(this._albumName, this._albumArtist, this._albumGenre, this._albumYear, this._songList, this._artURL, this._albumDescription) {
    id = const Uuid().v4();
  }
  final String _albumName;
  final String _albumArtist;
  final String _albumDescription;
  final String _albumGenre;
  final String _albumYear;
  final List<AlbumSongListViewModel> _songList;
  final String _artURL;
  late String id;

  String get albumName{
    return _albumName;
  }

  String get albumArtist{
    return _albumArtist;
  }

  String get albumDescription{
    return _albumDescription;
  }

  String get albumGenre{
    return _albumGenre;
  }

  String get albumYear{
    return _albumYear;
  }

  List<AlbumSongListViewModel> get songList{
    return _songList;
  }

  String get artURL{
    return _artURL;
  }

  // ignore: inference_failure_on_untyped_parameter
  static Future<AlbumViewModel> getAlbum(albn,alba) async {
    try {
      final Uri httpURI = Uri(scheme: 'http', host: SV_HOSTNAME, port: SV_PORT, path: ALBUM_PATH, queryParameters: {
        'album_name': albn,
        'artist': alba
      });
      final  response = await http.get(httpURI);
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (kDebugMode) {
          print(result['songs'][0]['song_name']);
        }
        // print(result['songs']);
        final List<AlbumSongListViewModel> list = AlbumSongListViewModel.convert(result['songs']);
        final AlbumViewModel convertedResult = AlbumViewModel(
            result['album_name'],
            result['artist']['artist_name'],
            result['genre'],
            result['album_year'].toString(),
            list,
            result['art_url'],
            result['album_description'] ?? '');
        if (kDebugMode) {
          print(convertedResult.albumName);
        }
        return convertedResult;
      } else {
        throw Exception('Failed to load'); }
    } catch (execute)  {
      if (kDebugMode) {
        print('$execute');
      }
      return AlbumViewModel('AlbumError','', '', '', [], '', '');
    }
  }

  // ignore: prefer_constructors_over_static_methods
  static AlbumViewModel getSampleData() {
    return AlbumViewModel('Lover','Taylor Swift', 'Pop', '2019', AlbumSongListViewModel.getSampleData(), 'https://upload.wikimedia.org/wikipedia/vi/c/cd/Taylor_Swift_-_Lover.png', 'Bức thư tình lãng mạn được viết bởi những giai điệu ngọt ngào.');
  }
}