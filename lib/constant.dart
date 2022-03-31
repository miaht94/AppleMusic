import 'package:flutter/material.dart';

const String kFontFamily = "Roboto";
const double kDefaultPadding = 10;
const Color kHeadlineColor = Color.fromRGBO(179, 179, 179, 1);//

// padding chiều dọc giữa các component
// VD giữa đừng bỏ lỡ với nghệ sĩ được yêu thích.
const double VerticalComponentPadding = 20;



// CONFIG FOR OAUTH2 GOOGLE API (WITHOUT SECRET KEY, DON'T FIND IT)
Uri REDIRECT_URI = Uri.parse("http://localhost:8080/verify");

const String SV_HOSTNAME = "10.0.2.2";
const int SV_PORT = 8080;
 

// API ENTRY
String MY_PROFILE_PATH = "api/profile/me";