import 'dart:async';
import 'package:apple_music/models_refactor/PlaylistModel.dart';
import 'package:apple_music/pages/PlaylistPage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'services/http_util.dart';

void main() {
  // setUpGetIt();
  // GetIt.I.registerLazySingleton<CredentialModelNotifier>(() => CredentialModelNotifier(CredentialModel("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRyYW54dWFuYmFjaDNAZ21haWwuY29tIiwiaWRUb2tlbiI6ImV5SmhiR2NpT2lKU1V6STFOaUlzSW10cFpDSTZJbVl4TXpNNFkyRXlOamd6TlRnMk0yWTJOekUwTURobU5ERTNNemhoTjJJME9XVTNOREJtWXpBaUxDSjBlWEFpT2lKS1YxUWlmUS5leUpwYzNNaU9pSm9kSFJ3Y3pvdkwyRmpZMjkxYm5SekxtZHZiMmRzWlM1amIyMGlMQ0poZW5BaU9pSXhNekkxTnpJME5qUXpOemN0WlRsaGRta3lNakp4WTI5dU5HWnZORGxyZFdabGRUZHlhRzF6Ym1wME1Ha3VZWEJ3Y3k1bmIyOW5iR1YxYzJWeVkyOXVkR1Z1ZEM1amIyMGlMQ0poZFdRaU9pSXhNekkxTnpJME5qUXpOemN0WlRsaGRta3lNakp4WTI5dU5HWnZORGxyZFdabGRUZHlhRzF6Ym1wME1Ha3VZWEJ3Y3k1bmIyOW5iR1YxYzJWeVkyOXVkR1Z1ZEM1amIyMGlMQ0p6ZFdJaU9pSXhNRFkyTkRVeU9USXdNRGd3T1RNNU9UTTNOellpTENKbGJXRnBiQ0k2SW5SeVlXNTRkV0Z1WW1GamFETkFaMjFoYVd3dVkyOXRJaXdpWlcxaGFXeGZkbVZ5YVdacFpXUWlPblJ5ZFdVc0ltRjBYMmhoYzJnaU9pSnpOVW8xZDFveE5EbHZjVWhDTFV4VVlYSldUVUpSSWl3aWJtRnRaU0k2SW1obmEyaG5heUJvYTJobmF5SXNJbkJwWTNSMWNtVWlPaUpvZEhSd2N6b3ZMMnhvTXk1bmIyOW5iR1YxYzJWeVkyOXVkR1Z1ZEM1amIyMHZZUzlCUVZSWVFVcDVOMkY0WVRkNFFYWkxTRWw2U1c0d2JsWlVhSGR6TUdoRGVHdFBkbDk1ZEROZmNuSXhaejF6T1RZdFl5SXNJbWRwZG1WdVgyNWhiV1VpT2lKb1oydG9aMnNpTENKbVlXMXBiSGxmYm1GdFpTSTZJbWhyYUdkcklpd2liRzlqWVd4bElqb2lkbWtpTENKcFlYUWlPakUyTlRBd01UTXlNREVzSW1WNGNDSTZNVFkxTURBeE5qZ3dNWDAuSExMWWxMMFJaTHR6QmZMdVVDN0FkTjdsaFE1NXM4WjNPcGl5OS1FVXRQalQ2X0FKbk9sVHUxVHhsVDU1djZ2bFIzQTNRVmRSRkNOTGN2SDhONk5fRzdraEpscHpIZ191MUVfVEEwYzlMQzl2Nm5wLTJmQmdhNzJEZXVFLUZPVzhnODJnd3lObnhLX2xNN0FUOTBCNTlQbkxzekhTUXZ1QXRhNG1MOTBPaG04SC1KdFJ2TUNiaEktYkprUjY2Qzc0dnhXSHVTdWRoQ0k1ZEYza1dmaTlUOHpWOElLNHY2ZHBxcmowU0paSG1LbGFrU0E0VTRvOWNpM3c2WG1OVWM0bnphZEQ0bVZDMFVwSy16VGFkYzNLWVl4OE1OV2J0eFRpLWJ2N2QtTVN1bzluNTJ4VVIzNXlIZzBYVHR0aExSRkNVUnB0dk9YUE1HM0tkMC1QLW9NUkdnIiwiY3JlYXRlZERhdGUiOjE2NTAwMTMyMDE4MjMsImlhdCI6MTY1MDAxMzIwMSwiZXhwIjoxNjUzNjEzMjAxfQ.Lr5tvf4lY70-DUo6MAIIv25KUgkxRMRtuMKjQ6dTy68")));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key ? key
  }): super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
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
  @override
  void initState() {
    super.initState();
  }
  Future<void> test() async {
    final bool del = await HttpUtil().deletePlaylist(
      id: '627a89f4229cca30c43251cf',
      app_token: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhvYW5nYW5oeHQxODNAZ21haWwuY29tIiwiaWRUb2tlbiI6ImV5SmhiR2NpT2lKU1V6STFOaUlzSW10cFpDSTZJbVF6TXpKaFlqVTBOV05qTVRnNVpHWXhNek5sWm1Sa1lqTmhObU0wTURKbFltWTBPRGxoWXpJaUxDSjBlWEFpT2lKS1YxUWlmUS5leUpwYzNNaU9pSm9kSFJ3Y3pvdkwyRmpZMjkxYm5SekxtZHZiMmRzWlM1amIyMGlMQ0poZW5BaU9pSXhNekkxTnpJME5qUXpOemN0WlRsaGRta3lNakp4WTI5dU5HWnZORGxyZFdabGRUZHlhRzF6Ym1wME1Ha3VZWEJ3Y3k1bmIyOW5iR1YxYzJWeVkyOXVkR1Z1ZEM1amIyMGlMQ0poZFdRaU9pSXhNekkxTnpJME5qUXpOemN0WlRsaGRta3lNakp4WTI5dU5HWnZORGxyZFdabGRUZHlhRzF6Ym1wME1Ha3VZWEJ3Y3k1bmIyOW5iR1YxYzJWeVkyOXVkR1Z1ZEM1amIyMGlMQ0p6ZFdJaU9pSXhNVFF3T1RnM01ESXpNRFl6T0RNM05qWXpNVEVpTENKbGJXRnBiQ0k2SW1odllXNW5ZVzVvZUhReE9ETkFaMjFoYVd3dVkyOXRJaXdpWlcxaGFXeGZkbVZ5YVdacFpXUWlPblJ5ZFdVc0ltRjBYMmhoYzJnaU9pSk5UMUJGZW5SS2JsSjBlV3BxUWxWallXMVJjMVZCSWl3aWJtRnRaU0k2SXNTUTRicTNibWNnVkdqaHVyOGdTR19Eb0c1bklFRnVhQ0lzSW5CcFkzUjFjbVVpT2lKb2RIUndjem92TDJ4b015NW5iMjluYkdWMWMyVnlZMjl1ZEdWdWRDNWpiMjB2WVM5QlFWUllRVXA1VDA5a2VUbE1ZMlZzWkhSMWNEVk9VMGhCZUdsdE4zZE1SMjVYYlZWeU0wTkJYMGhFY1Qxek9UWXRZeUlzSW1kcGRtVnVYMjVoYldVaU9pTEVrT0c2dDI1bklGUm80YnFfSWl3aVptRnRhV3g1WDI1aGJXVWlPaUpJYjhPZ2JtY2dRVzVvSWl3aWJHOWpZV3hsSWpvaVpXNGlMQ0pwWVhRaU9qRTJOVEF5T1RJMU1URXNJbVY0Y0NJNk1UWTFNREk1TmpFeE1YMC5od3FDMmhEV0FGZnExTzVHbnkwQ2dNNWpkekpMdENDN1JCdGZXemlVMkVRM0NsVkZ4ZDc2b1I3Tmh1XzdxTC04RXlBenRZNUxHdV9XX21Ud1Y2TUh5V2dxNlF6aF9EZzhwZGlBa2paaWx5SVhYT2I4Mm9NcHh4cEhrcF91NVZzYlo2Z25wWHVrcFNNNmFsWl9CN0JBQ3NJTGQ3ZUhQWWVKS0ZGTVVKb2dVUkVRMHNEY2lQV214NkNlWW5tNEVhdEY4Z1U3SUdsRXJIeTJxakNvcEw4SFB0a3hXQklfUTF1MkNpT2FMNXVsalZZcHhDRTVMaUJVcERFMmVuMjdVYmtFTjE0b3RyYTB6ZjlLSFJaX0F3VlFfQlBWMk1SbzlGYnAwbUlkbXRCeF82VUFwSEI3QmRvdXg3XzdLQWYzMzNUZ2JvYjAxVGxpQlpMQ243bU55MVRGdWciLCJjcmVhdGVkRGF0ZSI6MTY1MDI5MjUxMTMzNywiaWF0IjoxNjUwMjkyNTExLCJleHAiOjE2NTM4OTI1MTF9.dXLoBywaQuyU3p4lItdnzOusMjDuJHL1tXMYsBBRghM'
    );
    if (kDebugMode) {
      print(del);
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<PlaylistModel?> getModel() async {
      return PlaylistModel.getSampleData();
    }
    return PlaylistView(playlistModel: getModel());
  }
}

