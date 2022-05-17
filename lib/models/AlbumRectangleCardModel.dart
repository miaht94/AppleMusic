class AlbumRectangleCardModel {
  AlbumRectangleCardModel(this._albumId, this._albumName, this._genre, this._artURL, this._artistName);
  String _albumName;
  String _albumId;
  String _genre;
  String _artURL;
  String _artistName;
  String get albumName {
    return _albumName;
  }
  String get albumId {
    return _albumId;
  }
  String get genre {
    return _genre;
  }
  String get artURL {
    return _artURL;
  }
  String get artistName {
    return _artistName;
  }
  // ignore: sort_constructors_first
  factory AlbumRectangleCardModel.fromJson(Map<String, dynamic> json) {
    return AlbumRectangleCardModel(json['_id'], json['album_name'], json['genre'], json['art_url'], json['artist']['artist_name']);
  }

  static List<AlbumRectangleCardModel> getSampleData() {
    return [
      AlbumRectangleCardModel('123456', 'Red', 'Pop', 'https://avatar-ex-swe.nixcdn.com/song/2018/05/21/6/e/e/1/1526887767068_640.jpg', 'Taylor Swift'),
      AlbumRectangleCardModel('123456', 'Red', 'Pop', 'https://avatar-ex-swe.nixcdn.com/song/2018/05/21/6/e/e/1/1526887767068_640.jpg', 'Taylor Swift'),
      AlbumRectangleCardModel('123456', 'Red', 'Pop', 'https://avatar-ex-swe.nixcdn.com/song/2018/05/21/6/e/e/1/1526887767068_640.jpg', 'Taylor Swift'),
      AlbumRectangleCardModel('123456', 'Red', 'Pop', 'https://avatar-ex-swe.nixcdn.com/song/2018/05/21/6/e/e/1/1526887767068_640.jpg', 'Taylor Swift'),
      AlbumRectangleCardModel('123456', 'Red', 'Pop', 'https://avatar-ex-swe.nixcdn.com/song/2018/05/21/6/e/e/1/1526887767068_640.jpg', 'Taylor Swift'),
    ];

  }
}