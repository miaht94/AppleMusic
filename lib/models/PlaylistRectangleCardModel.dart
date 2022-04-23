class PlaylistRectangleCardModel {
  PlaylistRectangleCardModel(this._playlistId, this._playlistName, this._playlistDescription, this._artURL);
  String _playlistId;
  String _playlistName;
  String _playlistDescription;
  String _artURL;

  String get playlistId {
    return _playlistId;
  }

  String get playlistName {
    return _playlistName;
  }

  String get artURL {
    return _artURL;
  }

  String get playlistDescription {
    return _playlistDescription;
  }

  factory PlaylistRectangleCardModel.fromJson(Map<String, dynamic> json) {
    return PlaylistRectangleCardModel(json["_id"], json["playlist_name"], json["playlist_description"], json["art_url"]);
  }
}