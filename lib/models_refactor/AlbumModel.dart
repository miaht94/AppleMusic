


class AlbumModel {
  AlbumModel({required this.id, required this.album_name, required this.genre, required this.album_year, required this.art_url, required this.songs, required this.artist, this.album_description});
  String id;
  String album_name;
  String genre;
  String ? album_description;
  String art_url;
  int album_year;
  ArtistInAlbumModel artist;
  List<SongInAlbumModel> songs;
  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    List<SongInAlbumModel> songs = [];
    for (Map<String, dynamic> i in json['songs']) {
      songs.add(SongInAlbumModel.fromJson(i));
    }
    AlbumModel newAlbum = AlbumModel(
      id: json['_id'], 
      album_name: json['album_name'], 
      genre: json['genre'], 
      album_year: json['album_year'],
      album_description: json['album_description'],
      art_url: json['art_url'], 
      songs: songs,
      artist: ArtistInAlbumModel.fromJson(json['artist'] as Map<String, dynamic>)
    );
    return newAlbum;
  }
  static List<AlbumModel> getSampleAlbum() {
    return [
      AlbumModel.fromJson(sampleAlbumJson),
      AlbumModel.fromJson(sampleAlbumJson),
      AlbumModel.fromJson(sampleAlbumJson),
    ];
  }
}

class SongInAlbumModel {
  SongInAlbumModel({required this.id, required this.song_name, this.track_number, this.collaboration, required this.lyric_key, required this.song_key});
  String id;
  String song_name;
  int? track_number;
  String? collaboration;
  String song_key;
  String lyric_key;
  factory SongInAlbumModel.fromJson(Map<String, dynamic> json) {
    SongInAlbumModel newSong = SongInAlbumModel(
      id: json['_id'], 
      song_name: json['song_name'], 
      song_key: json['song_key'], 
      lyric_key: json['lyric_key'],
      track_number: json['track_number'],
      collaboration: json['collaboration']
    );
    return newSong;
  }
}

class ArtistInAlbumModel {
  ArtistInAlbumModel({required this.id, required this.artist_name, required this.artist_description, required this.album_list_id, required this.artist_image_url, this.artist_video_url, this.highlight_song_id, required this.top_song_list_id});
  String id;
  String artist_name;
  String artist_description;
  String? highlight_song_id;
  List<String> top_song_list_id;
  List<String> album_list_id;
  String artist_image_url;
  String? artist_video_url;
  factory ArtistInAlbumModel.fromJson(Map<String, dynamic> json) {
    ArtistInAlbumModel newArtist = ArtistInAlbumModel(
        id: json['_id'], 
        artist_name: json['artist_name'], 
        artist_description: json['artist_description'], 
        album_list_id: List<String>.from(json['album_list']), 
        artist_image_url: json['artist_image_url'], 
        top_song_list_id: List<String>.from(json['top_song_list']),
        artist_video_url: json['artist_video_url'],
        highlight_song_id: json['highlight_song']
      );
    return newArtist;
  }
}


Map<String, dynamic> sampleAlbumJson = {
    "_id": "625ed67a58dda2f3a6a52f43",
    "album_name": "Dù Cho Mai Về Sau",
    "genre": "Acoustic",
    "art_url": "https://avatar-ex-swe.nixcdn.com/song/2020/11/30/f/f/2/6/1606727675173_500.jpg",
    "album_year": 2019,
    "songs": [
        {
            "_id": "62611a8ebf87cf6c062a3290",
            "song_name": "Dù Cho Mai Về Sau",
            "track_number": null,
            "collaboration": null,
            "song_key": "musics/db8ff64a-4538-48ae-9e50-2d208ae41843.mp3",
            "lyric_key": "lyrics/83103e72-55a2-42c2-a42e-4d9f68e49415.json",
            "__v": 0
        }
    ],
    "__v": 0,
    "album_description": null,
    "artist": {
        "_id": "625ed479133da5aa54397e50",
        "artist_name": "Bùi Trường Linh",
        "artist_description": "buitruonglinh tên đầy đủ là Bùi Trường Linh. Anh chàng ca/ nhạc sĩ sinh năm 1999 đến từ Hà Nội, từng học tại trường Học viện Âm nhạc Quốc gia Việt Nam, sau này chuyển vào TP Hồ Chí Minh sinh sống và học tập tại trường Đại học Sân khấu - Điện ảnh - Truyền hình & Sự kiện.",
        "highlight_song": "62611b27bf87cf6c062a3295",
        "top_song_list": [
            "62611b27bf87cf6c062a3295"
        ],
        "album_list": [
            "625ed43c133da5aa54397e45",
            "625ed67a58dda2f3a6a52f43"
        ],
        "__v": 0,
        "artist_image_url": "https://i.scdn.co/image/ab67616d0000b273d3907b9aa5f13f3ee43c877d"
    }
};