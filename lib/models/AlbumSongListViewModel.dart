// import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class AlbumSongListViewModel {
  AlbumSongListViewModel(this._trackNumber, this._songName, this._value ,this._collaboration) {
    id = Uuid().v4();
  }
  String _songName;
  int _trackNumber;
  String _collaboration;
  String _value;
  late String id;

  String get songName{
    return _songName;
  }

  int get trackNumber{
    return _trackNumber;
  }

  String get collaboration{
    return _collaboration;
  }

  String get value{
    return _value;
  }

  static List<AlbumSongListViewModel> getSampleData() {
    return [
    new AlbumSongListViewModel(1, "I Forgot That You Existed", "Value", 'none') ,
    new AlbumSongListViewModel(2, "Cruel Summer", "Value", 'none'),
    new AlbumSongListViewModel(3, "Lover", "Value", 'none'),
    new AlbumSongListViewModel(4, "The Man", "Value", 'none'),
    new AlbumSongListViewModel(5, "The Archer", "Value", 'none'),
    new AlbumSongListViewModel(6, "I Think He Knows", "Value", 'none'),
    new AlbumSongListViewModel(7, "Miss Americana & The Heartbreak Prince", "Value", 'none'),
    new AlbumSongListViewModel(8, "Paper Rings", "Value", 'none'),
    new AlbumSongListViewModel(9, "Cornelia Street", "Value", 'none'),
    new AlbumSongListViewModel(10, "Death By a Thousand Cuts", "Value", 'none'),
    ];
  }

  static List<AlbumSongListViewModel> convert(json) {
    List<AlbumSongListViewModel> list = [];
    for (var object in json) {
      list.add(AlbumSongListViewModel(object['track_number']!=null ? object['track_number']  : 0 ,object['song_name'] , object['_id'], object['collaboration']!=null ? object['collaboration'] : 'none'));
      print(object['song_name'] + ' added');
    }
    list.sort((a, b) => a.trackNumber.compareTo(b.trackNumber));
    return list;
  }


}