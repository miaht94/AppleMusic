import 'dart:async';

import 'package:apple_music/components/CustomBottomAppBar/CustomBottomAppBar.dart';
import 'package:apple_music/constant.dart';
import 'package:apple_music/pages/DiscoveryPage.dart';
import 'package:apple_music/components/HorizontalCard/HorizontalCard.dart';
import 'package:apple_music/components/SongCardInPlaylist/HScrollCardListWithText.dart';
import 'package:apple_music/components/SongCardInPlaylist/HScroll_CardList.dart';
import 'package:apple_music/components/SongCardInPlaylist/SongCardInPlaylist.dart';
import 'package:apple_music/components/TextListView/TextListView.dart';
import 'package:apple_music/components/squareCard/HScrollSquareCardWithText.dart';
import 'package:apple_music/pages/LibraryPage.dart';
import 'package:apple_music/pages/ListeningNow.dart';
import 'package:apple_music/pages/LoginPage.dart';
import 'package:apple_music/test.dart';
import 'package:flutter/material.dart';
import 'test.dart';
import 'dart:io';

import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:url_launcher/url_launcher.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter/services.dart' show PlatformException;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key ? key
  }): super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key ? key,
    required this.title
  }): super(key: key);
  final String title;
  @override
  State < MyHomePage > createState() => _MyHomePageState();
}
class _MyHomePageState extends State < MyHomePage > {
  int _counter = 0;
  late PageController pageController;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body:
      Test()
    );
  }
}

