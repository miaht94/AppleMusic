// import 'dart:js';


import 'package:flutter/foundation.dart';

class AlbumSongListViewModel {
  AlbumSongListViewModel(this._trackNumber, this._songName, this._id ,this._collaboration);

  final String _songName;
  final int _trackNumber;
  final String _collaboration;
  final String _id;

  String get songName{
    return _songName;
  }

  int get trackNumber{
    return _trackNumber;
  }

  String get collaboration{
    return _collaboration;
  }

  String get id{
    return _id;
  }

  static List<AlbumSongListViewModel> getSampleData() {
    return [
    AlbumSongListViewModel(1, 'I Forgot That You Existed', 'Value', 'none') ,
    AlbumSongListViewModel(2, 'Cruel Summer', 'Value', 'none'),
    AlbumSongListViewModel(3, 'Lover', 'Value', 'none'),
    AlbumSongListViewModel(4, 'The Man', 'Value', 'none'),
    AlbumSongListViewModel(5, 'The Archer', 'Value', 'none'),
    AlbumSongListViewModel(6, 'I Think He Knows', 'Value', 'none'),
    AlbumSongListViewModel(7, 'Miss Americana & The Heartbreak Prince', 'Value', 'none'),
    AlbumSongListViewModel(8, 'Paper Rings', 'Value', 'none'),
    AlbumSongListViewModel(9, 'Cornelia Street', 'Value', 'none'),
    AlbumSongListViewModel(10, 'Death By a Thousand Cuts', 'Value', 'none'),
    ];
  }

  // ignore: inference_failure_on_untyped_parameter
  static List<AlbumSongListViewModel> convert(json) {
    final List<AlbumSongListViewModel> list = [];
    for (final object in json) {
      list.add(AlbumSongListViewModel(object['track_number'] ?? 0 ,object['song_name'] , object['_id'], object['collaboration'] ?? 'none'));
      if (kDebugMode) {
        print(object['song_name'] + ' added');
      }
    }
    list.sort((a, b) => a.trackNumber.compareTo(b.trackNumber));
    return list;
  }


}