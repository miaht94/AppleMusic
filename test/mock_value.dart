Map<String, dynamic> mockUser = {
    '_id': '625d771f133da5aa54397daa',
    'name': 'Đặng Thế Hoàng Anh',
    'email': 'hoanganhxt183@gmail.com',
    'avatarURL': 'https://lh3.googleusercontent.com/a/AATXAJyOOdy9Lceldtup5NSHAxim7wLGnWmUr3CA_HDq=s96-c',
    'playlists': [
        {
            '_id': '625ed7df58dda2f3a6a52f55',
            'playlist_name': 'Playlist of Hoàng Anh',
            'art_url': 'https://is4-ssl.mzstatic.com/image/thumb/Video114/v4/e8/f4/5d/e8f45d1a-92ff-d5fd-3fb8-f1183dbd805f/Job01da3c5e-11a4-44b2-8cee-c3b917ab458b-108235318-PreviewImage_PreviewImageIntermediate_preview_image_nonvideo-Time1607802044859.png/610x610cc-60.jpg',
            'playlist_description': 'Playlist của Hoàng Anh bao gồm các bài hát hay nghe của tôi.',
            'songs': [
                '625ecfc7133da5aa54397e1e',
                '625ed1cf133da5aa54397e29',
                '62611a8ebf87cf6c062a3290',
                '62611b27bf87cf6c062a3295'
            ],
            'public': true,
            '__v': 0
        },
        {
            '_id': '627a8461229cca30c43250cf',
            'playlist_name': 'aaaaa',
            'art_url': 'https://test-bucket-bach.s3.ap-southeast-1.amazonaws.com/b74e357d-e33e-4acd-bb64-66ca7b6c7f9b.jpg',
            'playlist_description': 'aaaaa',
            'songs': [
                '62643b9f4a2b86f2559fa465',
                '62643ca44a2b86f2559fa473',
                '62643cc94a2b86f2559fa475'
            ],
            'public': true,
            '__v': 0
        }
    ],
    '__v': 3,
    'favorite_songs': [
        {
            '_id': '62642bf44a2b86f2559fa41e',
            'song_name': 'State Of Grace',
            'track_number': 1,
            'collaboration': null,
            'song_key': 'musics/abba2282-eb8b-4599-8dc1-cc810c8ee19b.mp3',
            'lyric_key': 'lyrics/7aaa1f50-fc91-4fdc-b366-b6929e316c94.json',
            '__v': 0
        },
        {
            '_id': '625ecfc7133da5aa54397e1e',
            'song_name': 'Đông kiếm em',
            'track_number': null,
            'collaboration': null,
            'song_key': 'musics/ac018820-9bab-4b82-b2a2-097d7b8ecef9.mp3',
            'lyric_key': 'lyrics/a037b1d0-e0b3-4b53-a2f7-bfb6cf373163.json',
            '__v': 0
        }
    ],
    'favorite_albums': [],
    'favorite_artists': []
};

Map<String, dynamic> mockDiscoveryPage = {
    'new_albums': [
        '625ed67a58dda2f3a6a52f43',
        '625ed67a58dda2f3a6a52f43',
        '625ed67a58dda2f3a6a52f43',
        '625ed67a58dda2f3a6a52f43',
    ],
    'do_not_miss': [
        '625ecfc7133da5aa54397e1e',
        '625ecfc7133da5aa54397e1e',
        '625ecfc7133da5aa54397e1e',
        '625ecfc7133da5aa54397e1e',
    ],
    'favorite_artist': [
        '625ed0c3133da5aa54397e27',
        '625ed0c3133da5aa54397e27',
        '625ed0c3133da5aa54397e27',
        '625ed0c3133da5aa54397e27'
    ],
    'best_new_song': [
        '625ecfc7133da5aa54397e1e',
        '625ecfc7133da5aa54397e1e',
        '625ecfc7133da5aa54397e1e',
    ]
};

Map<String, dynamic> mockAlbum = {
    '_id': '625ed67a58dda2f3a6a52f43',
    'album_name': 'Dù Cho Mai Về Sau',
    'genre': 'Acoustic',
    'art_url': 'https://avatar-ex-swe.nixcdn.com/song/2020/11/30/f/f/2/6/1606727675173_500.jpg',
    'album_year': 2019,
    'songs': [
        {
            '_id': '62611a8ebf87cf6c062a3290',
            'song_name': 'Dù Cho Mai Về Sau',
            'track_number': 1,
            'collaboration': null,
            'song_key': 'musics/db8ff64a-4538-48ae-9e50-2d208ae41843.mp3',
            'lyric_key': 'lyrics/83103e72-55a2-42c2-a42e-4d9f68e49415.json',
            '__v': 0
        }
    ],
    '__v': 0,
    'album_description': null,
    'artist': {
        '_id': '625ed479133da5aa54397e50',
        'artist_name': 'Bùi Trường Linh',
        'artist_description': 'buitruonglinh tên đầy đủ là Bùi Trường Linh. Anh chàng ca/ nhạc sĩ sinh năm 1999 đến từ Hà Nội, từng học tại trường Học viện Âm nhạc Quốc gia Việt Nam, sau này chuyển vào TP Hồ Chí Minh sinh sống và học tập tại trường Đại học Sân khấu - Điện ảnh - Truyền hình & Sự kiện.',
        'highlight_song': '62611b27bf87cf6c062a3295',
        'top_song_list': [
            '62611b27bf87cf6c062a3295'
        ],
        'album_list': [
            '625ed43c133da5aa54397e45',
            '625ed67a58dda2f3a6a52f43'
        ],
        '__v': 0,
        'artist_image_url': 'https://i.scdn.co/image/ab67616d0000b273d3907b9aa5f13f3ee43c877d'
    }
};

Map < String, dynamic > mockListeningPage = {
  'best_choice': [
    '625ed7df58dda2f3a6a52f55',
  ],
  'rencently_played': [
    '625ecfc7133da5aa54397e1e',
  ],
  'favorite_artist': [
    '625ed0c3133da5aa54397e27',
  ],
  'year_end_replays': [
    '625ed7df58dda2f3a6a52f55',
  ]
};
Map < String, dynamic > mockPlaylist = {
  '_id': '625ed7df58dda2f3a6a52f55',
  'playlist_name': 'Playlist of Hoàng Anh',
  'art_url': 'https://is4-ssl.mzstatic.com/image/thumb/Video114/v4/e8/f4/5d/e8f45d1a-92ff-d5fd-3fb8-f1183dbd805f/Job01da3c5e-11a4-44b2-8cee-c3b917ab458b-108235318-PreviewImage_PreviewImageIntermediate_preview_image_nonvideo-Time1607802044859.png/610x610cc-60.jpg',
  'playlist_description': 'Playlist của Hoàng Anh bao gồm các bài hát hay nghe của tôi.',
  'public': true,
  'songs': [{
      'song': {
        '_id': '625ecfc7133da5aa54397e1e',
        'song_name': 'Đông kiếm em',
        'track_number': null,
        'collaboration': null,
        'song_key': 'musics/ac018820-9bab-4b82-b2a2-097d7b8ecef9.mp3',
        'lyric_key': 'lyrics/f9cef588-49ca-464a-b050-489fb1c1d9b6.json',
        '__v': 0
      },
      'artist': {
        '_id': '625ed0c3133da5aa54397e27',
        'artist_name': 'Vu',
        'artist_description': 'Vu, được viết cách điệu là Vu tên đầy đủ là Hoàng Thái Vu sinh tại Hà Nội, là ca sĩ kiêm sáng tác nhạc người Việt Nam.',
        'highlight_song': null,
        'top_song_list': [],
        'album_list': [
          '625ed08f133da5aa54397e22',
          '625ed23d133da5aa54397e31'
        ],
        '__v': 0,
        'artist_image_url': 'https://photo-resize-zmp3.zmdcdn.me/w360_r1x1_jpeg/avatars/b/a/d/2/bad27197c6774fc04c039c040ed8813c.jpg'
      },
      'album': {
        '_id': '625ed08f133da5aa54397e22',
        'album_name': 'Đông kiếm em',
        'genre': 'Acoustic',
        'art_url': 'https://avatar-ex-swe.nixcdn.com/playlist/2020/08/11/b/4/5/7/1597138746575_500.jpg',
        'album_year': 2019,
        'songs': [
          '625ecfc7133da5aa54397e1e'
        ],
        '__v': 0
      }
    },
    {
      'song': {
        '_id': '625ed1cf133da5aa54397e29',
        'song_name': 'Lạ Lùng',
        'track_number': null,
        'collaboration': null,
        'song_key': 'musics/e879c438-e452-472f-9535-e53cc2754abb.mp3',
        'lyric_key': 'lyrics/24b3be99-2eef-4d5d-8416-467fb1214aa0.json',
        '__v': 0
      },
      'artist': {
        '_id': '625ed0c3133da5aa54397e27',
        'artist_name': 'Vu',
        'artist_description': 'Vu, được viết cách điệu là Vu tên đầy đủ là Hoàng Thái Vu sinh tại Hà Nội, là ca sĩ kiêm sáng tác nhạc người Việt Nam.',
        'highlight_song': null,
        'top_song_list': [],
        'album_list': [
          '625ed08f133da5aa54397e22',
          '625ed23d133da5aa54397e31'
        ],
        '__v': 0,
        'artist_image_url': 'https://photo-resize-zmp3.zmdcdn.me/w360_r1x1_jpeg/avatars/b/a/d/2/bad27197c6774fc04c039c040ed8813c.jpg'
      },
      'album': {
        '_id': '625ed23d133da5aa54397e31',
        'album_name': 'Lạ Lùng',
        'genre': 'Acoustic',
        'art_url': 'https://i1.sndcdn.com/artworks-000427399239-nqi3tb-t500x500.jpg',
        'album_year': 2019,
        'songs': [
          '625ed1cf133da5aa54397e29'
        ],
        '__v': 0
      }
    },
    {
      'song': {
        '_id': '62611a8ebf87cf6c062a3290',
        'song_name': 'Dù Cho Mai Về Sau',
        'track_number': null,
        'collaboration': null,
        'song_key': 'musics/db8ff64a-4538-48ae-9e50-2d208ae41843.mp3',
        'lyric_key': 'lyrics/27ad2bf0-f768-4534-9675-4455d53e595a.json',
        '__v': 0
      },
      'artist': {
        '_id': '625ed479133da5aa54397e50',
        'artist_name': 'Bùi Trường Linh',
        'artist_description': 'buitruonglinh tên đầy đủ là Bùi Trường Linh. Anh chàng ca/ nhạc sĩ sinh năm 1999 đến từ Hà Nội, từng học tại trường Học viện Âm nhạc Quốc gia Việt Nam, sau này chuyển vào TP Hồ Chí Minh sinh sống và học tập tại trường Đại học Sân khấu - Điện ảnh - Truyền hình & Sự kiện.',
        'highlight_song': null,
        'top_song_list': [],
        'album_list': [
          '625ed43c133da5aa54397e45',
          '625ed67a58dda2f3a6a52f43'
        ],
        '__v': 0,
        'artist_image_url': 'https://i.scdn.co/image/ab67616d0000b273d3907b9aa5f13f3ee43c877d'
      },
      'album': {
        '_id': '625ed67a58dda2f3a6a52f43',
        'album_name': 'Dù Cho Mai Về Sau',
        'genre': 'Acoustic',
        'art_url': 'https://avatar-ex-swe.nixcdn.com/song/2020/11/30/f/f/2/6/1606727675173_500.jpg',
        'album_year': 2019,
        'songs': [
          '62611a8ebf87cf6c062a3290'
        ],
        '__v': 0
      }
    },
    {
      'song': {
        '_id': '62611b27bf87cf6c062a3295',
        'song_name': 'Đường Tôi Chở Em Về',
        'track_number': null,
        'collaboration': null,
        'song_key': 'musics/c49437ec-f173-42ae-a31f-cdb45ff3a0f6.mp3',
        'lyric_key': 'lyrics/42d6c2ee-a7c3-4d5c-b501-40ee2747d0ae.json',
        '__v': 0
      },
      'artist': {
        '_id': '625ed479133da5aa54397e50',
        'artist_name': 'Bùi Trường Linh',
        'artist_description': 'buitruonglinh tên đầy đủ là Bùi Trường Linh. Anh chàng ca/ nhạc sĩ sinh năm 1999 đến từ Hà Nội, từng học tại trường Học viện Âm nhạc Quốc gia Việt Nam, sau này chuyển vào TP Hồ Chí Minh sinh sống và học tập tại trường Đại học Sân khấu - Điện ảnh - Truyền hình & Sự kiện.',
        'highlight_song': null,
        'top_song_list': [],
        'album_list': [
          '625ed43c133da5aa54397e45',
          '625ed67a58dda2f3a6a52f43'
        ],
        '__v': 0,
        'artist_image_url': 'https://i.scdn.co/image/ab67616d0000b273d3907b9aa5f13f3ee43c877d'
      },
      'album': {
        '_id': '625ed43c133da5aa54397e45',
        'album_name': 'Đường Tôi Chở Em Về',
        'genre': 'Acoustic',
        'art_url': 'https://avatar-ex-swe.nixcdn.com/song/2020/07/02/5/d/c/9/1593687560557_500.jpg',
        'album_year': 2019,
        'songs': [
          '62611b27bf87cf6c062a3295'
        ],
        '__v': 0
      }
    }
  ]
};

List<Map<String, dynamic>> mockPlaylistSearch = [
    {
        "_id": "625ed7df58dda2f3a6a52f55",
        "playlist_name": "Playlist of Hoàng Anh",
        "art_url": "https://is4-ssl.mzstatic.com/image/thumb/Video114/v4/e8/f4/5d/e8f45d1a-92ff-d5fd-3fb8-f1183dbd805f/Job01da3c5e-11a4-44b2-8cee-c3b917ab458b-108235318-PreviewImage_PreviewImageIntermediate_preview_image_nonvideo-Time1607802044859.png/610x610cc-60.jpg",
        "playlist_description": "Playlist của Hoàng Anh bao gồm các bài hát hay nghe của tôi.",
        "public": true,
        "songs": [
            {
                "song": {
                    "_id": "625ecfc7133da5aa54397e1e",
                    "song_name": "Đông kiếm em",
                    "track_number": 1,
                    "collaboration": null,
                    "song_key": "musics/ac018820-9bab-4b82-b2a2-097d7b8ecef9.mp3",
                    "lyric_key": "lyrics/a037b1d0-e0b3-4b53-a2f7-bfb6cf373163.json",
                    "__v": 0
                },
                "artist": {
                    "_id": "625ed0c3133da5aa54397e27",
                    "artist_name": "Vũ",
                    "artist_description": "Vũ, được viết cách điệu là Vũ tên đầy đủ là Hoàng Thái Vũ sinh tại Hà Nội, là ca sĩ kiêm sáng tác nhạc người Việt Nam.",
                    "highlight_song": "625ecfc7133da5aa54397e1e",
                    "top_song_list": [
                        "625ecfc7133da5aa54397e1e"
                    ],
                    "album_list": [
                        "625ed08f133da5aa54397e22",
                        "625ed23d133da5aa54397e31"
                    ],
                    "__v": 0,
                    "artist_image_url": "https://photo-resize-zmp3.zmdcdn.me/w360_r1x1_jpeg/avatars/b/a/d/2/bad27197c6774fc04c039c040ed8813c.jpg",
                    "artist_video_url": null
                },
                "album": {
                    "_id": "625ed08f133da5aa54397e22",
                    "album_name": "Đông kiếm em",
                    "genre": "Acoustic",
                    "art_url": "https://avatar-ex-swe.nixcdn.com/playlist/2020/08/11/b/4/5/7/1597138746575_500.jpg",
                    "album_year": 2019,
                    "songs": [
                        "625ecfc7133da5aa54397e1e"
                    ],
                    "__v": 0,
                    "album_description": null
                }
            },
            {
                "song": {
                    "_id": "625ed1cf133da5aa54397e29",
                    "song_name": "Lạ Lùng",
                    "track_number": 1,
                    "collaboration": null,
                    "song_key": "musics/e879c438-e452-472f-9535-e53cc2754abb.mp3",
                    "lyric_key": "lyrics/f44ad572-a2b8-4dcc-aa60-3617f5c17d3d.json",
                    "__v": 0
                },
                "artist": {
                    "_id": "625ed0c3133da5aa54397e27",
                    "artist_name": "Vũ",
                    "artist_description": "Vũ, được viết cách điệu là Vũ tên đầy đủ là Hoàng Thái Vũ sinh tại Hà Nội, là ca sĩ kiêm sáng tác nhạc người Việt Nam.",
                    "highlight_song": "625ecfc7133da5aa54397e1e",
                    "top_song_list": [
                        "625ecfc7133da5aa54397e1e"
                    ],
                    "album_list": [
                        "625ed08f133da5aa54397e22",
                        "625ed23d133da5aa54397e31"
                    ],
                    "__v": 0,
                    "artist_image_url": "https://photo-resize-zmp3.zmdcdn.me/w360_r1x1_jpeg/avatars/b/a/d/2/bad27197c6774fc04c039c040ed8813c.jpg",
                    "artist_video_url": null
                },
                "album": {
                    "_id": "625ed23d133da5aa54397e31",
                    "album_name": "Lạ Lùng",
                    "genre": "Acoustic",
                    "art_url": "https://i1.sndcdn.com/artworks-000427399239-nqi3tb-t500x500.jpg",
                    "album_year": 2019,
                    "songs": [
                        "625ed1cf133da5aa54397e29"
                    ],
                    "__v": 0,
                    "album_description": null
                }
            },
            {
                "song": {
                    "_id": "62611a8ebf87cf6c062a3290",
                    "song_name": "Dù Cho Mai Về Sau",
                    "track_number": 1,
                    "collaboration": null,
                    "song_key": "musics/db8ff64a-4538-48ae-9e50-2d208ae41843.mp3",
                    "lyric_key": "lyrics/83103e72-55a2-42c2-a42e-4d9f68e49415.json",
                    "__v": 0
                },
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
                },
                "album": {
                    "_id": "625ed67a58dda2f3a6a52f43",
                    "album_name": "Dù Cho Mai Về Sau",
                    "genre": "Acoustic",
                    "art_url": "https://avatar-ex-swe.nixcdn.com/song/2020/11/30/f/f/2/6/1606727675173_500.jpg",
                    "album_year": 2019,
                    "songs": [
                        "62611a8ebf87cf6c062a3290"
                    ],
                    "__v": 0,
                    "album_description": null
                }
            },
            {
                "song": {
                    "_id": "62611b27bf87cf6c062a3295",
                    "song_name": "Đường Tôi Chở Em Về",
                    "track_number": 1,
                    "collaboration": null,
                    "song_key": "musics/c49437ec-f173-42ae-a31f-cdb45ff3a0f6.mp3",
                    "lyric_key": "lyrics/562b863c-edc4-486d-983e-bfe7c68780cb.json",
                    "__v": 0
                },
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
                },
                "album": {
                    "_id": "625ed43c133da5aa54397e45",
                    "album_name": "Đường Tôi Chở Em Về",
                    "genre": "Acoustic",
                    "art_url": "https://avatar-ex-swe.nixcdn.com/song/2020/07/02/5/d/c/9/1593687560557_500.jpg",
                    "album_year": 2019,
                    "songs": [
                        "62611b27bf87cf6c062a3295"
                    ],
                    "__v": 0,
                    "album_description": null
                }
            }
        ]
    }
];

List<Map<String, dynamic>> mockAlbumSearch = [
    {
        "_id": "625ed67a58dda2f3a6a52f43",
        "album_name": "Dù Cho Mai Về Sau",
        "genre": "Acoustic",
        "art_url": "https://avatar-ex-swe.nixcdn.com/song/2020/11/30/f/f/2/6/1606727675173_500.jpg",
        "album_year": 2019,
        "songs": [
            {
                "_id": "62611a8ebf87cf6c062a3290",
                "song_name": "Dù Cho Mai Về Sau",
                "track_number": 1,
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
    }
];

List<Map<String, dynamic>> mockSearchArtist = [
    {
        "_id": "625ed0c3133da5aa54397e27",
        "artist_name": "Vũ",
        "artist_image_url": "https://photo-resize-zmp3.zmdcdn.me/w360_r1x1_jpeg/avatars/b/a/d/2/bad27197c6774fc04c039c040ed8813c.jpg",
        "artist_description": "Vũ, được viết cách điệu là Vũ tên đầy đủ là Hoàng Thái Vũ sinh tại Hà Nội, là ca sĩ kiêm sáng tác nhạc người Việt Nam.",
        "artist_video_url": null,
        "highlight_song": {
            "_id": "625ecfc7133da5aa54397e1e",
            "song_name": "Đông kiếm em",
            "track_number": 1,
            "collaboration": null,
            "song_key": "musics/ac018820-9bab-4b82-b2a2-097d7b8ecef9.mp3",
            "lyric_key": "lyrics/a037b1d0-e0b3-4b53-a2f7-bfb6cf373163.json",
            "__v": 0,
            "album": {
                "_id": "625ed08f133da5aa54397e22",
                "album_name": "Đông kiếm em",
                "genre": "Acoustic",
                "art_url": "https://avatar-ex-swe.nixcdn.com/playlist/2020/08/11/b/4/5/7/1597138746575_500.jpg",
                "album_year": 2019,
                "songs": [
                    "625ecfc7133da5aa54397e1e"
                ],
                "__v": 0,
                "album_description": null
            }
        },
        "top_song_list": [
            {
                "_id": "625ecfc7133da5aa54397e1e",
                "song_name": "Đông kiếm em",
                "track_number": 1,
                "collaboration": null,
                "song_key": "musics/ac018820-9bab-4b82-b2a2-097d7b8ecef9.mp3",
                "lyric_key": "lyrics/a037b1d0-e0b3-4b53-a2f7-bfb6cf373163.json",
                "__v": 0,
                "album": {
                    "_id": "625ed08f133da5aa54397e22",
                    "album_name": "Đông kiếm em",
                    "genre": "Acoustic",
                    "art_url": "https://avatar-ex-swe.nixcdn.com/playlist/2020/08/11/b/4/5/7/1597138746575_500.jpg",
                    "album_year": 2019,
                    "songs": [
                        "625ecfc7133da5aa54397e1e"
                    ],
                    "__v": 0,
                    "album_description": null
                }
            }
        ],
        "album_list": [
            {
                "_id": "625ed08f133da5aa54397e22",
                "album_name": "Đông kiếm em",
                "genre": "Acoustic",
                "art_url": "https://avatar-ex-swe.nixcdn.com/playlist/2020/08/11/b/4/5/7/1597138746575_500.jpg",
                "album_year": 2019,
                "songs": [
                    "625ecfc7133da5aa54397e1e"
                ],
                "__v": 0,
                "album_description": null
            },
            {
                "_id": "625ed23d133da5aa54397e31",
                "album_name": "Lạ Lùng",
                "genre": "Acoustic",
                "art_url": "https://i1.sndcdn.com/artworks-000427399239-nqi3tb-t500x500.jpg",
                "album_year": 2019,
                "songs": [
                    "625ed1cf133da5aa54397e29"
                ],
                "__v": 0,
                "album_description": null
            }
        ]
    }
];

List<Map<String, dynamic>> mockSearchSong = [
    {
        "_id": "625ecfc7133da5aa54397e1e",
        "song_name": "Đông kiếm em",
        "track_number": 1,
        "collaboration": null,
        "song_key": "musics/ac018820-9bab-4b82-b2a2-097d7b8ecef9.mp3",
        "lyric_key": "lyrics/a037b1d0-e0b3-4b53-a2f7-bfb6cf373163.json",
        "__v": 0,
        "album": {
            "_id": "625ed08f133da5aa54397e22",
            "album_name": "Đông kiếm em",
            "genre": "Acoustic",
            "art_url": "https://avatar-ex-swe.nixcdn.com/playlist/2020/08/11/b/4/5/7/1597138746575_500.jpg",
            "album_year": 2019,
            "songs": [
                "625ecfc7133da5aa54397e1e"
            ],
            "__v": 0,
            "album_description": null
        },
        "artist": {
            "_id": "625ed0c3133da5aa54397e27",
            "artist_name": "Vũ",
            "artist_description": "Vũ, được viết cách điệu là Vũ tên đầy đủ là Hoàng Thái Vũ sinh tại Hà Nội, là ca sĩ kiêm sáng tác nhạc người Việt Nam.",
            "highlight_song": "625ecfc7133da5aa54397e1e",
            "top_song_list": [
                "625ecfc7133da5aa54397e1e"
            ],
            "album_list": [
                "625ed08f133da5aa54397e22",
                "625ed23d133da5aa54397e31"
            ],
            "__v": 0,
            "artist_image_url": "https://photo-resize-zmp3.zmdcdn.me/w360_r1x1_jpeg/avatars/b/a/d/2/bad27197c6774fc04c039c040ed8813c.jpg",
            "artist_video_url": null
        }
    }
];
Map < String, dynamic > mockSong = {
  'song_url': 'https://bach-bucket.s3.ap-southeast-1.amazonaws.com/musics/ac018820-9bab-4b82-b2a2-097d7b8ecef9.mp3?AWSAccessKeyId=AKIAT4X7MYTCJGJ2JQ6B&Expires=1651798361&Signature=AYmvXcCbJyuOBM3no4RiBjkEJbg%3D',
  'lyricURL': 'https://bach-bucket.s3.ap-southeast-1.amazonaws.com/lyrics/f9cef588-49ca-464a-b050-489fb1c1d9b6.json?AWSAccessKeyId=AKIAT4X7MYTCJGJ2JQ6B&Expires=1651798361&Signature=TIx5P9yTTAFu1h5Uo2Us4mmlYyw%3D',
  'song': {
    '_id': '625ecfc7133da5aa54397e1e',
    'song_name': 'Đông kiếm em',
    'track_number': null,
    'collaboration': null,
    'song_key': 'musics/ac018820-9bab-4b82-b2a2-097d7b8ecef9.mp3',
    'lyric_key': 'lyrics/f9cef588-49ca-464a-b050-489fb1c1d9b6.json',
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
      '__v': 0
    },
    'artist': {
      '_id': '625ed0c3133da5aa54397e27',
      'artist_name': 'Vu',
      'artist_description': 'Vu, được viết cách điệu là Vu tên đầy đủ là Hoàng Thái Vu sinh tại Hà Nội, là ca sĩ kiêm sáng tác nhạc người Việt Nam.',
      'highlight_song': null,
      'top_song_list': [],
      'album_list': [
        '625ed08f133da5aa54397e22',
        '625ed23d133da5aa54397e31'
      ],
      '__v': 0,
      'artist_image_url': 'https://photo-resize-zmp3.zmdcdn.me/w360_r1x1_jpeg/avatars/b/a/d/2/bad27197c6774fc04c039c040ed8813c.jpg'
    }
  }
};
Map < String, dynamic > mockArtist = {
  'artist_video_url': null,
  '_id': '625ed0c3133da5aa54397e27',
  'artist_name': 'Vu',
  'artist_description': 'Vu, được viết cách điệu là Vu tên đầy đủ là Hoàng Thái Vu sinh tại Hà Nội, là ca sĩ kiêm sáng tác nhạc người Việt Nam.',
  'highlight_song': null,
  'top_song_list': [],
  'album_list': [{
      '_id': '625ed08f133da5aa54397e22',
      'album_name': 'Đông kiếm em',
      'genre': 'Acoustic',
      'art_url': 'https://avatar-ex-swe.nixcdn.com/playlist/2020/08/11/b/4/5/7/1597138746575_500.jpg',
      'album_year': 2019,
      'songs': [
        '625ecfc7133da5aa54397e1e'
      ],
      '__v': 0
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
      '__v': 0
    }
  ],
  '__v': 0,
  'artist_image_url': 'https://photo-resize-zmp3.zmdcdn.me/w360_r1x1_jpeg/avatars/b/a/d/2/bad27197c6774fc04c039c040ed8813c.jpg'
};



Map < String, dynamic > mockPlaylistPublic = {
  '_id': '625ed7df58dda2f3a6a52f55',
  'playlist_name': 'Playlist of Hoàng Anh',
  'art_url': 'https://is4-ssl.mzstatic.com/image/thumb/Video114/v4/e8/f4/5d/e8f45d1a-92ff-d5fd-3fb8-f1183dbd805f/Job01da3c5e-11a4-44b2-8cee-c3b917ab458b-108235318-PreviewImage_PreviewImageIntermediate_preview_image_nonvideo-Time1607802044859.png/610x610cc-60.jpg',
  'playlist_description': 'Playlist của Hoàng Anh bao gồm các bài hát hay nghe của tôi.',
  'public': true,
  'songs': [{
      'song': {
        '_id': '625ecfc7133da5aa54397e1e',
        'song_name': 'Đông kiếm em',
        'track_number': null,
        'collaboration': null,
        'song_key': 'musics/ac018820-9bab-4b82-b2a2-097d7b8ecef9.mp3',
        'lyric_key': 'lyrics/f9cef588-49ca-464a-b050-489fb1c1d9b6.json',
        '__v': 0
      },
      'artist': {
        '_id': '625ed0c3133da5aa54397e27',
        'artist_name': 'Vu',
        'artist_description': 'Vu, được viết cách điệu là Vu tên đầy đủ là Hoàng Thái Vu sinh tại Hà Nội, là ca sĩ kiêm sáng tác nhạc người Việt Nam.',
        'highlight_song': null,
        'top_song_list': [],
        'album_list': [
          '625ed08f133da5aa54397e22',
          '625ed23d133da5aa54397e31'
        ],
        '__v': 0,
        'artist_image_url': 'https://photo-resize-zmp3.zmdcdn.me/w360_r1x1_jpeg/avatars/b/a/d/2/bad27197c6774fc04c039c040ed8813c.jpg'
      },
      'album': {
        '_id': '625ed08f133da5aa54397e22',
        'album_name': 'Đông kiếm em',
        'genre': 'Acoustic',
        'art_url': 'https://avatar-ex-swe.nixcdn.com/playlist/2020/08/11/b/4/5/7/1597138746575_500.jpg',
        'album_year': 2019,
        'songs': [
          '625ecfc7133da5aa54397e1e'
        ],
        '__v': 0
      }
    },
    {
      'song': {
        '_id': '625ed1cf133da5aa54397e29',
        'song_name': 'Lạ Lùng',
        'track_number': null,
        'collaboration': null,
        'song_key': 'musics/e879c438-e452-472f-9535-e53cc2754abb.mp3',
        'lyric_key': 'lyrics/24b3be99-2eef-4d5d-8416-467fb1214aa0.json',
        '__v': 0
      },
      'artist': {
        '_id': '625ed0c3133da5aa54397e27',
        'artist_name': 'Vu',
        'artist_description': 'Vu, được viết cách điệu là Vu tên đầy đủ là Hoàng Thái Vu sinh tại Hà Nội, là ca sĩ kiêm sáng tác nhạc người Việt Nam.',
        'highlight_song': null,
        'top_song_list': [],
        'album_list': [
          '625ed08f133da5aa54397e22',
          '625ed23d133da5aa54397e31'
        ],
        '__v': 0,
        'artist_image_url': 'https://photo-resize-zmp3.zmdcdn.me/w360_r1x1_jpeg/avatars/b/a/d/2/bad27197c6774fc04c039c040ed8813c.jpg'
      },
      'album': {
        '_id': '625ed23d133da5aa54397e31',
        'album_name': 'Lạ Lùng',
        'genre': 'Acoustic',
        'art_url': 'https://i1.sndcdn.com/artworks-000427399239-nqi3tb-t500x500.jpg',
        'album_year': 2019,
        'songs': [
          '625ed1cf133da5aa54397e29'
        ],
        '__v': 0
      }
    },
    {
      'song': {
        '_id': '62611a8ebf87cf6c062a3290',
        'song_name': 'Dù Cho Mai Về Sau',
        'track_number': null,
        'collaboration': null,
        'song_key': 'musics/db8ff64a-4538-48ae-9e50-2d208ae41843.mp3',
        'lyric_key': 'lyrics/27ad2bf0-f768-4534-9675-4455d53e595a.json',
        '__v': 0
      },
      'artist': {
        '_id': '625ed479133da5aa54397e50',
        'artist_name': 'Bùi Trường Linh',
        'artist_description': 'buitruonglinh tên đầy đủ là Bùi Trường Linh. Anh chàng ca/ nhạc sĩ sinh năm 1999 đến từ Hà Nội, từng học tại trường Học viện Âm nhạc Quốc gia Việt Nam, sau này chuyển vào TP Hồ Chí Minh sinh sống và học tập tại trường Đại học Sân khấu - Điện ảnh - Truyền hình & Sự kiện.',
        'highlight_song': null,
        'top_song_list': [],
        'album_list': [
          '625ed43c133da5aa54397e45',
          '625ed67a58dda2f3a6a52f43'
        ],
        '__v': 0,
        'artist_image_url': 'https://i.scdn.co/image/ab67616d0000b273d3907b9aa5f13f3ee43c877d'
      },
      'album': {
        '_id': '625ed67a58dda2f3a6a52f43',
        'album_name': 'Dù Cho Mai Về Sau',
        'genre': 'Acoustic',
        'art_url': 'https://avatar-ex-swe.nixcdn.com/song/2020/11/30/f/f/2/6/1606727675173_500.jpg',
        'album_year': 2019,
        'songs': [
          '62611a8ebf87cf6c062a3290'
        ],
        '__v': 0
      }
    },
    {
      'song': {
        '_id': '62611b27bf87cf6c062a3295',
        'song_name': 'Đường Tôi Chở Em Về',
        'track_number': null,
        'collaboration': null,
        'song_key': 'musics/c49437ec-f173-42ae-a31f-cdb45ff3a0f6.mp3',
        'lyric_key': 'lyrics/42d6c2ee-a7c3-4d5c-b501-40ee2747d0ae.json',
        '__v': 0
      },
      'artist': {
        '_id': '625ed479133da5aa54397e50',
        'artist_name': 'Bùi Trường Linh',
        'artist_description': 'buitruonglinh tên đầy đủ là Bùi Trường Linh. Anh chàng ca/ nhạc sĩ sinh năm 1999 đến từ Hà Nội, từng học tại trường Học viện Âm nhạc Quốc gia Việt Nam, sau này chuyển vào TP Hồ Chí Minh sinh sống và học tập tại trường Đại học Sân khấu - Điện ảnh - Truyền hình & Sự kiện.',
        'highlight_song': null,
        'top_song_list': [],
        'album_list': [
          '625ed43c133da5aa54397e45',
          '625ed67a58dda2f3a6a52f43'
        ],
        '__v': 0,
        'artist_image_url': 'https://i.scdn.co/image/ab67616d0000b273d3907b9aa5f13f3ee43c877d'
      },
      'album': {
        '_id': '625ed43c133da5aa54397e45',
        'album_name': 'Đường Tôi Chở Em Về',
        'genre': 'Acoustic',
        'art_url': 'https://avatar-ex-swe.nixcdn.com/song/2020/07/02/5/d/c/9/1593687560557_500.jpg',
        'album_year': 2019,
        'songs': [
          '62611b27bf87cf6c062a3295'
        ],
        '__v': 0
      }
    }
  ]
};

String test = '{\"_id\":\"625ed7df58dda2f3a6a52f55\",\"playlist_name\":\"Playlist of Hoàng Anh\",\"art_url\":\"https://is4-ssl.mzstatic.com/image/thumb/Video114/v4/e8/f4/5d/e8f45d1a-92ff-d5fd-3fb8-f1183dbd805f/Job01da3c5e-11a4-44b2-8cee-c3b917ab458b-108235318-PreviewImage_PreviewImageIntermediate_preview_image_nonvideo-Time1607802044859.png/610x610cc-60.jpg\",\"playlist_description\":\"Playlist của Hoàng Anh bao gồm các bài hát hay nghe của tôi.\",\"public\":true,\"songs\":[{\"song\":{\"_id\":\"625ecfc7133da5aa54397e1e\",\"song_name\":\"Đông kiếm em\",\"track_number\":null,\"collaboration\":null,\"song_key\":\"musics/ac018820-9bab-4b82-b2a2-097d7b8ecef9.mp3\",\"lyric_key\":\"lyrics/f9cef588-49ca-464a-b050-489fb1c1d9b6.json\",\"__v\":0},\"artist\":{\"_id\":\"625ed0c3133da5aa54397e27\",\"artist_name\":\"Vu\",\"artist_description\":\"Vu, được viết cách điệu là Vu tên đầy đủ là Hoàng Thái Vu sinh tại Hà Nội, là ca sĩ kiêm sáng tác nhạc người Việt Nam.\",\"highlight_song\":null,\"top_song_list\":[],\"album_list\":[\"625ed08f133da5aa54397e22\",\"625ed23d133da5aa54397e31\"],\"__v\":0,\"artist_image_url\":\"https://photo-resize-zmp3.zmdcdn.me/w360_r1x1_jpeg/avatars/b/a/d/2/bad27197c6774fc04c039c040ed8813c.jpg\"},\"album\":{\"_id\":\"625ed08f133da5aa54397e22\",\"album_name\":\"Đông kiếm em\",\"genre\":\"Acoustic\",\"art_url\":\"https://avatar-ex-swe.nixcdn.com/playlist/2020/08/11/b/4/5/7/1597138746575_500.jpg\",\"album_year\":2019,\"songs\":[\"625ecfc7133da5aa54397e1e\"],\"__v\":0}},{\"song\":{\"_id\":\"625ed1cf133da5aa54397e29\",\"song_name\":\"Lạ Lùng\",\"track_number\":null,\"collaboration\":null,\"song_key\":\"musics/e879c438-e452-472f-9535-e53cc2754abb.mp3\",\"lyric_key\":\"lyrics/24b3be99-2eef-4d5d-8416-467fb1214aa0.json\",\"__v\":0},\"artist\":{\"_id\":\"625ed0c3133da5aa54397e27\",\"artist_name\":\"Vu\",\"artist_description\":\"Vu, được viết cách điệu là Vu tên đầy đủ là Hoàng Thái Vu sinh tại Hà Nội, là ca sĩ kiêm sáng tác nhạc người Việt Nam.\",\"highlight_song\":null,\"top_song_list\":[],\"album_list\":[\"625ed08f133da5aa54397e22\",\"625ed23d133da5aa54397e31\"],\"__v\":0,\"artist_image_url\":\"https://photo-resize-zmp3.zmdcdn.me/w360_r1x1_jpeg/avatars/b/a/d/2/bad27197c6774fc04c039c040ed8813c.jpg\"},\"album\":{\"_id\":\"625ed23d133da5aa54397e31\",\"album_name\":\"Lạ Lùng\",\"genre\":\"Acoustic\",\"art_url\":\"https://i1.sndcdn.com/artworks-000427399239-nqi3tb-t500x500.jpg\",\"album_year\":2019,\"songs\":[\"625ed1cf133da5aa54397e29\"],\"__v\":0}},{\"song\":{\"_id\":\"62611a8ebf87cf6c062a3290\",\"song_name\":\"Dù Cho Mai Về Sau\",\"track_number\":null,\"collaboration\":null,\"song_key\":\"musics/db8ff64a-4538-48ae-9e50-2d208ae41843.mp3\",\"lyric_key\":\"lyrics/27ad2bf0-f768-4534-9675-4455d53e595a.json\",\"__v\":0},\"artist\":{\"_id\":\"625ed479133da5aa54397e50\",\"artist_name\":\"Bùi Trường Linh\",\"artist_description\":\"buitruonglinh tên đầy đủ là Bùi Trường Linh. Anh chàng ca/ nhạc sĩ sinh năm 1999 đến từ Hà Nội, từng học tại trường Học viện Âm nhạc Quốc gia Việt Nam, sau này chuyển vào TP Hồ Chí Minh sinh sống và học tập tại trường Đại học Sân khấu - Điện ảnh - Truyền hình & Sự kiện.\",\"highlight_song\":null,\"top_song_list\":[],\"album_list\":[\"625ed43c133da5aa54397e45\",\"625ed67a58dda2f3a6a52f43\"],\"__v\":0,\"artist_image_url\":\"https://i.scdn.co/image/ab67616d0000b273d3907b9aa5f13f3ee43c877d\"},\"album\":{\"_id\":\"625ed67a58dda2f3a6a52f43\",\"album_name\":\"Dù Cho Mai Về Sau\",\"genre\":\"Acoustic\",\"art_url\":\"https://avatar-ex-swe.nixcdn.com/song/2020/11/30/f/f/2/6/1606727675173_500.jpg\",\"album_year\":2019,\"songs\":[\"62611a8ebf87cf6c062a3290\"],\"__v\":0}},{\"song\":{\"_id\":\"62611b27bf87cf6c062a3295\",\"song_name\":\"Đường Tôi Chở Em Về\",\"track_number\":null,\"collaboration\":null,\"song_key\":\"musics/c49437ec-f173-42ae-a31f-cdb45ff3a0f6.mp3\",\"lyric_key\":\"lyrics/42d6c2ee-a7c3-4d5c-b501-40ee2747d0ae.json\",\"__v\":0},\"artist\":{\"_id\":\"625ed479133da5aa54397e50\",\"artist_name\":\"Bùi Trường Linh\",\"artist_description\":\"buitruonglinh tên đầy đủ là Bùi Trường Linh. Anh chàng ca/ nhạc sĩ sinh năm 1999 đến từ Hà Nội, từng học tại trường Học viện Âm nhạc Quốc gia Việt Nam, sau này chuyển vào TP Hồ Chí Minh sinh sống và học tập tại trường Đại học Sân khấu - Điện ảnh - Truyền hình & Sự kiện.\",\"highlight_song\":null,\"top_song_list\":[],\"album_list\":[\"625ed43c133da5aa54397e45\",\"625ed67a58dda2f3a6a52f43\"],\"__v\":0,\"artist_image_url\":\"https://i.scdn.co/image/ab67616d0000b273d3907b9aa5f13f3ee43c877d\"},\"album\":{\"_id\":\"625ed43c133da5aa54397e45\",\"album_name\":\"Đường Tôi Chở Em Về\",\"genre\":\"Acoustic\",\"art_url\":\"https://avatar-ex-swe.nixcdn.com/song/2020/07/02/5/d/c/9/1593687560557_500.jpg\",\"album_year\":2019,\"songs\":[\"62611b27bf87cf6c062a3295\"],\"__v\":0}}]}';