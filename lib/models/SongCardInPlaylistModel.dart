import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class SongCardInPlaylistModel {
    SongCardInPlaylistModel(this._songName, this._artistName, this._artURL) {
        id = Uuid().v4();
    }
    String _songName;
    String _artURL;
    String _artistName;
    late String id;

    String get songName {
        return _songName;
    }

    String get artistName {
        return _artistName;
    }

    String get artURL {
        return _artURL;
    }

    static SongCardInPlaylistModel getSampleDataSingle() {
        return new SongCardInPlaylistModel("Lover", "Taylor Swift", "https://upload.wikimedia.org/wikipedia/vi/c/cd/Taylor_Swift_-_Lover.png");
    }

    static List < SongCardInPlaylistModel > getSampleDataList() {
        return [
            new SongCardInPlaylistModel("Lover", "Taylor Swift", "https://upload.wikimedia.org/wikipedia/vi/c/cd/Taylor_Swift_-_Lover.png"),
            new SongCardInPlaylistModel("Red (Taylor's Version)", "Taylor Swift", "https://nld.mediacdn.vn/291774122806476800/2021/6/19/t03-16240818944771485276009.jpg"),
            new SongCardInPlaylistModel("Everything Has Changed", "Taylor Swift, Ed Sheeran", "https://nld.mediacdn.vn/291774122806476800/2021/6/19/t03-16240818944771485276009.jpg"),
            new SongCardInPlaylistModel("cardigan", "Taylor Swift", "https://upload.wikimedia.org/wikipedia/vi/f/f8/Taylor_Swift_-_Folklore.png"),
            new SongCardInPlaylistModel("Everything Has Changed", "Taylor Swift, Ed Sheeran", "https://nld.mediacdn.vn/291774122806476800/2021/6/19/t03-16240818944771485276009.jpg")
        ];
    }

    factory SongCardInPlaylistModel.fromJson(Map<String, dynamic> json) {
        return new SongCardInPlaylistModel(json["song_name"], json["artist"]["artist_name"], json["album"]["art_url"]);
    }
}
//
// var sampleData = [
//   {
//     "artist_name": "Taylor Swift",
//     "song_name": "Lover",
//     "art_url":
//     "https://upload.wikimedia.org/wikipedia/vi/c/cd/Taylor_Swift_-_Lover.png"
//   },
//   {
//     "artist_name": "Taylor Swift",
//     "song_name": "Red",
//     "art_url":
//     "https://nld.mediacdn.vn/291774122806476800/2021/6/19/t03-16240818944771485276009.jpg"
//   },
//   {
//     "artist_name": "Taylor Swift, Ed Sheeran",
//     "song_name": "Everything Has Changed",
//     "art_url":
//     "https://nld.mediacdn.vn/291774122806476800/2021/6/19/t03-16240818944771485276009.jpg"
//   },
//   {
//     "artist_name": "Taylor Swift",
//     "song_name": "cardigan",
//     "art_url":
//     "https://upload.wikimedia.org/wikipedia/vi/f/f8/Taylor_Swift_-_Folklore.png"
//   }
// ];