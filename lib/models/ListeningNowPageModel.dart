import 'dart:convert';

import 'package:apple_music/constant.dart';
import 'package:apple_music/models/ArtistModel.dart';
import 'package:apple_music/models/HScrollCircleModel.dart';
import 'package:apple_music/models/HScrollSquareModel.dart';
import 'package:apple_music/models/PlaylistModel.dart';
import 'package:apple_music/models/SongModel.dart';
import 'package:apple_music/models/VerticalCardWithTitleModel.dart';
import 'package:flutter/material.dart';
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
        final playlist = await PlaylistModel.fetchPlaylist(id);
        listBestChoice.add(VerticalCardWithTitleModel(
            playlist.playlistName,
            playlist.playlistDescription,
            playlist.artUrl,
          await getImagePalette(NetworkImage(playlist.artUrl)),
        ));
    }
    // fetch Recently played
    for(String id in listIdItem.listRencentlyPlayed){
        final song = await SongModel.fetchSong(id);
        listRencentlyPlayed.add(HScrollSquareCardModel(
            song.songName,
            song.artist,
            song.artwork,
            song.id
        ));
    }
    // fetch Favorite Artist
    for(String id in listIdItem.listFavoriteArtist){
        final artist = await ArtistModel.fetchArtist(id);
        listFavoriteArtist.add(HScrollCircleCardModel(
          artist.name,
          artist.imageUrl,
        ));
    }
    // fetch Year-end replays
    for(String id in listIdItem.listYearEndReplays){
        final playlist = await PlaylistModel.fetchPlaylist(id);
        listYearEndReplays.add(VerticalCardWithTitleModel(
          playlist.playlistName,
          playlist.playlistDescription,
          playlist.artUrl,
          await getImagePalette(NetworkImage(playlist.artUrl)),
        ));
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
    final response = await http.get(httpURI);
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
