// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:apple_music/components/RectangleCardSearchPage/AlbumRectangleCard.dart';
import 'package:apple_music/models/AlbumRectangleCardModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:apple_music/main.dart' as app;

void main() {
  // testWidgets('Test AlbumRectangleCard widget', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   final AlbumRectangleCardModel albumRectangleCardModel = AlbumRectangleCardModel('TestId', 'Red', 'Pop', 'https://img-s-msn-com.akamaized.net/tenant/amp/entityid/AAWIpr3.img?w=645&h=484&m=6&x=124&y=145&s=425&d=187', 'Taylor Swift');
  //   await tester.pumpWidget(
  //     MediaQuery(
  //       data: MediaQueryData(size: Size(370, 720)),
  //       child: MaterialApp(
  //         home: Scaffold(
  //           body: AlbumRectangleCard(albumRectangleCardModel: albumRectangleCardModel),
  //         ),
  //       ),
  //     ));

  //   expect(find.text('Red'), findsOneWidget);
  //   expect(find.text('Taylor Swift - Album'), findsOneWidget);
  // });
  // IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  // debugDumpApp();
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