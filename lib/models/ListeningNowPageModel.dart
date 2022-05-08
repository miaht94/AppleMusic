import 'dart:convert';

import 'package:apple_music/constant.dart';
import 'package:apple_music/models/ArtistModel.dart';
import 'package:apple_music/models/CredentialModel.dart';
import 'package:apple_music/models/HScrollCircleModel.dart';
import 'package:apple_music/models/HScrollSquareModel.dart';
import 'package:apple_music/models/PlaylistModel.dart';
import 'package:apple_music/models/SongModel.dart';
import 'package:apple_music/models/VerticalCardWithTitleModel.dart';
import 'package:apple_music/services/http_util.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:palette_generator/palette_generator.dart';

class ListeningNowPageModel {

  List<VerticalCardWithTitleModel> listBestChoice = [];
  List<HScrollSquareCardModel> listRencentlyPlayed = [];
  List<HScrollCircleCardModel> listFavoriteArtist = [];
  List<VerticalCardWithTitleModel> listYearEndReplays = [];
  late Future<bool> isDone;
  bool isInit = false;

  void init(){
    isDone = initModel();
    isInit = true;
  }

  Future<bool> initModel() async {
    ListeningNowItem listIdItem;
    try{
       listIdItem = await fetchLiteningModelPage();
    // fetch best choice playlist
    for(String id in listIdItem.listBestChoice){
        final playlist = await HttpUtil().getPlaylistModel(
            app_token: GetIt.I.get<CredentialModelNotifier>().value.appToken,
            id: id,
            public: true,
        );
        if (!isTestingMode && playlist != null) {
          listBestChoice.add(VerticalCardWithTitleModel(
            playlist.playlist_name,
            playlist.playlist_description,
            playlist.art_url,
          await getImagePalette(NetworkImage(playlist.art_url)),
        ));
        } else {
          if (playlist != null) {
            listBestChoice.add(VerticalCardWithTitleModel(
              playlist.playlist_name,
              playlist.playlist_description,
              playlist.art_url,
              Colors.black.withOpacity(0.2)
                    ));
          }
        }
        
    }
    // fetch Recently played
    for(String id in listIdItem.listRencentlyPlayed){
        final song = await HttpUtil().fetchSongModel(id);
        if (song != null) {
          listRencentlyPlayed.add(HScrollSquareCardModel(
              song.song.song_name,
              song.song.artist.artist_name,
              song.song.album.art_url,
              song.song.id
          ));
        }
    }
    // fetch Favorite Artist
    for(String id in listIdItem.listFavoriteArtist){
        final artist = await HttpUtil().fetchArtistModel(id: id);
        if (artist != null) {
          listFavoriteArtist.add(HScrollCircleCardModel(
            artist.artist_name,
            artist.artist_image_url,
          ));
        }
    }
    // fetch Year-end replays
    for(String id in listIdItem.listYearEndReplays){
        final playlist = await HttpUtil().getPlaylistModel(
            app_token: GetIt.I.get<CredentialModelNotifier>().value.appToken,
            id: id,
            public: true,
        );
        if (!isTestingMode && playlist != null) {
        if (playlist != null) {
          listYearEndReplays.add(VerticalCardWithTitleModel(
            playlist.playlist_name,
            playlist.playlist_description,
            playlist.art_url,
            await getImagePalette(NetworkImage(playlist.art_url)),
          ));
        }
        } else {
          if (playlist != null) {
            listYearEndReplays.add(VerticalCardWithTitleModel(
            playlist.playlist_name,
            playlist.playlist_description,
            playlist.art_url,
            Colors.black.withOpacity(0.2),
                    ));
          }
        }
    }
    }catch (e){
      print(e);
    }
    return true;
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
    http.Client client = GetIt.I.get<http.Client>();
    final response = await client.get(httpURI);
    if (response.statusCode == 200) {
      const JsonDecoder decoder = JsonDecoder();
      return ListeningNowItem.fromJson(decoder.convert(response.body));
    } else {
      return Future.error('Can get page');
    }
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

  factory ListeningNowItem.fromJson(Map<String, dynamic> json) {
    var a =  ListeningNowItem(
      List<String>.from(json['best_choice']),
      List<String>.from(json['rencently_played']),
      List<String>.from(json['favorite_artist']),
      List<String>.from(json['year_end_replays']),
    );
    return a;
  }
}
