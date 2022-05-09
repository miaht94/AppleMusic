import 'dart:convert';

import 'package:apple_music/constant.dart';
import 'package:apple_music/models/AlbumRectangleCardModel.dart';
import 'package:apple_music/models/ArtistRectangleCardModel.dart';
import 'package:apple_music/models/CredentialModel.dart';
import 'package:apple_music/models/HorizontalScrollCategoryModel.dart';
import 'package:apple_music/models/PlaylistRectangleCardModel.dart';
import 'package:apple_music/models/SongCardInPlaylistModel.dart';
import 'package:apple_music/services/http_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart'
as http;

class SearchPageModel {
  SearchPageModel() {
    searchMode = horizontalScrollCategoryModelNotifier.value.selectedElementId;
  }
  HorizontalScrollCategoryModelNotifier horizontalScrollCategoryModelNotifier = HorizontalScrollCategoryModelNotifier(HorizontalScrollCategoryModel.createDefaultModel());
  List < SongCardInPlaylistModel > searchSongModelResult = [];
  bool inSearchedMode = false;
  late String searchMode;
  String searchString = "";
  Future < List < dynamic >> ? queryResult;
  Future < List < SongCardInPlaylistModel >> querySongByName(String songName) async {
    Uri httpURI = Uri(scheme: 'http', host: SV_HOSTNAME, path: SEARCH_SONG_PATH, port: SV_PORT, queryParameters: {
      "song_name": songName
    });
    dynamic res = await http.get(httpURI);
    List < SongCardInPlaylistModel > list = [];
    JsonDecoder decoder =
      const JsonDecoder();
    List < dynamic > jsonArray = decoder.convert(res.body);
    for (Map < String, dynamic > i in jsonArray) {
      list.add(SongCardInPlaylistModel.fromJson(i));
    }
    return list;
  }

  Future < List < ArtistRectangleCardModel >> queryArtistByName(String artistName) async {
    Uri httpURI = Uri(scheme: 'http', host: SV_HOSTNAME, path: SEARCH_ARTIST_PATH, port: SV_PORT, queryParameters: {
      "artist_name": artistName,
    });
    dynamic res = await http.get(httpURI);
    List < ArtistRectangleCardModel > list = [];
    JsonDecoder decoder =
      const JsonDecoder();
    List < dynamic > jsonArray = decoder.convert(res.body);
    for (Map < String, dynamic > i in jsonArray) {
      list.add(ArtistRectangleCardModel.fromJson(i));
    }
    return list;
  }

  Future < List < PlaylistRectangleCardModel >> queryPlaylistByName(String playlist_name) async {
    Uri httpURI = Uri(scheme: 'http', host: SV_HOSTNAME, path: SEARCH_PLAYLIST_PATH, port: SV_PORT, queryParameters: {
      "playlist_name": playlist_name,
      "app_token": GetIt.I.get < CredentialModelNotifier > ().value.appToken,
      "public": "1"
    });
    dynamic res = await http.get(httpURI);
    List < PlaylistRectangleCardModel > list = [];
    JsonDecoder decoder =
      const JsonDecoder();
    List < dynamic > jsonArray = decoder.convert(res.body);
    for (Map < String, dynamic > i in jsonArray) {
      list.add(PlaylistRectangleCardModel.fromJson(i));
    }
    return list;
  }

  Future < List < AlbumRectangleCardModel >> queryAlbumByName(String albumName) async {
    Uri httpURI = Uri(scheme: 'http', host: SV_HOSTNAME, path: SEARCH_ALBUM_PATH, port: SV_PORT, queryParameters: {
      "album_name": albumName
    });
    dynamic res = await http.get(httpURI);
    List < AlbumRectangleCardModel > list = [];
    JsonDecoder decoder =
      const JsonDecoder();
    List < dynamic > jsonArray = decoder.convert(res.body);
    for (Map < String, dynamic > i in jsonArray) {
      list.add(AlbumRectangleCardModel.fromJson(i));
    }
    return list;
  }


}

class SearchPageManager extends ValueNotifier < SearchPageModel > {
  SearchPageManager(SearchPageModel value): super(value);
  void changeInSearchedMode(bool inSearchedMode) {
    value.inSearchedMode = inSearchedMode;
    notifyListeners();
  }

  void changeSearchMode(String searchMode) {

    value.horizontalScrollCategoryModelNotifier.value.selectedElementId = searchMode;
    if (value.searchMode != searchMode) {
      value.searchMode = searchMode;
      switch (value.searchMode) {
        case "song_name":
          value.queryResult = HttpUtil().searchSongModel(song_name: value.searchString) as Future < List < dynamic >> ;
          notifyListeners();
          break;
        case "artist_name":
          value.queryResult = HttpUtil().searchArtistModel(artist_name: value.searchString) as Future < List < dynamic >> ;
          notifyListeners();
          break;

        case "album_name":
          value.queryResult = HttpUtil().searchAlbumModel(album_name: value.searchString) as Future < List < dynamic >> ;
          notifyListeners();
          break;

        case "playlist_name":
          value.queryResult = HttpUtil().searchPlaylist(playlist_name: value.searchString, public: true, app_token: GetIt.I.get < CredentialModelNotifier > ().value.appToken) as Future < List < dynamic >> ;
          notifyListeners();
          break;
      }
    }

  }

  void changeSearchString(String searchString) {
    if (searchString == "") value.inSearchedMode = false;
    else value.inSearchedMode = true;
    if (value.searchString != searchString) {
      value.searchString = searchString;
      switch (value.searchMode) {
        case "song_name":
          value.queryResult = HttpUtil().searchSongModel(song_name: value.searchString) as Future < List < dynamic >> ;
          notifyListeners();
          break;
        case "artist_name":
          value.queryResult = HttpUtil().searchArtistModel(artist_name: value.searchString) as Future < List < dynamic >> ;
          notifyListeners();
          break;

        case "album_name":
          value.queryResult = HttpUtil().searchAlbumModel(album_name: value.searchString) as Future < List < dynamic >> ;
          notifyListeners();
          break;

        case "playlist_name":
          value.queryResult = HttpUtil().searchPlaylist(playlist_name: value.searchString, public: true, app_token: GetIt.I.get < CredentialModelNotifier > ().value.appToken) as Future < List < dynamic >> ;
          notifyListeners();
          break;
      }
    }

  }

  void refresh() {
    switch (value.searchMode) {
      case "song_name":
        value.queryResult = HttpUtil().searchSongModel(song_name: value.searchString) as Future < List < dynamic >> ;
        notifyListeners();
        break;
      case "artist_name":
        value.queryResult = HttpUtil().searchArtistModel(artist_name: value.searchString) as Future < List < dynamic >> ;
        notifyListeners();
        break;

      case "album_name":
        value.queryResult = HttpUtil().searchAlbumModel(album_name: value.searchString) as Future < List < dynamic >> ;
        notifyListeners();
        break;

      case "playlist_name":
        value.queryResult = HttpUtil().searchPlaylist(playlist_name: value.searchString, public: true, app_token: GetIt.I.get < CredentialModelNotifier > ().value.appToken) as Future < List < dynamic >> ;
        notifyListeners();
        break;
    }
  }

  // void changeSelectedElementId(String selectedElementId) {
  //     value.horizontalScrollCategoryModel.selectedElementId = selectedElementId;
  //     notifyListeners();
  // }
}