import 'package:apple_music/models/AlbumSongLIstViewModel.dart';
import 'package:apple_music/models/HScrollSquareModel.dart';
import 'package:apple_music/models/SongCardInPlaylistModel.dart';
import 'package:apple_music/pages/ArtistPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class ArtistViewModel {
  ArtistViewModel(this._artistName, this._highlightAlbum, this._topSongList, this._albumList, this._artistDescription, this._artURL) {
    id = Uuid().v4();
  }
  final String _artistName;
  final String _artURL;
  final ArtistHighlightAlbumModel _highlightAlbum;
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

  ArtistHighlightAlbumModel get highlightAlbum{
    return _highlightAlbum;
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

  static ArtistViewModel getSampleData() {
    return ArtistViewModel("Taylor Swift", ArtistHighlightAlbumModel.getSampleData(), SongCardInPlaylistModel.getSampleDataList(), HScrollSquareCardModel.getSampleData(), "Taylor Alison Swift là một nữ ca sĩ kiêm sáng tác nhạc người Mỹ. Những đĩa nhạc trải dài trên nhiều thể loại khác nhau và các sáng tác tự sự, thường lấy cảm hứng từ cuộc sống cá nhân của chính cô, đã nhận được sự tán dương rộng rãi của giới truyền thông và giới phê bình.", 'https://nld.mediacdn.vn/291774122806476800/2021/6/19/t03-16240818944771485276009.jpg');
  }
}