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
  // ignore: unnecessary_getters_setters
  String get title {
    return _title;
  }
  // ignore: unnecessary_getters_setters
  String get description {
    return _description;
  }
  // ignore: unnecessary_getters_setters
  Color get footerColor {
    return _footerColor;
  }
  // ignore: unnecessary_getters_setters
  String get imagePath {
    return _imagePath;
  }

  set title(String title) {
    _title = title;
  }

  set description(String description) {
    _description = description;
  }

  set footerColor(Color footerColor) {
    _footerColor = footerColor;
  }

  set imagePath(String imagePath) {
    _imagePath = imagePath;
  }


}