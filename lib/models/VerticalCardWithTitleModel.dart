import 'dart:ui';

import 'package:apple_music/models_refactor/PlaylistModel.dart';

class VerticalCardWithTitleModel {
  VerticalCardWithTitleModel(this.playlistModel,  Color footerColor) {
    _title = playlistModel.playlist_name;
    _description = playlistModel.playlist_description;
    _footerColor = footerColor;
    _imagePath = playlistModel.art_url;
  }
  final PlaylistModel playlistModel;
  late String _title;
  late String _description;
  late Color _footerColor;
  late String _imagePath;
  String get title {
    return _title;
  }

  String get description {
    return _description;
  }

  Color get footerColor {
    return _footerColor;
  }

  String get imagePath {
    return _imagePath;
  }

  void set title(String title) {
    _title = title;
  }

  void set description(String description) {
    _description = description;
  }

  void set footerColor(Color footerColor) {
    _footerColor = footerColor;
  }

  void set imagePath(String imagePath) {
    _imagePath = imagePath;
  }


}