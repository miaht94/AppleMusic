class PlaylistModel {
  PlaylistModel({required this.id, required this.playlist_name, required this.art_url, required this.playlist_description, required this.song_artist_pair, required this.public});
  String id;
  String playlist_name;
  String art_url;
  String playlist_description;
  List<SongArtistPairInPlaylistModel> song_artist_pair;
  bool public;
  factory PlaylistModel.fromJson(Map<String, dynamic> json) {
    List<SongArtistPairInPlaylistModel> song_artist_pairs = [];
    for (Map<String, dynamic> i in json['songs']) {
      song_artist_pairs.add(SongArtistPairInPlaylistModel.fromJson(i));
    }
    PlaylistModel newPlaylist = new PlaylistModel(
      id : json['_id'], 
      playlist_name : json['playlist_name'], 
      art_url : json['art_url'], 
      playlist_description : json['playlist_description'], 
      song_artist_pair : song_artist_pairs, 
      public : json['public']);
    return newPlaylist;
  }
}

class SongArtistPairInPlaylistModel {
  SongArtistPairInPlaylistModel({required this.song, required this.artist});
  SongInPlaylistModel song;
  ArtistInPlaylistModel artist;
  factory SongArtistPairInPlaylistModel.fromJson(Map<String, dynamic> json) {
    SongArtistPairInPlaylistModel newSongArtistPair = SongArtistPairInPlaylistModel(song: SongInPlaylistModel.fromJson(json['song']), artist: ArtistInPlaylistModel.fromJson(json['artist']));
    return newSongArtistPair;
  }

}

class SongInPlaylistModel {
  SongInPlaylistModel({required this.id, required this.song_name, required this.song_key, required this.lyric_key, this.collaboration, this.track_number});
  String id;
  String song_name;
  int? track_number;
  String? collaboration;
  String? song_key;
  String lyric_key;
  factory SongInPlaylistModel.fromJson(Map<String, dynamic> json) {
    SongInPlaylistModel newSong = SongInPlaylistModel(id: json['_id'], song_name: json['song_name'], song_key: json['song_key'], lyric_key: json['lyric_key'], collaboration: json['collaboration'], track_number: json['track_number']);
    return newSong;
  }
}

class ArtistInPlaylistModel {
  ArtistInPlaylistModel({required this.id, required this.artist_name, required this.artist_description, required this.album_list_id, required this.artist_image_url, this.artist_video_url, this.highlight_song_id, required this.top_song_list_id});
  String id;
  String artist_name;
  String artist_description;
  String? highlight_song_id;
  List<String> top_song_list_id;
  List<String> album_list_id;
  String artist_image_url;
  String? artist_video_url;
  factory ArtistInPlaylistModel.fromJson(Map<String, dynamic> json) {
    ArtistInPlaylistModel newArtist = ArtistInPlaylistModel(id: json['_id'], artist_name: json['artist_name'], artist_description: json['artist_description'], album_list_id: List<String>.from(json['album_list']), artist_image_url: json['artist_image_url'], top_song_list_id: List<String>.from(json['top_song_list']));
    return newArtist;
  }
}