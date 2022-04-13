import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class HScrollSquareCardModel {
  HScrollSquareCardModel(this._albumName, this._albumArtist, this._artURL) {
    id = Uuid().v4();
  }
  String _albumName;
  String _albumArtist;
  String _artURL;

  late String id;

  String get albumName {
    return _albumName;
  }

  String get albumArtist {
    return _albumArtist;
  }

  String get artURL {
    return _artURL;
  }

  static List<HScrollSquareCardModel> getSampleData() {
    return [
      new HScrollSquareCardModel("Lover", "Taylor Swift", "https://upload.wikimedia.org/wikipedia/vi/c/cd/Taylor_Swift_-_Lover.png"),
      new HScrollSquareCardModel("Red", "Taylor Swift", "https://upload.wikimedia.org/wikipedia/vi/c/cd/Taylor_Swift_-_Lover.png"),
      new HScrollSquareCardModel("At my worst", "Pink Sweat", "https://avatar-ex-swe.nixcdn.com/song/2020/09/15/3/7/8/3/1600184151280_640.jpg"),
      new HScrollSquareCardModel("Boulevard Of Broken Dreams", "Green Day", "https://images.genius.com/d8a68a3aac2ab79bd4d4c5ee33fd69fa.1000x1000x1.png")
    ];
  }
}