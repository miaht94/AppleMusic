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
  factory AlbumRectangleCardModel.fromJson(Map<String, dynamic> json) {
    return AlbumRectangleCardModel(json["_id"], json["album_name"], json["genre"], json["art_url"], json["artist"]["artist_name"]);
  }
}