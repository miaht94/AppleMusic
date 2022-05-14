import 'dart:convert' show JsonDecoder;

import 'package:apple_music/constant.dart';
import 'package:apple_music/models/HScrollCircleModel.dart';
import 'package:apple_music/models/HScrollSquareModel.dart';
import 'package:apple_music/models/HorizontalCardWithTitleModel.dart';
import 'package:apple_music/models/SongCardInPlaylistModel.dart';
import 'package:apple_music/models_refactor/SongModel.dart';
import 'package:apple_music/services/http_util.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

class DiscoveryPageModel {

  List<HorizontalCardWithTitleModel> newAlbums = [];
  List<HScrollSquareCardModel> doNotMiss = [];
  List<HScrollCircleCardModel> listFavoriteArtist = [];
  List<SongModel> bestNewSongs = [];

  ValueNotifier<bool> isNewAlbumsDone = ValueNotifier<bool>(false);
  ValueNotifier<bool> isDoNotMissDone = ValueNotifier<bool>(false);
  ValueNotifier<bool> isListFavoriteArtistDone = ValueNotifier<bool>(false);
  ValueNotifier<bool> isBestNewSongsDone = ValueNotifier<bool>(false);
  late DiscoveryItem listIdItem;

  bool isInit = false;

  void init() async{
    listIdItem = await fetchDiscoveryModelPage();
    await initNewAlbums();
    await initDoNotMiss();
    await initListFavoriteArtist();
    await initBestNewSongs();
    isInit = true;
  }

  Future <DiscoveryItem> fetchDiscoveryModelPage() async {
    final Uri httpURI = Uri(scheme: 'http',
        host: SV_HOSTNAME,
        port: SV_PORT,
        path: PAGE_PATH,
        queryParameters: {
          'page_name': 'DiscoveryPage'
        });
    http.Client client = GetIt.I.get<http.Client>();
    final response = await client.get(httpURI);
    if (response.statusCode == 200) {
      const JsonDecoder decoder = JsonDecoder();
      return DiscoveryItem.fromJson(decoder.convert(response.body));
    } else {
      return Future.error('Can get page');
    }
  }

  Future<void> initNewAlbums() async {
    // fetch best choice playlist
    for(String id in listIdItem.newAlbums){
      final album = await HttpUtil().getAlbumModel(
        id: id,
      );
      if (!isTestingMode && album != null) {
        newAlbums.add(HorizontalCardWithTitleModel(
            album
        ));
      } else {
        if (album != null) {
          newAlbums.add(HorizontalCardWithTitleModel(
              album
          ));
        }
      }
    }
    isNewAlbumsDone.value = true;
  }


  Future<void> initDoNotMiss() async{
    // fetch Recently played
    for(String id in listIdItem.doNotMiss){
      final song = await HttpUtil().fetchSongModel(id);
      if (song != null) {
        doNotMiss.add(HScrollSquareCardModel(
            song.song.song_name,
            song.song.artist.artist_name,
            song.song.album.art_url,
            song.song.id
        ));
      }
    }
    isDoNotMissDone.value = true;
  }

  Future<void> initListFavoriteArtist() async{
    // fetch Favorite Artist
    try{
      for(String id in listIdItem.listFavoriteArtist){
        final artist = await HttpUtil().fetchArtistModel(id: id);
        if (artist != null) {
          listFavoriteArtist.add(HScrollCircleCardModel(
            artist.artist_name,
            artist.artist_image_url,
          ));
        }
      }
      isListFavoriteArtistDone.value = true;
    } catch(e){
      if (kDebugMode) {
        print('error in get list favorite artist $e');
      }
    }

  }

  Future<void> initBestNewSongs() async{
    // fetch Recently played
    for(String id in listIdItem.bestNewSongs){
      final song = await HttpUtil().fetchSongModel(id);
      if (song != null) {
        bestNewSongs.add(song.song);
      }
    }
    isBestNewSongsDone.value = true;
  }


}

class DiscoveryItem{

  DiscoveryItem(
      this.newAlbums,
      this.doNotMiss,
      this.listFavoriteArtist,
      this.bestNewSongs
      );

  List<String> newAlbums;
  List<String> doNotMiss;
  List<String> listFavoriteArtist;
  List<String> bestNewSongs;

  factory DiscoveryItem.fromJson(Map<String, dynamic> json) {
    var a =  DiscoveryItem(
      List<String>.from(json['new_albums']),
      List<String>.from(json['do_not_miss']),
      List<String>.from(json['favorite_artist']),
      List<String>.from(json['best_new_song']),
    );
    return a;
  }
}
