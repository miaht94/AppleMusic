import 'package:apple_music/models_refactor/SongModel.dart';

class ArtistModel{

  ArtistModel({
    required this.id,
    required this.artist_name,
    required this.artist_description,
    required this.artist_image_url,
    this.highlight_song,
    this.top_song_list,
    required this.album_list,
    this.artist_video_url,
});

  String id;
  String artist_name;
  String artist_description;
  String artist_image_url;
  SongRawModelArtist ? highlight_song;
  List<SongRawModelArtist> ? top_song_list;
  List<AlbumRawModel> album_list;
  String? artist_video_url;

  // ignore: sort_constructors_first
  factory ArtistModel.fromJson(Map<String,dynamic> json){
    final ArtistModel newArtist = ArtistModel(
    id: json['_id'],
    artist_name:  json['artist_name'],
    artist_description:  json['artist_description'],
    highlight_song: (json['highlight_song'] == null)
        ? null : SongRawModelArtist.fromJson(json['highlight_song']),
    top_song_list:  (json['top_song_list'] as List).map((item) => SongRawModelArtist.fromJson(item)).toList(),
    artist_image_url:  json['artist_image_url'] ,
    album_list:  (json['album_list'] as List).map((item) => AlbumRawModel.fromJson(item)).toList(),
    artist_video_url:  json['artist_video_url'],
  );
    return newArtist;
  }
  static List<ArtistModel> getSampleArtist() {
    return [
      ArtistModel.fromJson(sampleJson),
      ArtistModel.fromJson(sampleJson),
      ArtistModel.fromJson(sampleJson)
    ];
  }

  ArtistRawModel toRawModel() {
    return ArtistRawModel(id: id, artist_name: artist_name, artist_description: artist_description, album_list_id: album_list.map((e) => e.id).toList(), artist_image_url: artist_image_url, artist_video_url: artist_video_url);
  }

  SongModel songRawModelArtistToSongModel(SongRawModelArtist songRawModelArtist) {
    return SongModel(id: songRawModelArtist.id, song_name: songRawModelArtist.song_name, song_key: songRawModelArtist.song_key, lyric_key: songRawModelArtist.lyric_key, album: songRawModelArtist.album, artist: toRawModel());
  }

  List<SongModel> convertTopSongListToSongModel() {
    if (top_song_list != null) {
      return top_song_list!.map((e) => songRawModelArtistToSongModel(e)).toList();
    } else {
      return [];
    }
  }
}

class SongRawModelArtist {
  SongRawModelArtist({
    required this.id,
    required this.song_name,
    this.track_number,
    this.collaboration,
    required this.song_key,
    required this.lyric_key,
    required this.album
  });

  String id;
  String song_name;
  int? track_number;
  String? collaboration;
  String song_key;
  String lyric_key;
  AlbumRawModel album;
  // ignore: sort_constructors_first
  factory SongRawModelArtist.fromJson(Map<String, dynamic> json) {
    final SongRawModelArtist newSong = SongRawModelArtist(
        id: json['_id'],
        song_name: json['song_name'],
        song_key: json['song_key'],
        lyric_key: json['lyric_key'],
        track_number: json['track_number'],
        collaboration: json['collaboration'],
        album:  AlbumRawModel.fromJson(json['album'])
        // album: AlbumRawModel.fromJson(json['album']),
    );
    return newSong;
  }
}


class AlbumRawModel {

  AlbumRawModel({
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
  // ignore: sort_constructors_first
  factory AlbumRawModel.fromJson(Map<String,dynamic> json){
    final AlbumRawModel newALbum = AlbumRawModel(
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


Map<String, dynamic> sampleJson = {
    '_id': '625ed0c3133da5aa54397e27',
    'artist_name': 'Vũ',
    'artist_image_url': 'https://photo-resize-zmp3.zmdcdn.me/w360_r1x1_jpeg/avatars/b/a/d/2/bad27197c6774fc04c039c040ed8813c.jpg',
    'artist_description': 'Vũ, được viết cách điệu là Vũ tên đầy đủ là Hoàng Thái Vũ sinh tại Hà Nội, là ca sĩ kiêm sáng tác nhạc người Việt Nam.',
    'artist_video_url': null,
    'highlight_song': {
        '_id': '625ecfc7133da5aa54397e1e',
        'song_name': 'Đông kiếm em',
        'track_number': null,
        'collaboration': null,
        'song_key': 'musics/ac018820-9bab-4b82-b2a2-097d7b8ecef9.mp3',
        'lyric_key': 'lyrics/a037b1d0-e0b3-4b53-a2f7-bfb6cf373163.json',
        '__v': 0,
        'album': {
            '_id': '625ed08f133da5aa54397e22',
            'album_name': 'Đông kiếm em',
            'genre': 'Acoustic',
            'art_url': 'https://avatar-ex-swe.nixcdn.com/playlist/2020/08/11/b/4/5/7/1597138746575_500.jpg',
            'album_year': 2019,
            'songs': [
                '625ecfc7133da5aa54397e1e'
            ],
            '__v': 0,
            'album_description': null
        }
    },
    'top_song_list': [
        {
            '_id': '625ecfc7133da5aa54397e1e',
            'song_name': 'Đông kiếm em',
            'track_number': null,
            'collaboration': null,
            'song_key': 'musics/ac018820-9bab-4b82-b2a2-097d7b8ecef9.mp3',
            'lyric_key': 'lyrics/a037b1d0-e0b3-4b53-a2f7-bfb6cf373163.json',
            '__v': 0,
            'album': {
                '_id': '625ed08f133da5aa54397e22',
                'album_name': 'Đông kiếm em',
                'genre': 'Acoustic',
                'art_url': 'https://avatar-ex-swe.nixcdn.com/playlist/2020/08/11/b/4/5/7/1597138746575_500.jpg',
                'album_year': 2019,
                'songs': [
                    '625ecfc7133da5aa54397e1e'
                ],
                '__v': 0,
                'album_description': null
            }
        }
    ],
    'album_list': [
        {
            '_id': '625ed08f133da5aa54397e22',
            'album_name': 'Đông kiếm em',
            'genre': 'Acoustic',
            'art_url': 'https://avatar-ex-swe.nixcdn.com/playlist/2020/08/11/b/4/5/7/1597138746575_500.jpg',
            'album_year': 2019,
            'songs': [
                '625ecfc7133da5aa54397e1e'
            ],
            '__v': 0,
            'album_description': null
        },
        {
            '_id': '625ed23d133da5aa54397e31',
            'album_name': 'Lạ Lùng',
            'genre': 'Acoustic',
            'art_url': 'https://i1.sndcdn.com/artworks-000427399239-nqi3tb-t500x500.jpg',
            'album_year': 2019,
            'songs': [
                '625ed1cf133da5aa54397e29'
            ],
            '__v': 0,
            'album_description': null
        }
    ]
};