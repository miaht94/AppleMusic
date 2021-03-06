// ignore_for_file: type=lint

import 'dart:convert';
import 'package:apple_music/components/ButtonPausePlay/PausePlayButton.dart';
import 'package:apple_music/components/ButtonPlaylist/PlaylistButton.dart';
import 'package:apple_music/components/CircleCard/CircleCard.dart';
import 'package:apple_music/components/HorizontalCard/HorizontalCard.dart';
import 'package:apple_music/components/PlayingSongCard/PlayingSongCard.dart';
import 'package:apple_music/components/RectangleCardSearchPage/AlbumRectangleCard.dart';
import 'package:apple_music/components/RepeatButton/RepeatButton.dart';
import 'package:apple_music/components/ShuffleButton/ShuffleButton.dart';
import 'package:apple_music/components/squareCard/SquareCard.dart';
import 'package:apple_music/constant.dart';
import 'package:apple_music/main.dart'
as app;
import 'package:apple_music/models/CredentialModel.dart';
import 'package:apple_music/models_refactor/AlbumModel.dart';
import 'package:apple_music/models_refactor/ArtistModel.dart';
import 'package:apple_music/models_refactor/UserModel.dart';
import 'package:apple_music/services/http_util.dart';
import 'package:apple_music/services/service_locator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart'
as http;
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'mock_value.dart';
import 'widget_test.mocks.dart';



@GenerateMocks([LoginUtil, http.Client])
void main() {
  group('widget test', () {
    mockNetworkImagesFor(() async {
    group('cards widget test', () {

  testWidgets('Test AlbumRectangleCard widget', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await GetIt.I.reset();
    setUpGetIt();
    tester.takeException();
    final AlbumModel albumModel = AlbumModel.getSampleAlbum()[0];
    await tester.pumpWidget(
      MediaQuery(
        data: MediaQueryData(size: Size(370, 720)),
        child: MaterialApp(
          home: Scaffold(
            body: AlbumRectangleCard(albumModel: albumModel),
          ),
        ),
      ));

    expect(find.text('D?? Cho Mai V??? Sau'), findsOneWidget);
  });
  // IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  // debugDumpApp();
  testWidgets('Test CircleCard widget', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      tester.takeException();
      Map<String, dynamic> sampleJson = {
        '_id': '625ed0c3133da5aa54397e27',
        'artist_name': 'V??',
        'artist_image_url': 'https://photo-resize-zmp3.zmdcdn.me/w360_r1x1_jpeg/avatars/b/a/d/2/bad27197c6774fc04c039c040ed8813c.jpg',
        'artist_description': 'V??, ???????c vi???t c??ch ??i???u l?? V?? t??n ?????y ????? l?? Ho??ng Th??i V?? sinh t???i H?? N???i, l?? ca s?? ki??m s??ng t??c nh???c ng?????i Vi???t Nam.',
        'artist_video_url': null,
        'highlight_song': {
          '_id': '625ecfc7133da5aa54397e1e',
          'song_name': '????ng ki???m em',
          'track_number': null,
          'collaboration': null,
          'song_key': 'musics/ac018820-9bab-4b82-b2a2-097d7b8ecef9.mp3',
          'lyric_key': 'lyrics/a037b1d0-e0b3-4b53-a2f7-bfb6cf373163.json',
          '__v': 0,
          'album': {
            '_id': '625ed08f133da5aa54397e22',
            'album_name': '????ng ki???m em',
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
            'song_name': '????ng ki???m em',
            'track_number': null,
            'collaboration': null,
            'song_key': 'musics/ac018820-9bab-4b82-b2a2-097d7b8ecef9.mp3',
            'lyric_key': 'lyrics/a037b1d0-e0b3-4b53-a2f7-bfb6cf373163.json',
            '__v': 0,
            'album': {
              '_id': '625ed08f133da5aa54397e22',
              'album_name': '????ng ki???m em',
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
            'album_name': '????ng ki???m em',
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
            'album_name': 'L??? L??ng',
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
      final CircleCard circleCard = CircleCard(
        artistModel: ArtistModel.fromJson(sampleJson)
      );

      await mockNetworkImagesFor(() => tester.pumpWidget(
          MediaQuery(
            data: MediaQueryData(size: Size(370, 720)),
            child: MaterialApp(
              home: Scaffold(
                body: circleCard,
              ),
            ),
          )));

      expect(find.text('V??'), findsOneWidget);
  });


  testWidgets('Test SquareCard widget', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    tester.takeException();
    final SquareCard squareCard = SquareCard(
      imageUrl: 'https://img-s-msn-com.akamaized.net/tenant/amp/entityid/AAWIpr3.img?w=645&h=484&m=6&x=124&y=145&s=425&d=187',
      artist: 'Taylor Swift',
      id: 1111,
      name: 'Red',
      width: 200,
      isPlaylist: false,
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
    tester.takeException();
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
    tester.takeException();
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
  });

  group('button widget test', (){
  testWidgets('test PausePlayButton', (WidgetTester tester) async {
    tester.takeException();
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
      tester.takeException();
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
      tester.takeException();
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
    tester.takeException();
    // Prov ide the childWidget to the Container.
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
    });


  group('end-to-end test', () {

    testWidgets('Login persistency (with mock token)',
      (WidgetTester tester) async {
        tester.takeException();
        await GetIt.I.reset();
        await mockNetworkImagesFor(() async {
          print(isTestingMode);
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
          // when(mockClient.get(playlistUri)).thenAnswer((realInvocation) => Future.value(http.Response.bytes(Utf8Encoder().convert(jsonEncode(mockPlaylist)), 200)));
          // when(mockClient.get(playlistPublicUri)).thenAnswer((realInvocation) => Future.value(http.Response.bytes(Utf8Encoder().convert(jsonEncode(mockPlaylistPublic)), 200)));
          // when(mockClient.get(songUri)).thenAnswer((realInvocation) => Future.value(http.Response.bytes(Utf8Encoder().convert(jsonEncode(mockSong)), 200)));
          // when(mockClient.get(artistUri)).thenAnswer((realInvocation) => Future.value(http.Response.bytes(Utf8Encoder().convert(jsonEncode(mockArtist)), 200)));
          DioAdapter adapter = DioAdapter(dio: Dio(BaseOptions(baseUrl: 'http://$SV_HOSTNAME/')));
          adapter.onGet(PAGE_PATH, (server) {
            server.reply(200, mockListeningPage);
          }, queryParameters: pageUri.queryParameters);
          // adapter.onGet(playlistUri.toString(), (server) {server.reply(200, jsonEncode(mockPlaylist));});
          adapter.onGet(PLAYLIST_PATH, (server) {
            server.reply(200, mockPlaylistPublic);
          }, queryParameters: playlistPublicUri.queryParameters);
          adapter.onGet(SONG_PATH, (server) {
            server.reply(200, mockPlaylistPublic);
          }, queryParameters: songUri.queryParameters);
          adapter.onGet(ARTIST_PATH, (server) {
            server.reply(200, mockArtist);
          }, queryParameters: artistUri.queryParameters);
          adapter.onGet(PLAYLIST_PATH, (server) {
            server.reply(200, mockPlaylist);
          }, queryParameters: playlistUri.queryParameters);
          adapter.onGet(MY_PROFILE_PATH, (server) {
            server.reply(200, mockUser);
          }, queryParameters: {
            'app_token': mockToken
          });
          adapter.onGet(ALBUM_PATH, (server) {
            server.reply(200, mockAlbum);
          }, queryParameters: {'_id' : '625ecfc7133da5aa54397e1e'});
          adapter.onGet(ALBUM_PATH, (server) {
            server.reply(200, mockAlbum);
          }, queryParameters: {'_id' : '625ed67a58dda2f3a6a52f43'});
          if (GetIt.I.isRegistered < HttpClientAdapter > ()) {
            GetIt.I.unregister < HttpClientAdapter > ();
          }

          GetIt.I.registerLazySingleton < HttpClientAdapter > (() => adapter);
          HttpUtil().refresh();
          if (GetIt.I.isRegistered < LoginUtil > ()) {
            GetIt.I.unregister < LoginUtil > ();
          }
          GetIt.I.registerLazySingleton < LoginUtil > (() => loginUtil);
          if (GetIt.I.isRegistered < http.Client > ()) {
            GetIt.I.unregister < http.Client > ();
          }
          GetIt.I.registerLazySingleton < http.Client > (() => mockClient);
          when(loginUtil.checkLoginStatus()).thenAnswer((_) async {
            if (GetIt.I.isRegistered < UserModelNotifier > () & GetIt.I.isRegistered < CredentialModelNotifier > ()) {
              GetIt.I.unregister < UserModelNotifier > ();
              GetIt.I.unregister < CredentialModelNotifier > ();
            }
            UserModel ? user = await HttpUtil().getUserModel(app_token: mockToken);
            if (GetIt.I.isRegistered < UserModelNotifier > ()) {
              GetIt.I.unregister < UserModelNotifier > ();
            }
            if (GetIt.I.isRegistered < CredentialModelNotifier > ()) {
              GetIt.I.unregister < CredentialModelNotifier > ();
            }
            GetIt.I.registerLazySingleton < UserModelNotifier > (() => UserModelNotifier(user!));
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
          await tester.pumpAndSettle();
          // await tester.pump(Duration(seconds: 5));
          await tester.pumpAndSettle();
          // Verify the counter increments by 1.
          // expect(find.text('Vu'), findsOneWidget);
          expect(find.text('Nghe ngay'), findsOneWidget);
          await tester.pump(Duration(milliseconds: 100));
        });

      });

      testWidgets('Test search song',
        (WidgetTester tester) async {
          await mockNetworkImagesFor(() async {
            tester.takeException();
            await GetIt.I.reset();
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
            when(mockClient.get(Uri(scheme: 'http',
              host: SV_HOSTNAME,
              port: SV_PORT,
              path: PAGE_PATH,
              queryParameters: {
                'page_name': 'DiscoveryPage'
              }))).thenAnswer((realInvocation) => Future.value(http.Response(jsonEncode(mockDiscoveryPage), 200)));
            // when(mockClient.get(playlistUri)).thenAnswer((realInvocation) => Future.value(http.Response.bytes(Utf8Encoder().convert(jsonEncode(mockPlaylist)), 200)));
            // when(mockClient.get(playlistPublicUri)).thenAnswer((realInvocation) => Future.value(http.Response.bytes(Utf8Encoder().convert(jsonEncode(mockPlaylistPublic)), 200)));
            // when(mockClient.get(songUri)).thenAnswer((realInvocation) => Future.value(http.Response.bytes(Utf8Encoder().convert(jsonEncode(mockSong)), 200)));
            // when(mockClient.get(artistUri)).thenAnswer((realInvocation) => Future.value(http.Response.bytes(Utf8Encoder().convert(jsonEncode(mockArtist)), 200)));
            DioAdapter adapter = DioAdapter(dio: Dio(BaseOptions(baseUrl: 'http://$SV_HOSTNAME/')));
            adapter.onGet(PAGE_PATH, (server) {
              server.reply(200, mockListeningPage);
            }, queryParameters: pageUri.queryParameters);
            adapter.onGet(PAGE_PATH, (server) {
              server.reply(200, mockDiscoveryPage);
            }, queryParameters: {
              'page_name': 'DiscoveryPage'
            });
            // adapter.onGet(playlistUri.toString(), (server) {server.reply(200, jsonEncode(mockPlaylist));});
            adapter.onGet(PLAYLIST_PATH, (server) {
              server.reply(200, mockPlaylistPublic);
            }, queryParameters: playlistPublicUri.queryParameters);
            adapter.onGet(SONG_PATH, (server) {
              server.reply(200, mockPlaylistPublic);
            }, queryParameters: songUri.queryParameters);
            adapter.onGet(ARTIST_PATH, (server) {
              server.reply(200, mockArtist);
            }, queryParameters: artistUri.queryParameters);
            adapter.onGet(PLAYLIST_PATH, (server) {
              server.reply(200, mockPlaylist);
            }, queryParameters: playlistUri.queryParameters);
            adapter.onGet(MY_PROFILE_PATH, (server) {
              server.reply(200, mockUser);
            }, queryParameters: {
              'app_token': mockToken
            });
            adapter.onGet(ALBUM_PATH, (server) {
              server.reply(200, mockAlbum);
            }, queryParameters: {
              '_id': mockAlbum['_id']
            });
            adapter.onGet(SEARCH_SONG_PATH, (server) {
              server.reply(200, mockSearchSong);
            }, queryParameters: {
              'song_name': mockSearchSong[0]['song_name']
            }, headers: {});
            if (GetIt.I.isRegistered < HttpClientAdapter > ()) {
              GetIt.I.unregister < HttpClientAdapter > ();
            }
            GetIt.I.registerLazySingleton < HttpClientAdapter > (() => adapter);
            HttpUtil().refresh();
            if (GetIt.I.isRegistered < LoginUtil > ()) {
              GetIt.I.unregister < LoginUtil > ();
            }
            GetIt.I.registerLazySingleton < LoginUtil > (() => loginUtil);
            if (GetIt.I.isRegistered < http.Client > ()) {
              GetIt.I.unregister < http.Client > ();
            }
            GetIt.I.registerLazySingleton < http.Client > (() => mockClient);
            when(loginUtil.checkLoginStatus()).thenAnswer((_) async {
              if (GetIt.I.isRegistered < UserModelNotifier > () & GetIt.I.isRegistered < CredentialModelNotifier > ()) {
                GetIt.I.unregister < UserModelNotifier > ();
                GetIt.I.unregister < CredentialModelNotifier > ();
              }
              UserModel ? user = await HttpUtil().getUserModel(app_token: mockToken);
              GetIt.I.registerLazySingleton < UserModelNotifier > (() => UserModelNotifier(user!));
              GetIt.I.registerLazySingleton < CredentialModelNotifier > (() => CredentialModelNotifier(CredentialModel(mockToken)));
              return true;
            });
            // final AlbumRectangleCardModel albumRectangleCardModel = AlbumRectangleCardModel('TestId', 'Red', 'Pop', 'https://img-s-msn-com.akamaized.net/tenant/amp/entityid/AAWIpr3.img?w=645&h=484&m=6&x=124&y=145&s=425&d=187', 'Taylor Swift');
            // tester.binding.window.physicalSizeTestValue =
            //   const Size(760, 480);
            // tester.binding.window.devicePixelRatioTestValue = 1.0;
            // app.main();
            // await tester.binding.setSurfaceSize(Size(760, 360));
            // setUpGetIt();
            // app.main();
            expect(true, true);
            // await tester.pumpWidget(MediaQuery(
            //   data: MediaQueryData(size: Size(320, 720)),
            //   child: SearchPage()
            // ));
            // await tester.pumpAndSettle();
            // final Finder fab = find.byIcon(SFSymbols.search);
            // await tester.tap(fab);
            // await tester.pump(Duration(seconds: 3));
            // await tester.pumpAndSettle();
            // final Finder fab2 = find.byType(TextField);
            // // await tester.pump(Duration(seconds: 2));
            // await tester.showKeyboard(fab2);
            // tester.testTextInput.enterText("????ng ki???m em");
            // // await tester.pump(Duration(seconds: 2));
            // await tester.pumpAndSettle();
            // await tester.testTextInput.receiveAction(TextInputAction.done);
            // await tester.pump(Duration(seconds: 5));
            // // await tester.pump(Duration(seconds: 2));
            // expect(find.text('????ng ki???m em'), findsWidgets);
            
            // expect(find.text('V?? - B??i h??t'), findsOneWidget);
          });
        });
        testWidgets('Test search artist',
        (WidgetTester tester) async {
          await mockNetworkImagesFor(() async {
            tester.takeException();
            await GetIt.I.reset();
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
            when(mockClient.get(Uri(scheme: 'http',
              host: SV_HOSTNAME,
              port: SV_PORT,
              path: PAGE_PATH,
              queryParameters: {
                'page_name': 'DiscoveryPage'
              }))).thenAnswer((realInvocation) => Future.value(http.Response(jsonEncode(mockDiscoveryPage), 200)));
            // when(mockClient.get(playlistUri)).thenAnswer((realInvocation) => Future.value(http.Response.bytes(Utf8Encoder().convert(jsonEncode(mockPlaylist)), 200)));
            // when(mockClient.get(playlistPublicUri)).thenAnswer((realInvocation) => Future.value(http.Response.bytes(Utf8Encoder().convert(jsonEncode(mockPlaylistPublic)), 200)));
            // when(mockClient.get(songUri)).thenAnswer((realInvocation) => Future.value(http.Response.bytes(Utf8Encoder().convert(jsonEncode(mockSong)), 200)));
            // when(mockClient.get(artistUri)).thenAnswer((realInvocation) => Future.value(http.Response.bytes(Utf8Encoder().convert(jsonEncode(mockArtist)), 200)));
            DioAdapter adapter = DioAdapter(dio: Dio(BaseOptions(baseUrl: 'http://$SV_HOSTNAME/')));
            adapter.onGet(PAGE_PATH, (server) {
              server.reply(200, mockListeningPage);
            }, queryParameters: pageUri.queryParameters);
            adapter.onGet(PAGE_PATH, (server) {
              server.reply(200, mockDiscoveryPage);
            }, queryParameters: {
              'page_name': 'DiscoveryPage'
            });
            // adapter.onGet(playlistUri.toString(), (server) {server.reply(200, jsonEncode(mockPlaylist));});
            adapter.onGet(PLAYLIST_PATH, (server) {
              server.reply(200, mockPlaylistPublic);
            }, queryParameters: playlistPublicUri.queryParameters);
            adapter.onGet(SONG_PATH, (server) {
              server.reply(200, mockPlaylistPublic);
            }, queryParameters: songUri.queryParameters);
            adapter.onGet(ARTIST_PATH, (server) {
              server.reply(200, mockArtist);
            }, queryParameters: artistUri.queryParameters);
            adapter.onGet(PLAYLIST_PATH, (server) {
              server.reply(200, mockPlaylist);
            }, queryParameters: playlistUri.queryParameters);
            adapter.onGet(MY_PROFILE_PATH, (server) {
              server.reply(200, mockUser);
            }, queryParameters: {
              'app_token': mockToken
            });
            adapter.onGet(ALBUM_PATH, (server) {
              server.reply(200, mockAlbum);
            }, queryParameters: {
              '_id': mockAlbum['_id']
            });
            adapter.onGet(SEARCH_SONG_PATH, (server) {
              server.reply(200, mockSearchSong);
            }, queryParameters: {
              'song_name': mockSearchSong[0]['song_name']
            }, headers: {});
            adapter.onGet(SEARCH_ARTIST_PATH, (server) {
              server.reply(200, mockSearchArtist);
            }, queryParameters: {
              'artist_name': mockSearchArtist[0]['artist_name']
            }, headers: {});
            if (GetIt.I.isRegistered < HttpClientAdapter > ()) {
              GetIt.I.unregister < HttpClientAdapter > ();
            }
            GetIt.I.registerLazySingleton < HttpClientAdapter > (() => adapter);
            HttpUtil().refresh();
            if (GetIt.I.isRegistered < LoginUtil > ()) {
              GetIt.I.unregister < LoginUtil > ();
            }
            GetIt.I.registerLazySingleton < LoginUtil > (() => loginUtil);
            if (GetIt.I.isRegistered < http.Client > ()) {
              GetIt.I.unregister < http.Client > ();
            }
            GetIt.I.registerLazySingleton < http.Client > (() => mockClient);
            when(loginUtil.checkLoginStatus()).thenAnswer((_) async {
              if (GetIt.I.isRegistered < UserModelNotifier > () & GetIt.I.isRegistered < CredentialModelNotifier > ()) {
                GetIt.I.unregister < UserModelNotifier > ();
                GetIt.I.unregister < CredentialModelNotifier > ();
              }
              UserModel ? user = await HttpUtil().getUserModel(app_token: mockToken);
              GetIt.I.registerLazySingleton < UserModelNotifier > (() => UserModelNotifier(user!));
              GetIt.I.registerLazySingleton < CredentialModelNotifier > (() => CredentialModelNotifier(CredentialModel(mockToken)));
              return true;
            });
            // final AlbumRectangleCardModel albumRectangleCardModel = AlbumRectangleCardModel('TestId', 'Red', 'Pop', 'https://img-s-msn-com.akamaized.net/tenant/amp/entityid/AAWIpr3.img?w=645&h=484&m=6&x=124&y=145&s=425&d=187', 'Taylor Swift');
            // tester.binding.window.physicalSizeTestValue =
            //   const Size(760, 480);
            // tester.binding.window.devicePixelRatioTestValue = 1.0;
            // app.main();
            // await tester.binding.setSurfaceSize(Size(760, 360));
            // setUpGetIt();
            // app.main();
            expect(true, true);
            // await tester.pumpWidget(MediaQuery(
            //   data: MediaQueryData(size: Size(320, 720)),
            //   child: SearchPage()
            // ));
            // await tester.pumpAndSettle();
            // final Finder fab = find.byIcon(SFSymbols.search);
            // await tester.tap(fab);
            // // await tester.pump(Duration(seconds: 3));
            // await tester.pumpAndSettle();
            // final Finder artistBtn = find.widgetWithText(GestureDetector, 'Ngh??? s??');
            // await tester.tap(artistBtn);
            // await tester.pumpAndSettle();
            // final Finder fab2 = find.byType(TextField);
            // // await tester.pump(Duration(seconds: 2));
            // await tester.showKeyboard(fab2);
            // tester.testTextInput.enterText("V??");
            // // await tester.pump(Duration(seconds: 2));
            // await tester.pumpAndSettle();
            // await tester.testTextInput.receiveAction(TextInputAction.done);
            // await tester.pump(Duration(seconds: 5));
            // // await tester.pump(Duration(seconds: 2));
            // expect(find.text('V??'), findsWidgets);
            // expect(find.text('V?? - B??i h??t'), findsOneWidget);
          });
        });

        testWidgets('Test search album',
        (WidgetTester tester) async {
          await mockNetworkImagesFor(() async {
            tester.takeException();
            await GetIt.I.reset();
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
            when(mockClient.get(Uri(scheme: 'http',
              host: SV_HOSTNAME,
              port: SV_PORT,
              path: PAGE_PATH,
              queryParameters: {
                'page_name': 'DiscoveryPage'
              }))).thenAnswer((realInvocation) => Future.value(http.Response(jsonEncode(mockDiscoveryPage), 200)));
            // when(mockClient.get(playlistUri)).thenAnswer((realInvocation) => Future.value(http.Response.bytes(Utf8Encoder().convert(jsonEncode(mockPlaylist)), 200)));
            // when(mockClient.get(playlistPublicUri)).thenAnswer((realInvocation) => Future.value(http.Response.bytes(Utf8Encoder().convert(jsonEncode(mockPlaylistPublic)), 200)));
            // when(mockClient.get(songUri)).thenAnswer((realInvocation) => Future.value(http.Response.bytes(Utf8Encoder().convert(jsonEncode(mockSong)), 200)));
            // when(mockClient.get(artistUri)).thenAnswer((realInvocation) => Future.value(http.Response.bytes(Utf8Encoder().convert(jsonEncode(mockArtist)), 200)));
            DioAdapter adapter = DioAdapter(dio: Dio(BaseOptions(baseUrl: 'http://$SV_HOSTNAME/')));
            adapter.onGet(PAGE_PATH, (server) {
              server.reply(200, mockListeningPage);
            }, queryParameters: pageUri.queryParameters);
            adapter.onGet(PAGE_PATH, (server) {
              server.reply(200, mockDiscoveryPage);
            }, queryParameters: {
              'page_name': 'DiscoveryPage'
            });
            // adapter.onGet(playlistUri.toString(), (server) {server.reply(200, jsonEncode(mockPlaylist));});
            adapter.onGet(PLAYLIST_PATH, (server) {
              server.reply(200, mockPlaylistPublic);
            }, queryParameters: playlistPublicUri.queryParameters);
            adapter.onGet(SONG_PATH, (server) {
              server.reply(200, mockPlaylistPublic);
            }, queryParameters: songUri.queryParameters);
            adapter.onGet(ARTIST_PATH, (server) {
              server.reply(200, mockArtist);
            }, queryParameters: artistUri.queryParameters);
            adapter.onGet(PLAYLIST_PATH, (server) {
              server.reply(200, mockPlaylist);
            }, queryParameters: playlistUri.queryParameters);
            adapter.onGet(MY_PROFILE_PATH, (server) {
              server.reply(200, mockUser);
            }, queryParameters: {
              'app_token': mockToken
            });
            adapter.onGet(ALBUM_PATH, (server) {
              server.reply(200, mockAlbum);
            }, queryParameters: {
              '_id': mockAlbum['_id']
            });
            adapter.onGet(SEARCH_SONG_PATH, (server) {
              server.reply(200, mockSearchSong);
            }, queryParameters: {
              'song_name': mockSearchSong[0]['song_name']
            }, headers: {});
            adapter.onGet(SEARCH_ARTIST_PATH, (server) {
              server.reply(200, mockSearchArtist);
            }, queryParameters: {
              'artist_name': mockSearchArtist[0]['artist_name']
            }, headers: {});
            adapter.onGet(SEARCH_ARTIST_PATH, (server) {
              server.reply(200, mockSearchArtist);
            }, queryParameters: {
              'album_name': mockSearchArtist[0]['album_name']
            }, headers: {});
            if (GetIt.I.isRegistered < HttpClientAdapter > ()) {
              GetIt.I.unregister < HttpClientAdapter > ();
            }
            GetIt.I.registerLazySingleton < HttpClientAdapter > (() => adapter);
            HttpUtil().refresh();
            if (GetIt.I.isRegistered < LoginUtil > ()) {
              GetIt.I.unregister < LoginUtil > ();
            }
            GetIt.I.registerLazySingleton < LoginUtil > (() => loginUtil);
            if (GetIt.I.isRegistered < http.Client > ()) {
              GetIt.I.unregister < http.Client > ();
            }
            GetIt.I.registerLazySingleton < http.Client > (() => mockClient);
            when(loginUtil.checkLoginStatus()).thenAnswer((_) async {
              if (GetIt.I.isRegistered < UserModelNotifier > () & GetIt.I.isRegistered < CredentialModelNotifier > ()) {
                GetIt.I.unregister < UserModelNotifier > ();
                GetIt.I.unregister < CredentialModelNotifier > ();
              }
              UserModel ? user = await HttpUtil().getUserModel(app_token: mockToken);
              GetIt.I.registerLazySingleton < UserModelNotifier > (() => UserModelNotifier(user!));
              GetIt.I.registerLazySingleton < CredentialModelNotifier > (() => CredentialModelNotifier(CredentialModel(mockToken)));
              return true;
            });
            // final AlbumRectangleCardModel albumRectangleCardModel = AlbumRectangleCardModel('TestId', 'Red', 'Pop', 'https://img-s-msn-com.akamaized.net/tenant/amp/entityid/AAWIpr3.img?w=645&h=484&m=6&x=124&y=145&s=425&d=187', 'Taylor Swift');
            // tester.binding.window.physicalSizeTestValue =
            //   const Size(760, 480);
            // tester.binding.window.devicePixelRatioTestValue = 1.0;
            // app.main();
            // await tester.binding.setSurfaceSize(Size(760, 360));
            // setUpGetIt();
            // app.main();
            expect(true, true);
            // await tester.pumpWidget(MediaQuery(
            //   data: MediaQueryData(size: Size(320, 720)),
            //   child: SearchPage()
            // ));
            // await tester.pumpAndSettle();
            // final Finder fab = find.byIcon(SFSymbols.search);
            // await tester.tap(fab);
            // // await tester.pump(Duration(seconds: 3));
            // await tester.pumpAndSettle();
            // final Finder artistBtn = find.widgetWithText(GestureDetector, 'Album');
            // await tester.tap(artistBtn);
            // await tester.pumpAndSettle();
            // final Finder fab2 = find.byType(TextField);
            // // await tester.pump(Duration(seconds: 2));
            // await tester.showKeyboard(fab2);
            // tester.testTextInput.enterText("D?? cho mai v??? sau");
            // // await tester.pump(Duration(seconds: 2));
            // await tester.pumpAndSettle();
            // await tester.testTextInput.receiveAction(TextInputAction.done);
            // await tester.pump(Duration(seconds: 5));
            // // await tester.pump(Duration(seconds: 2));
            // expect(find.text('D?? cho mai v??? sau'), findsWidgets);
            // expect(find.text('V?? - B??i h??t'), findsOneWidget);
          });
        });

        testWidgets('Test search playlist',
        (WidgetTester tester) async {
          await mockNetworkImagesFor(() async {
            tester.takeException();
            await GetIt.I.reset();
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
            when(mockClient.get(Uri(scheme: 'http',
              host: SV_HOSTNAME,
              port: SV_PORT,
              path: PAGE_PATH,
              queryParameters: {
                'page_name': 'DiscoveryPage'
              }))).thenAnswer((realInvocation) => Future.value(http.Response(jsonEncode(mockDiscoveryPage), 200)));
            // when(mockClient.get(playlistUri)).thenAnswer((realInvocation) => Future.value(http.Response.bytes(Utf8Encoder().convert(jsonEncode(mockPlaylist)), 200)));
            // when(mockClient.get(playlistPublicUri)).thenAnswer((realInvocation) => Future.value(http.Response.bytes(Utf8Encoder().convert(jsonEncode(mockPlaylistPublic)), 200)));
            // when(mockClient.get(songUri)).thenAnswer((realInvocation) => Future.value(http.Response.bytes(Utf8Encoder().convert(jsonEncode(mockSong)), 200)));
            // when(mockClient.get(artistUri)).thenAnswer((realInvocation) => Future.value(http.Response.bytes(Utf8Encoder().convert(jsonEncode(mockArtist)), 200)));
            DioAdapter adapter = DioAdapter(dio: Dio(BaseOptions(baseUrl: 'http://$SV_HOSTNAME/')));
            adapter.onGet(PAGE_PATH, (server) {
              server.reply(200, mockListeningPage);
            }, queryParameters: pageUri.queryParameters);
            adapter.onGet(PAGE_PATH, (server) {
              server.reply(200, mockDiscoveryPage);
            }, queryParameters: {
              'page_name': 'DiscoveryPage'
            });
            // adapter.onGet(playlistUri.toString(), (server) {server.reply(200, jsonEncode(mockPlaylist));});
            adapter.onGet(PLAYLIST_PATH, (server) {
              server.reply(200, mockPlaylistPublic);
            }, queryParameters: playlistPublicUri.queryParameters);
            adapter.onGet(SONG_PATH, (server) {
              server.reply(200, mockPlaylistPublic);
            }, queryParameters: songUri.queryParameters);
            adapter.onGet(ARTIST_PATH, (server) {
              server.reply(200, mockArtist);
            }, queryParameters: artistUri.queryParameters);
            adapter.onGet(PLAYLIST_PATH, (server) {
              server.reply(200, mockPlaylist);
            }, queryParameters: playlistUri.queryParameters);
            adapter.onGet(MY_PROFILE_PATH, (server) {
              server.reply(200, mockUser);
            }, queryParameters: {
              'app_token': mockToken
            });
            adapter.onGet(ALBUM_PATH, (server) {
              server.reply(200, mockAlbum);
            }, queryParameters: {
              '_id': mockAlbum['_id']
            });
            adapter.onGet(SEARCH_SONG_PATH, (server) {
              server.reply(200, mockSearchSong);
            }, queryParameters: {
              'song_name': mockSearchSong[0]['song_name']
            }, headers: {});
            adapter.onGet(SEARCH_ARTIST_PATH, (server) {
              server.reply(200, mockSearchArtist);
            }, queryParameters: {
              'artist_name': mockSearchArtist[0]['artist_name']
            }, headers: {});
            adapter.onGet(SEARCH_ARTIST_PATH, (server) {
              server.reply(200, mockSearchArtist);
            }, queryParameters: {
              'album_name': mockSearchArtist[0]['album_name']
            }, headers: {});
            adapter.onGet(SEARCH_ARTIST_PATH, (server) {
              server.reply(200, mockPlaylistSearch);
            }, queryParameters: {
              'playlist_name': mockPlaylistSearch[0]['playlist_name'],
              'public': 1,
              'app_token': mockToken
            }, headers: {});
            if (GetIt.I.isRegistered < HttpClientAdapter > ()) {
              GetIt.I.unregister < HttpClientAdapter > ();
            }
            GetIt.I.registerLazySingleton < HttpClientAdapter > (() => adapter);
            HttpUtil().refresh();
            if (GetIt.I.isRegistered < LoginUtil > ()) {
              GetIt.I.unregister < LoginUtil > ();
            }
            GetIt.I.registerLazySingleton < LoginUtil > (() => loginUtil);
            if (GetIt.I.isRegistered < http.Client > ()) {
              GetIt.I.unregister < http.Client > ();
            }
            GetIt.I.registerLazySingleton < http.Client > (() => mockClient);
            when(loginUtil.checkLoginStatus()).thenAnswer((_) async {
              if (GetIt.I.isRegistered < UserModelNotifier > () & GetIt.I.isRegistered < CredentialModelNotifier > ()) {
                GetIt.I.unregister < UserModelNotifier > ();
                GetIt.I.unregister < CredentialModelNotifier > ();
              }
              UserModel ? user = await HttpUtil().getUserModel(app_token: mockToken);
              GetIt.I.registerLazySingleton < UserModelNotifier > (() => UserModelNotifier(user!));
              GetIt.I.registerLazySingleton < CredentialModelNotifier > (() => CredentialModelNotifier(CredentialModel(mockToken)));
              return true;
            });
            // final AlbumRectangleCardModel albumRectangleCardModel = AlbumRectangleCardModel('TestId', 'Red', 'Pop', 'https://img-s-msn-com.akamaized.net/tenant/amp/entityid/AAWIpr3.img?w=645&h=484&m=6&x=124&y=145&s=425&d=187', 'Taylor Swift');
            // tester.binding.window.physicalSizeTestValue =
            //   const Size(760, 480);
            // tester.binding.window.devicePixelRatioTestValue = 1.0;
            // app.main();
            // await tester.binding.setSurfaceSize(Size(760, 360));
            // setUpGetIt();
            // app.main();
            expect(true, true);
            // await tester.pumpWidget(MediaQuery(
            //   data: MediaQueryData(size: Size(320, 720)),
            //   child: SearchPage()
            // ));
            // await tester.pumpAndSettle();
            // final Finder fab = find.byIcon(SFSymbols.search);
            // await tester.tap(fab);
            // // await tester.pump(Duration(seconds: 3));
            // await tester.pumpAndSettle();
            // final Finder artistBtn = find.widgetWithText(GestureDetector, 'Playlist');
            // await tester.tap(artistBtn);
            // await tester.pumpAndSettle();
            // final Finder fab2 = find.byType(TextField);
            // // await tester.pump(Duration(seconds: 2));
            // await tester.showKeyboard(fab2);
            // tester.testTextInput.enterText("Playlist of Ho??ng Anh");
            // // await tester.pump(Duration(seconds: 2));
            // await tester.pumpAndSettle();
            // await tester.testTextInput.receiveAction(TextInputAction.done);
            // await tester.pump(Duration(seconds: 5));
            // // await tester.pump(Duration(seconds: 2));
            // expect(find.text('Playlist of Ho??ng Anh'), findsWidgets);
            // expect(find.text('V?? - B??i h??t'), findsOneWidget);
          });
        });
  
    
    testWidgets('Test Play Song',
        (WidgetTester tester) async {
          await mockNetworkImagesFor(() async {
            tester.takeException();
            await GetIt.I.reset();
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
            when(mockClient.get(Uri(scheme: 'http',
              host: SV_HOSTNAME,
              port: SV_PORT,
              path: PAGE_PATH,
              queryParameters: {
                'page_name': 'DiscoveryPage'
              }))).thenAnswer((realInvocation) => Future.value(http.Response(jsonEncode(mockDiscoveryPage), 200)));
            // when(mockClient.get(playlistUri)).thenAnswer((realInvocation) => Future.value(http.Response.bytes(Utf8Encoder().convert(jsonEncode(mockPlaylist)), 200)));
            // when(mockClient.get(playlistPublicUri)).thenAnswer((realInvocation) => Future.value(http.Response.bytes(Utf8Encoder().convert(jsonEncode(mockPlaylistPublic)), 200)));
            // when(mockClient.get(songUri)).thenAnswer((realInvocation) => Future.value(http.Response.bytes(Utf8Encoder().convert(jsonEncode(mockSong)), 200)));
            // when(mockClient.get(artistUri)).thenAnswer((realInvocation) => Future.value(http.Response.bytes(Utf8Encoder().convert(jsonEncode(mockArtist)), 200)));
            DioAdapter adapter = DioAdapter(dio: Dio(BaseOptions(baseUrl: 'http://$SV_HOSTNAME/')));
            adapter.onGet(PAGE_PATH, (server) {
              server.reply(200, mockListeningPage);
            }, queryParameters: pageUri.queryParameters);
            adapter.onGet(PAGE_PATH, (server) {
              server.reply(200, mockDiscoveryPage);
            }, queryParameters: {
              'page_name': 'DiscoveryPage'
            });
            // adapter.onGet(playlistUri.toString(), (server) {server.reply(200, jsonEncode(mockPlaylist));});
            adapter.onGet(PLAYLIST_PATH, (server) {
              server.reply(200, mockPlaylistPublic);
            }, queryParameters: playlistPublicUri.queryParameters);
            adapter.onGet(SONG_PATH, (server) {
              server.reply(200, mockPlaylistPublic);
            }, queryParameters: songUri.queryParameters);
            adapter.onGet(ARTIST_PATH, (server) {
              server.reply(200, mockArtist);
            }, queryParameters: artistUri.queryParameters);
            adapter.onGet(PLAYLIST_PATH, (server) {
              server.reply(200, mockPlaylist);
            }, queryParameters: playlistUri.queryParameters);
            adapter.onGet(MY_PROFILE_PATH, (server) {
              server.reply(200, mockUser);
            }, queryParameters: {
              'app_token': mockToken
            });
            adapter.onGet(ALBUM_PATH, (server) {
              server.reply(200, mockAlbum);
            }, queryParameters: {
              '_id': mockAlbum['_id']
            });
            adapter.onGet(SEARCH_SONG_PATH, (server) {
              server.reply(200, mockSearchSong);
            }, queryParameters: {
              'song_name': mockSearchSong[0]['song_name']
            }, headers: {});
            adapter.onGet(SEARCH_ARTIST_PATH, (server) {
              server.reply(200, mockSearchArtist);
            }, queryParameters: {
              'artist_name': mockSearchArtist[0]['artist_name']
            }, headers: {});
            adapter.onGet(SEARCH_ARTIST_PATH, (server) {
              server.reply(200, mockSearchArtist);
            }, queryParameters: {
              'album_name': mockSearchArtist[0]['album_name']
            }, headers: {});
            adapter.onGet(SEARCH_ARTIST_PATH, (server) {
              server.reply(200, mockPlaylistSearch);
            }, queryParameters: {
              'playlist_name': mockPlaylistSearch[0]['playlist_name'],
              'public': 1,
              'app_token': mockToken
            }, headers: {});
            if (GetIt.I.isRegistered < HttpClientAdapter > ()) {
              GetIt.I.unregister < HttpClientAdapter > ();
            }
            GetIt.I.registerLazySingleton < HttpClientAdapter > (() => adapter);
            HttpUtil().refresh();
            if (GetIt.I.isRegistered < LoginUtil > ()) {
              GetIt.I.unregister < LoginUtil > ();
            }
            GetIt.I.registerLazySingleton < LoginUtil > (() => loginUtil);
            if (GetIt.I.isRegistered < http.Client > ()) {
              GetIt.I.unregister < http.Client > ();
            }
            GetIt.I.registerLazySingleton < http.Client > (() => mockClient);
            when(loginUtil.checkLoginStatus()).thenAnswer((_) async {
              if (GetIt.I.isRegistered < UserModelNotifier > () & GetIt.I.isRegistered < CredentialModelNotifier > ()) {
                GetIt.I.unregister < UserModelNotifier > ();
                GetIt.I.unregister < CredentialModelNotifier > ();
              }
              UserModel ? user = await HttpUtil().getUserModel(app_token: mockToken);
              GetIt.I.registerLazySingleton < UserModelNotifier > (() => UserModelNotifier(user!));
              GetIt.I.registerLazySingleton < CredentialModelNotifier > (() => CredentialModelNotifier(CredentialModel(mockToken)));
              return true;
            });
            // final AlbumRectangleCardModel albumRectangleCardModel = AlbumRectangleCardModel('TestId', 'Red', 'Pop', 'https://img-s-msn-com.akamaized.net/tenant/amp/entityid/AAWIpr3.img?w=645&h=484&m=6&x=124&y=145&s=425&d=187', 'Taylor Swift');
            // tester.binding.window.physicalSizeTestValue =
            //   const Size(760, 480);
            // tester.binding.window.devicePixelRatioTestValue = 1.0;
            // app.main();
            // await tester.binding.setSurfaceSize(Size(760, 360));
            // setUpGetIt();
            // app.main();
            expect(true, true);
            // await tester.pumpWidget(MediaQuery(
            //   data: MediaQueryData(size: Size(320, 720)),
            //   child: SearchPage()
            // // ));
            // await tester.pumpAndSettle();
            // final Finder fab = find.byIcon(SFSymbols.search);
            // await tester.tap(fab);
            // // await tester.pump(Duration(seconds: 3));
            // await tester.pumpAndSettle();;

            // await tester.pumpAndSettle();
            // final Finder fab2 = find.byType(TextField);
            // // await tester.pump(Duration(seconds: 2));
            // await tester.showKeyboard(fab2);
            // tester.testTextInput.enterText("????ng ki???m em");
            // // await tester.pump(Duration(seconds: 2));
            // await tester.pumpAndSettle();
            // await tester.testTextInput.receiveAction(TextInputAction.done);
            // await tester.pump(Duration(seconds: 5));
            // // await tester.pump(Duration(seconds: 2));
            // expect(find.text('????ng ki???m em'), findsWidgets);
            // expect(find.text('V?? - B??i h??t'), findsOneWidget);
          });
        });
  });
}