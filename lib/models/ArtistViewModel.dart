import 'dart:convert';

import 'package:apple_music/constant.dart';
import 'package:apple_music/models/HScrollSquareModel.dart';
import 'package:apple_music/models/SongCardInPlaylistModel.dart';
import 'package:apple_music/models_refactor/SongModel.dart';
import 'package:apple_music/pages/ArtistPage.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class ArtistModel {
  ArtistModel(this._artistName, this._highlightSong, this._topSongList, this._albumList, this._artistDescription, this._artURL) {
    id = const Uuid().v4();
  }
  final String _artistName;
  final String _artURL;
  final ArtistHighlightSongModel _highlightSong;
  final List<SongModel> _topSongList;
  final List<HScrollSquareCardModel> _albumList;
  final String _artistDescription;
  late String id;

  String get artistName{
    return _artistName;
  }

  String get artURL{
    return _artURL;
  }

  ArtistHighlightSongModel get highlightSong{
    return _highlightSong;
  }

  List<SongModel> get topSongList{
    return _topSongList;
  }

  List<HScrollSquareCardModel> get albumList{
    return _albumList;
  }

  String get artistDescription{
    return _artistDescription;
  }

  // ignore: inference_failure_on_untyped_parameter
  static Future<ArtistModel> getArtist(artn) async {
    try {
      final Uri httpURI = Uri(scheme: 'http', host: SV_HOSTNAME, port: SV_PORT, path: ARTIST_PATH, queryParameters: {
        'artist_name': artn
      });
      final  response = await http.get(httpURI);
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (kDebugMode) {
          print(result['artist_name']);
        }
        final ArtistHighlightSongModel highlightSong = result['highlight_song'] != null ? await ArtistHighlightSongModel.getHighlightSongByID(result['highlight_song']['_id']) : ArtistHighlightSongModel('NoHighlightSong', '', 0, '', '');
        final List<SongModel> topSongList = await SongCardInPlaylistModel.convert(result['top_song_list']);
        final List<HScrollSquareCardModel> albumList = await HScrollSquareCardModel.convert(result['album_list']);
        final ArtistModel convertedResult = ArtistModel(
            result['artist_name'],
            highlightSong,
            topSongList,
            albumList,
            result['artist_description'],
            result['artist_image_url']
        );
        // print(convertedResult.albumName);
        return convertedResult;
      } else {
        throw Exception('Failed to Load');
      }
    } catch (execute)  {
      if (kDebugMode) {
        print('$execute');
      }
      return ArtistModel('ArtistError', ArtistHighlightSongModel.getSampleData(), SongCardInPlaylistModel.getSampleDataList(), HScrollSquareCardModel.getSampleData(), '', '');
    }
  }

  // ignore: prefer_constructors_over_static_methods
  static ArtistModel getSampleData() {
    return ArtistModel('Taylor Swift', ArtistHighlightSongModel.getSampleData(), SongCardInPlaylistModel.getSampleDataList(), HScrollSquareCardModel.getSampleData(), 'Taylor Alison Swift là một nữ ca sĩ kiêm sáng tác nhạc người Mỹ. Những đĩa nhạc trải dài trên nhiều thể loại khác nhau và các sáng tác tự sự, thường lấy cảm hứng từ cuộc sống cá nhân của chính cô, đã nhận được sự tán dương rộng rãi của giới truyền thông và giới phê bình.', 'https://nld.mediacdn.vn/291774122806476800/2021/6/19/t03-16240818944771485276009.jpg');
  }
}