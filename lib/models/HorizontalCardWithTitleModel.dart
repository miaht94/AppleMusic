import 'package:apple_music/models_refactor/AlbumModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class HorizontalCardWithTitleModel {
    HorizontalCardWithTitleModel(this.albumModel) {
      _category = 'Album mới';
      _primaryImagePath = albumModel.art_url;
      _secondaryImagePath = albumModel.artist.artist_image_url;
      _primaryDes = albumModel.genre;
      _secondaryDes = (albumModel.album_description != null) ? albumModel.album_description! : albumModel.artist.artist_description;
      _title = albumModel.album_name;
      id = albumModel.id;
    }
    AlbumModel albumModel;
    late String _title;
    late String _primaryImagePath;
    late String _secondaryImagePath;
    late String _primaryDes;
    late String _secondaryDes;
    late String _category;
    late String id;

    String get title {
        return _title;
    }

    String get primaryImagePath {
        return _primaryImagePath;
    }

    String get secondaryImagePath {
        return _secondaryImagePath;
    }

    String get primaryDes {
        return _primaryDes;
    }

    String get secondaryDes {
        return _secondaryDes;
    }
    
    String get category {
      return _category;
    }

}