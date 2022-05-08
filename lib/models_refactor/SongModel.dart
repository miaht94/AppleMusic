
class SongUrlModel{
  SongUrlModel({
    required this.song_url,
    required this.lyricURL,
    required this.song,
});

  String song_url;
  String lyricURL;
  SongModel song;

  factory SongUrlModel.fromJson(Map<String,dynamic> json){
    return SongUrlModel(
        song_url: json['song_url'],
        lyricURL: json['lyricURL'],
        song: SongModel.fromJson(json['song']));
  }
}

class SongModel{
  SongModel({
    required this.id,
    this.track_number,
    this.collaboration,
    required this.song_name,
    required this.song_key,
    required this.lyric_key,
    required this.album,
    required this.artist,
  });

  String id;
  int ? track_number;
  String ? collaboration;
  String song_name;
  String song_key;
  String lyric_key;
  AlbumInSongModel album;
  ArtistInSongModel artist;

  factory SongModel.fromJson(Map<String,dynamic> json) {
    SongModel newSong = SongModel(
        id: json['_id'],
        track_number: json['track_number'],
        collaboration: json['collaboration'],
        song_name: json['song_name'],
        song_key: json['song_key'],
        lyric_key: json['lyric_key'],
        album: AlbumInSongModel.fromJson(json['album']),
        artist: ArtistInSongModel.fromJson(json['artist']));
    return newSong;
  }
}

class AlbumInSongModel {

  AlbumInSongModel({
    required this.id,
    required this.album_name,
    required this.genre,
    required this.art_url,
    this.album_year,
    required this.songsId,
});

  String id;
  String album_name;
  String genre;
  String art_url;
  int? album_year;
  List<String> songsId;
  factory AlbumInSongModel.fromJson(Map<String,dynamic> json){
    AlbumInSongModel newALbum = AlbumInSongModel(
        id: json['_id'],
        album_name: json['album_name'],
        genre: json['genre'],
        art_url: json['art_url'],
        album_year: json['album_year'],
        songsId: (json['songs'] as List).map((item) => item as String).toList(),
    );
    return newALbum;
  }
}

class ArtistInSongModel {

  ArtistInSongModel({
    required this.id,
    required this.artist_name,
    required this.artist_description,
    this.highlight_song_id,
    this.top_song_list,
    required this.album_list,
    required this.artist_image_url,
    this.artist_video_url});

  String id;
  String artist_name;
  String artist_description;
  String? highlight_song_id;
  List<String>? top_song_list;
  List<String> album_list;
  String? artist_video_url;
  String artist_image_url;


  factory ArtistInSongModel.fromJson(Map<String, dynamic> json) {
    ArtistInSongModel newArtist = ArtistInSongModel(
        id: json['_id'],
        artist_name: json['artist_name'],
        artist_description: json['artist_description'],
        album_list: (json['album_list'] as List).map((item) => item as String).toList(),
        artist_image_url: json['artist_image_url'],
        artist_video_url: json['artist_video_url'],
        top_song_list: (json['top_song_list'] as List).map((item) => item as String).toList(),
        highlight_song_id: json['highlight_song']);
    return newArtist;
  }
}
