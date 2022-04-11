import 'package:apple_music/models/AlbumSongLIstViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class ArtistViewModel {
  ArtistViewModel(this._artistName, this._highlightSong, this._topSongList, this._albumList, this._artistDescription) {
    id = Uuid().v4();
  }
  String _artistName;
  String _highlightSong;
  String _topSongList;
  String _albumList;
  String _artistDescription;
  late String id;

  String get artistName{
    return _artistName;
  }

  String get highlightSong{
    return _highlightSong;
  }

  String get topSongList{
    return topSongList;
  }

  String get albumList{
    return _albumList;
  }

  String get artistDescription{
    return _artistDescription;
  }

  static ArtistViewModel getSampleData() {
    // String _artistName;
    // String _highlightSong;
    // String _topSongList;
    // String _albumList;
    // String _artistDescription;
    return ArtistViewModel("Lover","Taylor Swift", "Pop", "2019", "https://upload.wikimedia.org/wikipedia/vi/c/cd/Taylor_Swift_-_Lover.png");
  }
}