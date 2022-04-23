import 'package:flutter/material.dart';

const String kFontFamily = "Roboto";
const double kDefaultPadding = 10;
const Color kHeadlineColor = Color.fromRGBO(179, 179, 179, 1);//

// padding chiều dọc giữa các component
// VD giữa đừng bỏ lỡ với nghệ sĩ được yêu thích.
const double VerticalComponentPadding = 20;



// CONFIG FOR OAUTH2 GOOGLE API (WITHOUT SECRET KEY, DON'T FIND IT)
// Uri REDIRECT_URI = Uri.parse("http://koyomiku39.moe/verify");
Uri REDIRECT_URI = Uri.parse("http://koyomiku39.moe/verify");

const String SV_HOSTNAME = "koyomiku39.moe";
const int SV_PORT = 80;
 

// API ENTRY
String MY_PROFILE_PATH = "api/profile/me";
String SEARCH_SONG_PATH = "api/songs";
String SEARCH_ARTIST_PATH = "api/artistes";
String SEARCH_PLAYLIST_PATH = "api/playlists";
String SEARCH_ALBUM_PATH = "api/albums";
String SONG_PATH = "api/song";
