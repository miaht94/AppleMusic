import 'dart:async';

import 'package:apple_music/components/ButtonPausePlay/PausePlayButton.dart';
import 'package:apple_music/components/CustomBottomAppBar/CustomBottomAppBar.dart';
import 'package:apple_music/constant.dart';
import 'package:apple_music/models/AlbumViewModel.dart';
import 'package:apple_music/models/ArtistViewModel.dart';
import 'package:apple_music/models/CredentialModel.dart';
import 'package:apple_music/models/UserModel.dart';
import 'package:apple_music/models_refactor/ArtistModel.dart';
import 'package:apple_music/models_refactor/SongModel.dart';
import 'package:apple_music/pages/AlbumPage.dart';
import 'package:apple_music/pages/ArtistPage.dart';
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
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:get_it/get_it.dart';
import 'components/ButtonWithIcon/WideButton.dart';
import 'test.dart';
import 'services/service_locator.dart';
import 'package:apple_music/services/http_util.dart';

import 'dart:io';

// import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:url_launcher/url_launcher.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter/services.dart' show PlatformException, SystemChrome, SystemUiMode, SystemUiOverlay;
void main() {
  setUpGetIt();
  GetIt.I.registerLazySingleton<CredentialModelNotifier>(() => CredentialModelNotifier(CredentialModel("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRyYW54dWFuYmFjaDNAZ21haWwuY29tIiwiaWRUb2tlbiI6ImV5SmhiR2NpT2lKU1V6STFOaUlzSW10cFpDSTZJbVl4TXpNNFkyRXlOamd6TlRnMk0yWTJOekUwTURobU5ERTNNemhoTjJJME9XVTNOREJtWXpBaUxDSjBlWEFpT2lKS1YxUWlmUS5leUpwYzNNaU9pSm9kSFJ3Y3pvdkwyRmpZMjkxYm5SekxtZHZiMmRzWlM1amIyMGlMQ0poZW5BaU9pSXhNekkxTnpJME5qUXpOemN0WlRsaGRta3lNakp4WTI5dU5HWnZORGxyZFdabGRUZHlhRzF6Ym1wME1Ha3VZWEJ3Y3k1bmIyOW5iR1YxYzJWeVkyOXVkR1Z1ZEM1amIyMGlMQ0poZFdRaU9pSXhNekkxTnpJME5qUXpOemN0WlRsaGRta3lNakp4WTI5dU5HWnZORGxyZFdabGRUZHlhRzF6Ym1wME1Ha3VZWEJ3Y3k1bmIyOW5iR1YxYzJWeVkyOXVkR1Z1ZEM1amIyMGlMQ0p6ZFdJaU9pSXhNRFkyTkRVeU9USXdNRGd3T1RNNU9UTTNOellpTENKbGJXRnBiQ0k2SW5SeVlXNTRkV0Z1WW1GamFETkFaMjFoYVd3dVkyOXRJaXdpWlcxaGFXeGZkbVZ5YVdacFpXUWlPblJ5ZFdVc0ltRjBYMmhoYzJnaU9pSnpOVW8xZDFveE5EbHZjVWhDTFV4VVlYSldUVUpSSWl3aWJtRnRaU0k2SW1obmEyaG5heUJvYTJobmF5SXNJbkJwWTNSMWNtVWlPaUpvZEhSd2N6b3ZMMnhvTXk1bmIyOW5iR1YxYzJWeVkyOXVkR1Z1ZEM1amIyMHZZUzlCUVZSWVFVcDVOMkY0WVRkNFFYWkxTRWw2U1c0d2JsWlVhSGR6TUdoRGVHdFBkbDk1ZEROZmNuSXhaejF6T1RZdFl5SXNJbWRwZG1WdVgyNWhiV1VpT2lKb1oydG9aMnNpTENKbVlXMXBiSGxmYm1GdFpTSTZJbWhyYUdkcklpd2liRzlqWVd4bElqb2lkbWtpTENKcFlYUWlPakUyTlRBd01UTXlNREVzSW1WNGNDSTZNVFkxTURBeE5qZ3dNWDAuSExMWWxMMFJaTHR6QmZMdVVDN0FkTjdsaFE1NXM4WjNPcGl5OS1FVXRQalQ2X0FKbk9sVHUxVHhsVDU1djZ2bFIzQTNRVmRSRkNOTGN2SDhONk5fRzdraEpscHpIZ191MUVfVEEwYzlMQzl2Nm5wLTJmQmdhNzJEZXVFLUZPVzhnODJnd3lObnhLX2xNN0FUOTBCNTlQbkxzekhTUXZ1QXRhNG1MOTBPaG04SC1KdFJ2TUNiaEktYkprUjY2Qzc0dnhXSHVTdWRoQ0k1ZEYza1dmaTlUOHpWOElLNHY2ZHBxcmowU0paSG1LbGFrU0E0VTRvOWNpM3c2WG1OVWM0bnphZEQ0bVZDMFVwSy16VGFkYzNLWVl4OE1OV2J0eFRpLWJ2N2QtTVN1bzluNTJ4VVIzNXlIZzBYVHR0aExSRkNVUnB0dk9YUE1HM0tkMC1QLW9NUkdnIiwiY3JlYXRlZERhdGUiOjE2NTAwMTMyMDE4MjMsImlhdCI6MTY1MDAxMzIwMSwiZXhwIjoxNjUzNjEzMjAxfQ.Lr5tvf4lY70-DUo6MAIIv25KUgkxRMRtuMKjQ6dTy68")));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key ? key
  }): super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
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

  Future<void> test() async {
    List<ArtistModel?>? artist = await HttpUtil().searchArtistModel(
      artist_name : "T",
    );
    print(artist![1]!.artist_name);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MediaQuery(
      data: MediaQueryData(size: Size(370, 720)),
      child: MaterialApp(
        home: Scaffold(
          body: Container(
              color: Colors.black,
              child: IconButton(
                icon: Icon(Icons.album),
                onPressed: test,
              ),
            ),
        ),
        ),
    );
  }
}

