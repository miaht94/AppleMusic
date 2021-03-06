import 'dart:convert';

import 'package:apple_music/constant.dart';
import 'package:apple_music/models/CredentialModel.dart';
import 'package:apple_music/models/HScrollSquareModel.dart';
import 'package:apple_music/models/VerticalCardWithTitleModel.dart';
import 'package:apple_music/models_refactor/AlbumModel.dart';
import 'package:apple_music/models_refactor/ArtistModel.dart';
import 'package:apple_music/services/http_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:palette_generator/palette_generator.dart';

class ListeningNowPageModel {

  List<VerticalCardWithTitleModel> listBestChoice = [];
  List<HScrollSquareCardModel> listRencentlyPlayed = [];
  List<AlbumModel> listRencentlyPlayedRaw = [];
  List<ArtistModel> listFavoriteArtist = [];
  List<VerticalCardWithTitleModel> listYearEndReplays = [];

  ValueNotifier<bool> isListBestChoiceDone = ValueNotifier<bool>(false);
  ValueNotifier<bool> isListRencentlyPlayedDone = ValueNotifier<bool>(false);
  ValueNotifier<bool> isListFavoriteArtistDone = ValueNotifier<bool>(false);
  ValueNotifier<bool> isListYearEndReplaysDone = ValueNotifier<bool>(false);
  late ListeningNowItem listIdItem;

  bool isInit = false;

  // ignore: avoid_void_async
  void init() async{
    listIdItem = await fetchLiteningModelPage();
    await inItListBestChoice();
    await inItListRencentlyPlayed();
    await inItListFavoriteArtist();
    await inItListYearEndReplays();
    isInit = true;
  }

  Future<Color> getImagePalette (ImageProvider imageProvider) async {
    final PaletteGenerator paletteGenerator = await PaletteGenerator
        .fromImageProvider(imageProvider);
    return paletteGenerator.dominantColor!.color;
  }

  Future <ListeningNowItem> fetchLiteningModelPage() async {
    final Uri httpURI = Uri(scheme: 'http',
        host: SV_HOSTNAME,
        port: SV_PORT,
        path: PAGE_PATH,
        queryParameters: {
          'page_name': 'ListeningNow'
        });
    final http.Client client = GetIt.I.get<http.Client>();
    final response = await client.get(httpURI);
    if (response.statusCode == 200) {
      const JsonDecoder decoder = JsonDecoder();
      return ListeningNowItem.fromJson(decoder.convert(response.body));
    } else {
      return Future.error('Can get page');
    }
  }

  Future<void> inItListBestChoice() async {
    // fetch best choice playlist
    for(final String id in listIdItem.listBestChoice){
      final playlist = await HttpUtil().getPlaylistModel(
        app_token: GetIt.I.get<CredentialModelNotifier>().value.appToken,
        id: id,
        public: true,
      );
      if (!isTestingMode && playlist != null) {
        listBestChoice.add(VerticalCardWithTitleModel(
          playlist,
          await getImagePalette(NetworkImage(playlist.art_url)),
        ));
      } else {
        if (playlist != null) {
          listBestChoice.add(VerticalCardWithTitleModel(
              playlist,
              Colors.black.withOpacity(0.2)
          ));
        }
      }
    }
    isListBestChoiceDone.value = true;
  }


  Future<void> inItListRencentlyPlayed() async{
    // fetch Recently played
    for(final String id in listIdItem.listRencentlyPlayed){
      final album = await HttpUtil().getAlbumModel(id: id);
      if (album != null) {
        listRencentlyPlayedRaw.add(album);
        listRencentlyPlayed.add(HScrollSquareCardModel(
          album.album_name,
          album.artist.artist_name,
          album.art_url,
          album.id
        ));
      }
    }
    isListRencentlyPlayedDone.value = true;
  }

  Future<void> inItListFavoriteArtist() async{
    // fetch Favorite Artist
    try{
      for(final String id in listIdItem.listFavoriteArtist){
      final artist = await HttpUtil().fetchArtistModel(id: id);
      if (artist != null) {
        listFavoriteArtist.add(artist);
      }
    }
    isListFavoriteArtistDone.value = true;
    } catch(e){
      if (kDebugMode) {
        print('error in get list favorite artist $e');
      }
    }

  }

  Future<void> inItListYearEndReplays() async{
    // fetch Year-end replays
    for(final String id in listIdItem.listYearEndReplays){
      final playlist = await HttpUtil().getPlaylistModel(
        app_token: GetIt.I.get<CredentialModelNotifier>().value.appToken,
        id: id,
        public: true,
      );
      if (!isTestingMode && playlist != null) {
        listYearEndReplays.add(VerticalCardWithTitleModel(
          playlist,
          await getImagePalette(NetworkImage(playlist.art_url)),
        ));
      } else {
        if (playlist != null) {
          listYearEndReplays.add(VerticalCardWithTitleModel(
            playlist,
            Colors.black.withOpacity(0.2),
          ));
        }
      }
    }
    isListYearEndReplaysDone.value = true;
  }


}

class ListeningNowItem{

  ListeningNowItem(
  this.listBestChoice,
  this.listRencentlyPlayed,
  this.listFavoriteArtist,
  this.listYearEndReplays
  );

  List<String> listBestChoice;
  List<String> listRencentlyPlayed;
  List<String> listFavoriteArtist;
  List<String> listYearEndReplays;

  // ignore: sort_constructors_first
  factory ListeningNowItem.fromJson(Map<String, dynamic> json) {
    final a =  ListeningNowItem(
      List<String>.from(json['best_choice']),
      List<String>.from(json['rencently_played']),
      List<String>.from(json['favorite_artist']),
      List<String>.from(json['year_end_replays']),
    );
    return a;
  }
}
