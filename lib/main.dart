import 'package:apple_music/components/AudioController/AudioManager.dart';
import 'package:apple_music/components/AudioController/AudioPageRouteManager.dart';
// import 'package:apple_music/components/AudioController/AudioUi.dart';
// import 'package:apple_music/components/ContextMenu/ContextMenu.dart';
import 'package:apple_music/components/ContextMenu/ContextMenuManager.dart';
import 'package:apple_music/components/CustomBottomAppBar/CustomBottomAppBar.dart';
import 'package:apple_music/pages/DiscoveryPage.dart';
import 'package:apple_music/pages/LibraryPage.dart';
import 'package:apple_music/pages/ListeningNow.dart';
// import 'package:apple_music/pages/DiscoveryPage.dart';
// import 'package:apple_music/pages/LibraryPage.dart';
// import 'package:apple_music/pages/ListeningNow.dart';
import 'package:apple_music/pages/LoginPage.dart';
import 'package:apple_music/pages/SearchPage.dart';
import 'package:apple_music/pages/WelcomePage.dart';
import 'package:apple_music/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bach Music',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/loginPage': (context) => const LoginPage(),
        '/welcomePage': (context) => const WelcomePage(),
        '/homePage': (context) => const MyHomePage(),
        // '/playingPage': (context) => AudioUi(),
        // '/test': (context) => Test()
      },
      builder: EasyLoading.init(),
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
  AudioPageRouteManager audioPageRouteManager = getIt<AudioPageRouteManager>();
  final AudioManager _audioManager = getIt<AudioManager>();
  ContextMenuManager contextMenuManager = getIt<ContextMenuManager>();
  @override
  void initState() {
    super.initState();
    pageController = PageController();
    _audioManager.init();
    pageController = PageController();
  }

  @override
  void dispose(){
    _audioManager.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    contextMenuManager.context = context;
    audioPageRouteManager.setMainContext(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            Scaffold(
            resizeToAvoidBottomInset: false,
            body:
              LayoutBuilder(

                builder: (context, _) { 
                  audioPageRouteManager.setSecondaryContext(context);
                  return MainScreenPageView(pageController: pageController);
                }
              )
            )
          )
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: CustomBottomAppBar(pageController: pageController)
        ),
      ], )

    );
  }
}

class MainScreenPageView extends StatelessWidget {
  const MainScreenPageView({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
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
        SearchPage()
      ],
    );
  }
}