import 'dart:io';

import 'package:flutter/material.dart';

const String kFontFamily = "Roboto";
const double kDefaultPadding = 10;
const Color kHeadlineColor = Color.fromRGBO(179, 179, 179, 1);//
// final isTestingMode = false;
final isTestingMode = Platform.environment.containsKey('FLUTTER_TEST');
// padding chiều dọc giữa các component
// VD giữa đừng bỏ lỡ với nghệ sĩ được yêu thích.
const double VerticalComponentPadding = 20;

const String CREDENTIAL_PATH = 'credential.txt';

// CONFIG FOR OAUTH2 GOOGLE API (WITHOUT SECRET KEY, DON'T FIND IT)
// Uri REDIRECT_URI = Uri.parse("http://koyomiku39.moe/verify");
Uri REDIRECT_URI = Uri.parse('http://koyomiku39.moe/verify');

const String SV_HOSTNAME = 'koyomiku39.moe';
const int SV_PORT = 80;
 

// API ENTRY
String MY_PROFILE_PATH = 'api/profile/me';
String SEARCH_SONG_PATH = 'api/songs';
String SEARCH_ARTIST_PATH = 'api/artistes';
String SEARCH_PLAYLIST_PATH = 'api/playlists';
String SEARCH_ALBUM_PATH = 'api/albums';
String SONG_PATH = 'api/song';
String PLAYLIST_PATH = 'api/playlist';
String PAGE_PATH = 'api/page';
String ALBUM_PATH = 'api/album';
String ARTIST_PATH ='api/artist';
String ADD_PLAYLIST = 'api/playlist/add';
String DELETE_PLAYLIST = 'api/playlist/delete';
String UPDATE_PLAYLIST = 'api/playlist/update';
String UPDATE_FAVORITE = 'api/profile/favorite';
String UPDATE_PROFILE = 'api/profile/update';