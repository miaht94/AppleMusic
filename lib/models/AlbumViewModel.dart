import 'package:apple_music/models/AlbumSongLIstViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

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

  static AlbumViewModel getSampleData() {
    return AlbumViewModel("Lover","Taylor Swift", "Pop", "2019", AlbumSongListViewModel.getSampleData(), "https://upload.wikimedia.org/wikipedia/vi/c/cd/Taylor_Swift_-_Lover.png", "Bức thư tình lãng mạn được viết bởi những giai điệu ngọt ngào.");
  }
}