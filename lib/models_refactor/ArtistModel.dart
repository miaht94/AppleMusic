class ArtistModel{

  ArtistModel({
    required this.id,
    required this.artist_name,
    required this.artist_description,
    required this.artist_image_url,
    this.highlight_song_id,
    this.top_song_list,
    required this.album_list,
    this.artist_video_url,
});

  String id;
  String artist_name;
  String artist_description;
  String artist_image_url;
  SongModelInArtistModel ? highlight_song_id;
  List<SongModelInArtistModel> ? top_song_list;
  List<AlbumInArtistModel> album_list;
  String? artist_video_url;

  factory ArtistModel.fromJson(Map<String,dynamic> json){
    ArtistModel newArtist = ArtistModel(
    id: json['_id'],
    artist_name:  json['artist_name'],
    artist_description:  json['artist_description'],
    highlight_song_id: (json['highlight_song'] == null)
        ? null : SongModelInArtistModel.fromJson(json['highlight_song']),
    top_song_list:  (json['top_song_list'] as List).map((item) => SongModelInArtistModel.fromJson(item)).toList(),
    artist_image_url:  json['artist_image_url'] ,
    album_list:  (json['album_list'] as List).map((item) => AlbumInArtistModel.fromJson(item)).toList(),
    artist_video_url:  json['artist_video_url'],
  );
    return newArtist;
  }
}

class SongModelInArtistModel {
  SongModelInArtistModel({
    required this.id,
    required this.song_name,
    this.track_number,
    this.collaboration,
    required this.song_key,
    required this.lyric_key});

  String id;
  String song_name;
  int? track_number;
  String? collaboration;
  String song_key;
  String lyric_key;
  factory SongModelInArtistModel.fromJson(Map<String, dynamic> json) {
    SongModelInArtistModel newSong = SongModelInArtistModel(
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


class AlbumInArtistModel {

  AlbumInArtistModel({
    required this.id,
    required this.album_name,
    required this.genre,
    required this.art_url,
    required this.album_year,
    required this.songsId,
  });

  String id;
  String album_name;
  String genre;
  String art_url;
  int album_year;
  List<String> songsId;
  factory AlbumInArtistModel.fromJson(Map<String,dynamic> json){
    AlbumInArtistModel newALbum = AlbumInArtistModel(
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
