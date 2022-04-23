import 'package:apple_music/components/AudioController/AudioManager.dart';
import 'package:apple_music/components/AudioController/AudioPageRouteManager.dart';
import 'package:apple_music/components/AudioController/AudioUi.dart';
import 'package:apple_music/components/CustomBottomAppBar/CustomBottomAppBar.dart';
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
import 'package:apple_music/pages/WelcomePage.dart';
import 'package:apple_music/services/service_locator.dart';
import 'package:apple_music/test.dart';
import 'package:flutter/material.dart';
import 'test.dart';

void main() {
  setUpGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key ? key
  }): super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/loginPage': (context) => LoginPage(),
        '/welcomePage': (context) => const WelcomePage(),
        '/homePage': (context) => const MyHomePage(),
        '/playingPage': (context) => AudioUi(),
      },
      initialRoute: '/loginPage',
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key ? key,
  }): super(key: key);
  
  @override
  State < MyHomePage > createState() => _MyHomePageState();
}

class _MyHomePageState extends State < MyHomePage > {
  late PageController pageController;
  late AudioPageRouteManager audioPageRouteManager = getIt<AudioPageRouteManager>();
  final AudioManager _audioManager = getIt<AudioManager>();
  @override
  void initState() {
    super.initState();
    pageController = new PageController();
  }

  @override
  void dispose(){
    _audioManager.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    GlobalKey bodyKey = GlobalKey();
    audioPageRouteManager.setMainContext(context);
    return Scaffold(
      body:
      Stack(children: [
        Positioned(
          top: 0,
          left: 0,
          width: size.width,
          height: size.height,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
          
            ),
            
            home:
            Scaffold(key: bodyKey, body:
              PageView(
                scrollDirection: Axis.horizontal,
                controller: pageController,
                children: const < Widget > [
                  Center(
                    child: ListeningNow(),
                  ),
                  Center(
                    child: DiscoveryPage(),
                  ),
                  Center(
                    child: LibraryPage(),
                  ),
                ],
              ))
          )
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: CustomBottomAppBar(pageController: pageController)
        ),
        // Positioned(
        //     bottom: 0,
        //     left: 0,
        //     child: Text("HelloWorld")
        // ),
      ], )

    );
  }
}