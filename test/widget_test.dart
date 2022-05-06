// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:apple_music/components/RectangleCardSearchPage/AlbumRectangleCard.dart';
import 'package:apple_music/constant.dart';
import 'package:apple_music/models/AlbumRectangleCardModel.dart';
import 'package:apple_music/models/CredentialModel.dart';
import 'package:apple_music/models/UserModel.dart';
import 'package:apple_music/pages/LoginPage.dart';
import 'package:apple_music/pages/SearchPage.dart';
import 'package:apple_music/components/AudioController/AudioManager.dart';
import 'package:apple_music/components/AudioController/AudioStates.dart';
import 'package:apple_music/components/ButtonLyric/LyricButton.dart';
import 'package:apple_music/components/ButtonLyric/LyricButtonConstant.dart';
import 'package:apple_music/components/ButtonLyric/LyricButtonIcon.dart';
import 'package:apple_music/components/ButtonPausePlay/PausePlayButton.dart';
import 'package:apple_music/components/ButtonPausePlay/PausePlayButtonConstant.dart';
import 'package:apple_music/components/ButtonPlaylist/PlaylistButton.dart';
import 'package:apple_music/components/CircleCard/CircleCard.dart';
import 'package:apple_music/components/HorizontalCard/HorizontalCard.dart';
import 'package:apple_music/components/PlayingSongCard/PlayingSongCard.dart';
import 'package:apple_music/components/RectangleCardSearchPage/AlbumRectangleCard.dart';
import 'package:apple_music/components/RepeatButton/RepeatButton.dart';
import 'package:apple_music/components/ShuffleButton/ShuffleButton.dart';
import 'package:apple_music/components/VerticalBigCard/VerticalBigCard.dart';
import 'package:apple_music/components/squareCard/SquareCard.dart';
import 'package:apple_music/models/AlbumRectangleCardModel.dart';
import 'package:apple_music/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:integration_test/integration_test.dart';
import 'package:apple_music/main.dart'
as app;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:http/http.dart'
as http;
import 'dart:convert' show utf8;
import 'mock_value.dart';
import 'widget_test.mocks.dart';



@GenerateMocks([LoginUtil, http.Client])
void main() {
  
  group('widget test', () {
    
    group('cards widget test', () {
    
    testWidgets('Test AlbumRectangleCard widget', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await GetIt.I.reset();
      setUpGetIt();
      final AlbumRectangleCardModel albumRectangleCardModel = AlbumRectangleCardModel('TestId', 'Red', 'Pop', 'https://img-s-msn-com.akamaized.net/tenant/amp/entityid/AAWIpr3.img?w=645&h=484&m=6&x=124&y=145&s=425&d=187', 'Taylor Swift');
      await tester.pumpWidget(
        MediaQuery(
          data: MediaQueryData(size: Size(370, 720)),
          child: MaterialApp(
            home: Scaffold(
              body: AlbumRectangleCard(albumRectangleCardModel: albumRectangleCardModel),
            ),
          ),
        ));

      expect(find.text('Red'), findsOneWidget);
      expect(find.text('Taylor Swift - Album'), findsOneWidget);
    });
    // IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    // debugDumpApp();
    testWidgets('Test CircleCard widget', (WidgetTester tester) async {
        // Build our app and trigger a frame.

        final CircleCard circleCard = CircleCard(
          imageUrl: 'https://img-s-msn-com.akamaized.net/tenant/amp/entityid/AAWIpr3.img?w=645&h=484&m=6&x=124&y=145&s=425&d=187',
          artist: 'Taylor Swift',
          id: 1111,);

        await mockNetworkImagesFor(() => tester.pumpWidget(
            MediaQuery(
              data: MediaQueryData(size: Size(370, 720)),
              child: MaterialApp(
                home: Scaffold(
                  body: circleCard,
                ),
              ),
            )));

        expect(find.text('Taylor Swift'), findsOneWidget);
    });


    testWidgets('Test SquareCard widget', (WidgetTester tester) async {
      // Build our app and trigger a frame.

      final SquareCard squareCard = SquareCard(
        imageUrl: 'https://img-s-msn-com.akamaized.net/tenant/amp/entityid/AAWIpr3.img?w=645&h=484&m=6&x=124&y=145&s=425&d=187',
        artist: 'Taylor Swift',
        id: 1111,
        name: 'Red',
        width: 200,
      );

      await mockNetworkImagesFor(() => tester.pumpWidget(
          MediaQuery(
            data: MediaQueryData(size: Size(370, 720)),
            child: MaterialApp(
              home: Scaffold(
                body: squareCard,
              ),
            ),
          )));

      expect(find.text('Taylor Swift'), findsOneWidget);
      expect(find.text('Red'), findsOneWidget);
    });

    testWidgets('Test HorizontalCard widget', (WidgetTester tester) async {
      // Build our app and trigger a frame.

      final HorizontalCard horizontalCard = HorizontalCard(
        primaryImagePath: 'https://img-s-msn-com.akamaized.net/tenant/amp/entityid/AAWIpr3.img?w=645&h=484&m=6&x=124&y=145&s=425&d=187',
        secondaryImagePath: 'https://img-s-msn-com.akamaized.net/tenant/amp/entityid/AAWIpr3.img?w=645&h=484&m=6&x=124&y=145&s=425&d=187',
        id: "11",
        secondaryDes : 'Red',
      );

      await mockNetworkImagesFor(() => tester.pumpWidget(
          MediaQuery(
            data: MediaQueryData(size: Size(370, 720)),
            child: MaterialApp(
              home: Scaffold(
                body: horizontalCard,
              ),
            ),
          )));

      expect(find.text('Red'), findsOneWidget);
    });

    testWidgets('Test PlayingSongCard widget', (WidgetTester tester) async {
      // Build our app and trigger a frame.

      final PlayingSongCard playingSongCard = PlayingSongCard(
        songName: 'Red',
        artURL: 'https://img-s-msn-com.akamaized.net/tenant/amp/entityid/AAWIpr3.img?w=645&h=484&m=6&x=124&y=145&s=425&d=187',
        artistName: 'Taylor Swift',
      );

      await mockNetworkImagesFor(() => tester.pumpWidget(
          MediaQuery(
            data: MediaQueryData(size: Size(370, 720)),
            child: MaterialApp(
              home: Scaffold(
                body: playingSongCard,
              ),
            ),
          )));

      expect(find.text('Red'), findsOneWidget);
      expect(find.text('Taylor Swift'), findsOneWidget);
    });

    testWidgets('Test PlayingSongCard widget', (WidgetTester tester) async {
      // Build our app and trigger a frame.

      final VerticalBigCard verticalBigCard = VerticalBigCard(
        description: 'Red',
        imagePath: 'https://img-s-msn-com.akamaized.net/tenant/amp/entityid/AAWIpr3.img?w=645&h=484&m=6&x=124&y=145&s=425&d=187',
        footerColor: Colors.white12,
      );

      await mockNetworkImagesFor(() => tester.pumpWidget(
          MediaQuery(
            data: MediaQueryData(size: Size(370, 720)),
            child: MaterialApp(
              home: Scaffold(
                body: verticalBigCard,
              ),
            ),
          )));

      expect(find.text('Red'), findsOneWidget);
      });
    });

    group('button widget test', (){
    testWidgets('test PausePlayButton', (WidgetTester tester) async {

      // Provide the childWidget to the Container.
      await tester.pumpWidget(MediaQuery(
        data: MediaQueryData(size: Size(370, 720)),
        child: MaterialApp(
          home: Scaffold(
            body: Container(
              color: Colors.black,
              child: PausePlayButton()
            ),
          ),
        ),
      ));

      // Search for the childWidget in the tree and verify it exists.
      expect(find.byIcon(SFSymbols.play_fill), findsOneWidget);
      });

    testWidgets('test PlaylistButton', (WidgetTester tester) async {

      // Provide the childWidget to the Container.
      await tester.pumpWidget(MediaQuery(
        data: MediaQueryData(size: Size(370, 720)),
        child: MaterialApp(
          home: Scaffold(
            body: Container(
                color: Colors.black,
                child: PlaylistButton()
            ),
          ),
        ),
      ));

      // Search for the childWidget in the tree and verify it exists.
      expect(find.byIcon(SFSymbols.square_list_fill), findsOneWidget);
    });

    testWidgets('test ShuffleButton', (WidgetTester tester) async {

      // Provide the childWidget to the Container.
      await tester.pumpWidget(MediaQuery(
        data: MediaQueryData(size: Size(370, 720)),
        child: MaterialApp(
          home: Scaffold(
            body: Container(
                color: Colors.black,
                child: ShuffleButton()
            ),
          ),
        ),
      ));

      // Search for the childWidget in the tree and verify it exists.
      expect(find.byIcon(SFSymbols.shuffle), findsOneWidget);
    });

    testWidgets('test RepeatButton', (WidgetTester tester) async {

      // Provide the childWidget to the Container.
      await tester.pumpWidget(MediaQuery(
        data: MediaQueryData(size: Size(370, 720)),
        child: MaterialApp(
          home: Scaffold(
            body: Container(
                color: Colors.black,
                child: RepeatButton()
            ),
          ),
        ),
      ));

      // Search for the childWidget in the tree and verify it exists.
      expect(find.byIcon(SFSymbols.repeat), findsOneWidget);
      
    });

    });
    
  });
 
  group('end-to-end test', () {
    
    testWidgets('Login persistency (with mock token)',
      (WidgetTester tester) async {
        await GetIt.I.reset();
        await mockNetworkImagesFor(() async {
          String mockToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRyYW54dWFuYmFjaDFAZ21haWwuY29tIiwiaWRUb2tlbiI6ImV5SmhiR2NpT2lKU1V6STFOaUlzSW10cFpDSTZJbVl4TXpNNFkyRXlOamd6TlRnMk0yWTJOekUwTURobU5ERTNNemhoTjJJME9XVTNOREJtWXpBaUxDSjBlWEFpT2lKS1YxUWlmUS5leUpwYzNNaU9pSm9kSFJ3Y3pvdkwyRmpZMjkxYm5SekxtZHZiMmRzWlM1amIyMGlMQ0poZW5BaU9pSXhNekkxTnpJME5qUXpOemN0WlRsaGRta3lNakp4WTI5dU5HWnZORGxyZFdabGRUZHlhRzF6Ym1wME1Ha3VZWEJ3Y3k1bmIyOW5iR1YxYzJWeVkyOXVkR1Z1ZEM1amIyMGlMQ0poZFdRaU9pSXhNekkxTnpJME5qUXpOemN0WlRsaGRta3lNakp4WTI5dU5HWnZORGxyZFdabGRUZHlhRzF6Ym1wME1Ha3VZWEJ3Y3k1bmIyOW5iR1YxYzJWeVkyOXVkR1Z1ZEM1amIyMGlMQ0p6ZFdJaU9pSXhNREU1TkRNME1qY3lNRE14T0RJMk16RTRORFVpTENKbGJXRnBiQ0k2SW5SeVlXNTRkV0Z1WW1GamFERkFaMjFoYVd3dVkyOXRJaXdpWlcxaGFXeGZkbVZ5YVdacFpXUWlPblJ5ZFdVc0ltRjBYMmhoYzJnaU9pSndTV2xDWWxWUU1uRTBiSFo0VUhOblJqY3dWMVJSSWl3aWJtRnRaU0k2SWtMRG9XTm9JRlJ5NGJxbmJpQllkY09pYmlJc0luQnBZM1IxY21VaU9pSm9kSFJ3Y3pvdkwyeG9NeTVuYjI5bmJHVjFjMlZ5WTI5dWRHVnVkQzVqYjIwdllTMHZRVTlvTVRSSGFGbDFNRWxUUkVWRlF6RmtjVUZqWTFaak0wa3lVVUU1TWpnek0zZG5kemRtTUhOcVduQnNaejF6T1RZdFl5SXNJbWRwZG1WdVgyNWhiV1VpT2lKQ3c2RmphQ0lzSW1aaGJXbHNlVjl1WVcxbElqb2lWSExodXFkdUlGaDF3Nkp1SWl3aWJHOWpZV3hsSWpvaWRta2lMQ0pwWVhRaU9qRTJORGs1TXpVeE9ESXNJbVY0Y0NJNk1UWTBPVGt6T0RjNE1uMC5VMndheDN1WXY0QnQ0WkRzdFFGQVFZbEpRMFVud3R2SFZLcUx0TnBXcDRwRUF2ZVpwM3BfaVRpbzdURXF2QmpQWnFfRkhjTmtCcEhFUlRXTWdxQ3RWZTA1TmVaX3VNdUxNb1haaGJoZDk0Z0hNcnFqdWtUVGVFVGtWMjNFMnlhUXRRVGFETHdmd2lSenl5Q19KYmU3YUlRdVhIWkF3Mzc5YUhaNm8xcmhmeWpPU1F6YklnU2ZiaThoVU9WekQ4QTd0MGtGWjU1VjkxeHR0eTRZSThlaTNPQ2NuLWcxanVURVg2SG9jMDk2NGY2RVNuNEpFWGN2Y3ZZQWw1Qy1UdW1LdXZ6aklrSlE0ZWtPYURBcjVIQTFEcV90S0dubXJYdzRVbmV5cXpzbUUzTFJlajRCaFlPSFFlbWhoU1p3TkZjYWtNOUVxbFNpTXNHUkMtT2tFMkFacXciLCJjcmVhdGVkRGF0ZSI6MTY0OTkzNTE4MjgyOCwiaWF0IjoxNjQ5OTM1MTgyLCJleHAiOjE2NTM1MzUxODJ9.y4v2UzG2_djlJc9O_gcVAQfWktdzN_TLJet6rrD9dHI';
          var loginUtil = MockLoginUtil();
          var mockClient = MockClient();
          final Uri pageUri = Uri(scheme: 'http',
            host: SV_HOSTNAME,
            port: SV_PORT,
            path: PAGE_PATH,
            queryParameters: {
              'page_name': 'ListeningNow'
            });

          final playlistUri = Uri(scheme: 'http', host: SV_HOSTNAME, port: SV_PORT, path: PLAYLIST_PATH, queryParameters: {
            '_id': mockPlaylist['_id'],
            'app_token': mockToken,
            'public': '1',
          });
          final playlistPublicUri = Uri(scheme: 'http', host: SV_HOSTNAME, port: SV_PORT, path: PLAYLIST_PATH, queryParameters: {
            '_id': mockPlaylistPublic['_id'],
            'app_token': mockToken,
            'public': '1',
          });
          final artistUri = Uri(scheme: 'http', host: SV_HOSTNAME, port: SV_PORT, path: ARTIST_PATH, queryParameters: {
            '_id': mockArtist['_id']
          });
          final songUri = Uri(scheme: 'http', host: SV_HOSTNAME, port: SV_PORT, path: SONG_PATH, queryParameters: {
            '_id': '625ecfc7133da5aa54397e1e'
          });
          when(mockClient.get(pageUri)).thenAnswer((realInvocation) => Future.value(http.Response(jsonEncode(mockListeningPage), 200)));
          when(mockClient.get(playlistUri)).thenAnswer((realInvocation) => Future.value(http.Response.bytes(Utf8Encoder().convert(jsonEncode(mockPlaylist)), 200)));
          when(mockClient.get(playlistPublicUri)).thenAnswer((realInvocation) => Future.value(http.Response.bytes(Utf8Encoder().convert(jsonEncode(mockPlaylistPublic)), 200)));
          when(mockClient.get(songUri)).thenAnswer((realInvocation) => Future.value(http.Response.bytes(Utf8Encoder().convert(jsonEncode(mockSong)), 200)));
          when(mockClient.get(artistUri)).thenAnswer((realInvocation) => Future.value(http.Response.bytes(Utf8Encoder().convert(jsonEncode(mockArtist)), 200)));
          
          if (GetIt.I.isRegistered < LoginUtil > ()) {
            GetIt.I.unregister < LoginUtil > ();
          }
          GetIt.I.registerLazySingleton < LoginUtil > (() => loginUtil);
          if (GetIt.I.isRegistered < http.Client > ()) {
            GetIt.I.unregister < http.Client > ();
          }
          GetIt.I.registerLazySingleton < http.Client > (() => mockClient);
          when(loginUtil.getUserInfo(mockToken)).thenAnswer((_) =>
            Future.value(UserModel(
              'Bach Tran Xuan',
              'https://lh3.googleusercontent.com/a-/AOh14GhYu0ISDEEC1dqAccVc3I2QA92833wgw7f0sjZplg=s96-c',
              'tranxuanbach1@gmail.com',
              [],
              [],
              [],
              []
            )));
          print(loginUtil.getUserInfo(mockToken));
          when(loginUtil.checkLoginStatus()).thenAnswer((_) async {
            if (GetIt.I.isRegistered < UserModelNotifier > () & GetIt.I.isRegistered < CredentialModelNotifier > ()) {
              GetIt.I.unregister < UserModelNotifier > ();
              GetIt.I.unregister < CredentialModelNotifier > ();
            }
            UserModel user = await loginUtil.getUserInfo(mockToken);
            GetIt.I.registerLazySingleton < UserModelNotifier > (() => UserModelNotifier(user));
            GetIt.I.registerLazySingleton < CredentialModelNotifier > (() => CredentialModelNotifier(CredentialModel(mockToken)));
            return true;
          });
          // final AlbumRectangleCardModel albumRectangleCardModel = AlbumRectangleCardModel('TestId', 'Red', 'Pop', 'https://img-s-msn-com.akamaized.net/tenant/amp/entityid/AAWIpr3.img?w=645&h=484&m=6&x=124&y=145&s=425&d=187', 'Taylor Swift');
          // tester.binding.window.physicalSizeTestValue =
          //   const Size(760, 480);
          // tester.binding.window.devicePixelRatioTestValue = 1.0;
          // app.main();
          await tester.binding.setSurfaceSize(Size(320, 720));
          // setUpGetIt();
          app.main();
          // await tester.pumpWidget(MediaQuery(
          //   data: MediaQueryData(size: Size(320, 720)),
          //   child: SearchPage()
          // ));
          await tester.pumpAndSettle();

          // expect(find.byWidget(CircularProgressIndicator()), findsOneWidget);
          await tester.pumpAndSettle();
          await tester.pump(Duration(seconds: 5));
          await tester.pumpAndSettle();
          // Verify the counter increments by 1.
          expect(find.text('Vu'), findsOneWidget);
          expect(find.text('Đừng bỏ lỡ'), findsOneWidget);
          expect(find.text('Nghe ngay'), findsOneWidget);
        });

      });
  });
}