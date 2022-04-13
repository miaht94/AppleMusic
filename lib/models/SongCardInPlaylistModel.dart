import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class SongCardInPlaylistModel {
  SongCardInPlaylistModel(this._songName, this._songArtist, this._artURL) {
    id = Uuid().v4();
  }
  String _songName;
  String _songArtist;
  String _artURL;
  late String id;

  String get songName{
    return _songName;
  }

  String get songArtist{
    return _songArtist;
  }

  String get artURL{
    return _artURL;
  }

  static SongCardInPlaylistModel getSampleData() {
    return new SongCardInPlaylistModel("Lover", "Taylor Swift", "https://upload.wikimedia.org/wikipedia/vi/c/cd/Taylor_Swift_-_Lover.png");
  }
}