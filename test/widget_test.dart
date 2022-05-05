// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

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
import 'package:integration_test/integration_test.dart';
import 'package:apple_music/main.dart' as app;
import 'package:network_image_mock/network_image_mock.dart';


void main() {
  setUpGetIt();
  final _audioManager = getIt<AudioManager>();

  group('widget test', (){
    group('cards widget test', (){
    testWidgets('Test AlbumRectangleCard widget', (WidgetTester tester) async {
      // Build our app and trigger a frame.
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

      testWidgets('tap on the floating action button, verify counter',
        (WidgetTester tester) async {
          tester.binding.window.physicalSizeTestValue = const Size(760, 480);
          app.main();
          await tester.pumpAndSettle();

          // Verify the counter starts at 0.
          expect(find.text('0'), findsOneWidget);

          // Finds the floating action button to tap on.
          final Finder fab = find.byTooltip('Increment');

          // Emulate a tap on the floating action button.
          await tester.tap(fab);

          // Trigger a frame.
          await tester.pumpAndSettle();

          // Verify the counter increments by 1.
          expect(find.text('1'), findsOneWidget);
        });
    });
}