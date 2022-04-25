import 'dart:convert';

import 'package:apple_music/constant.dart';
import 'package:apple_music/models/AlbumSongLIstViewModel.dart';
import 'package:apple_music/models/HScrollSquareModel.dart';
import 'package:apple_music/models/SongCardInPlaylistModel.dart';
import 'package:apple_music/pages/ArtistPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class ArtistViewModel {
  ArtistViewModel(this._artistName, this._highlightSong, this._topSongList, this._albumList, this._artistDescription, this._artURL) {
    id = Uuid().v4();
  }
  final String _artistName;
  final String _artURL;
  final ArtistHighlightSongModel _highlightSong;
  final List<SongCardInPlaylistModel> _topSongList;
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

  List<SongCardInPlaylistModel> get topSongList{
    return _topSongList;
  }

  List<HScrollSquareCardModel> get albumList{
    return _albumList;
  }

  String get artistDescription{
    return _artistDescription;
  }

  static Future<ArtistViewModel> getArtist(artn) async {
    try {
      final Uri httpURI = Uri(scheme: 'http', host: SV_HOSTNAME, port: SV_PORT, path: ARTIST_PATH, queryParameters: {
        'artist_name': artn
      });
      final  response = await http.get(httpURI);
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        print(result['artist_name']);
        ArtistHighlightSongModel highlightSong = result["highlight_song"] != null ? await ArtistHighlightSongModel.getHighlightSongByID(result["highlight_song"]["_id"]) : ArtistHighlightSongModel("NoHighlightSong", "", 0, "", "");
        List<SongCardInPlaylistModel> topSongList = await SongCardInPlaylistModel.convert(result["top_song_list"]);
        List<HScrollSquareCardModel> albumList = await HScrollSquareCardModel.convert(result["album_list"]);
        ArtistViewModel convertedResult = ArtistViewModel(
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
        throw Exception("Failed to Load");
      }
    } catch (execute)  {
      print("$execute");
      return ArtistViewModel("ArtistError", ArtistHighlightSongModel.getSampleData(), SongCardInPlaylistModel.getSampleDataList(), HScrollSquareCardModel.getSampleData(), "", '');
    }
  }

  static ArtistViewModel getSampleData() {
    return ArtistViewModel("Taylor Swift", ArtistHighlightSongModel.getSampleData(), SongCardInPlaylistModel.getSampleDataList(), HScrollSquareCardModel.getSampleData(), "Taylor Alison Swift là một nữ ca sĩ kiêm sáng tác nhạc người Mỹ. Những đĩa nhạc trải dài trên nhiều thể loại khác nhau và các sáng tác tự sự, thường lấy cảm hứng từ cuộc sống cá nhân của chính cô, đã nhận được sự tán dương rộng rãi của giới truyền thông và giới phê bình.", 'https://nld.mediacdn.vn/291774122806476800/2021/6/19/t03-16240818944771485276009.jpg');
  }
}