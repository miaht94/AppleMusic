import 'package:flutter/foundation.dart';

class ArtistRectangleCardModel {
    ArtistRectangleCardModel(this._artistId, this._artistName, this._artistDescription, this._artistImageURL);
    String _artistId;
    String _artistName;
    String _artistDescription;
    String _artistImageURL;

    String get artistName {
        return _artistName;
    }

    String get artistId {
        return _artistId;
    }

    String get artistDescription {
        return _artistDescription;
    }

    String get artistImageURL {
        return _artistImageURL;
    }
    factory ArtistRectangleCardModel.fromJson(Map<String, dynamic> json) {
        return ArtistRectangleCardModel(json['_id'], json['artist_name'], json['artist_description'], json['artist_image_url']);
    }
}