import 'dart:convert';

import 'package:apple_music/models/AlbumSongListViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart';

class AlbumViewModel {
  AlbumViewModel(this._albumName, this._albumArtist, this._albumGenre, this._albumYear, this._songList, this._artURL, this._albumDescription) {
    id = Uuid().v4();
  }
  String _albumName;
  String _albumArtist;
  String _albumDescription;
  String _albumGenre;
  String _albumYear;
  List<AlbumSongListViewModel> _songList;
  String _artURL;
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

  static Future<AlbumViewModel> getAlbum(albn,alba) async {
    try {
      final response = await get(Uri.parse("http://koyomiku39.moe/api/album?album_name=" + albn +"&artist=" +alba));
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        print(result['songs'][0]['song_name']);
        // print(result['songs']);
        List<AlbumSongListViewModel> list = AlbumSongListViewModel.convert(result['songs']);
        AlbumViewModel convertedResult = new AlbumViewModel(
            result['album_name'],
            result['artist']['artist_name'],
            result['genre'],
            result['album_year'].toString(),
            list,
            result['art_url'],
            result['album_description'] !=null ? result['album_description'] : "");
        print(convertedResult.albumName);
        return convertedResult;
      } else {
        throw Exception("Failed to Load");
      }
      return AlbumViewModel("Lover","ABC Swift", "Pop", "2019", AlbumSongListViewModel.getSampleData(), "https://upload.wikimedia.org/wikipedia/vi/c/cd/Taylor_Swift_-_Lover.png", "Bức thư tình lãng mạn được viết bởi những giai điệu ngọt ngào.");;
    } catch (execute)  {
      print("$execute");
      return AlbumViewModel("Album failed to load","", "", "", [], "", "");
    }
  }

  static AlbumViewModel getSampleData() {
    return AlbumViewModel("Lover","Taylor Swift", "Pop", "2019", AlbumSongListViewModel.getSampleData(), "https://upload.wikimedia.org/wikipedia/vi/c/cd/Taylor_Swift_-_Lover.png", "Bức thư tình lãng mạn được viết bởi những giai điệu ngọt ngào.");
  }
}