import 'dart:async';
import 'dart:convert';

import 'package:apple_music/constant.dart';
import 'package:apple_music/models/CredentialModel.dart';
import 'package:apple_music/pages/WelcomePage.dart';
import 'package:apple_music/services/service_locator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart'
as http;
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final redirectUrl = REDIRECT_URI;

  Future < String > authGoogle() async {
    // var grant = oauth2.AuthorizationCodeGrant(identifier, authorizationEndpoint, tokenEndpoint);
    // var authorizationUrl = grant.getAuthorizationUrl(redirectUrl, scopes: ['https://www.googleapis.com/auth/userinfo.profile', 'https://www.googleapis.com/auth/userinfo.email']);

    await redirect(Uri(scheme: 'http', host: SV_HOSTNAME, port: SV_PORT, path: 'oauth'));
    final responseUrl = await listen(redirectUrl);
    final Uri httpURI = Uri(scheme: 'http', host: SV_HOSTNAME, path: 'verify2', port: SV_PORT, queryParameters: {
      'code': responseUrl.queryParameters['code'],
      'state': responseUrl.queryParameters['state']
    });
    final responseJson = await http.get(httpURI);
    if (kDebugMode) {
      print(responseJson.body);
    }
    return responseJson.body;
  }

  Future < void > redirect(Uri url) async {
    await launch(url.toString());
  }

  Future < Uri > listen(Uri redirectUrl) async {
    final Completer < Uri > com = Completer();
    if (kDebugMode) {
      print('Listening');
    }
    linkStream.listen((String ? link) {
      if (kDebugMode) {
        print(link);
      }
      if (link.toString().startsWith(redirectUrl.toString())) {
        com.complete(Uri.parse(link!));
      }
    });
    return com.future;
  }

  @override
  Widget build(BuildContext context) {
    final LoginUtil util = GetIt.I.get<LoginUtil>();
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder<bool>(
        future: util.checkLoginStatus(),
        builder: (context_, snapshot) {
          if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
            if (!snapshot.data!) {
              return Center(
                child: Container(
                  height: screenSize.height / 2,
                  child: Column(
                    children: [
                      Image.asset('assets/images/AppleIcon.png', width: screenSize.width / 2, ),
                      const Text('Chào mừng đến với\nApple Music!', textAlign: TextAlign.center, style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Roboto',
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      )),
                      SizedBox(height: screenSize.height / 20, ),
                      Container(
                        width: screenSize.width * 0.6,
                        height: screenSize.height * 0.05,
                        child: GestureDetector(
                          child: SignInButton(
                            Buttons.Google,
                            text: 'Đăng nhập với Google',
                            onPressed: () async {
                              const JsonDecoder decoder = JsonDecoder();
                              final Map < String, dynamic > response = decoder.convert(await authGoogle());

                              if (response['status'] == 'Error') {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Xảy ra lỗi khi đăng nhập')));
                              } else {
                                GetIt.I.registerSingleton < CredentialModelNotifier > (CredentialModelNotifier(CredentialModel(response['appToken'])));
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đăng nhập thành công')));
                                await util.saveCredential(response['appToken']);
                                await Navigator.of(context).pushNamed('/welcomePage', arguments: WelcomePageArgument(response['appToken']));
                              }
                            },
                          ),
                        ),
                      )
                    ]
                  ),
                ),
              );
            } else {
              Future.microtask(() => Navigator.of(context).pushReplacementNamed('/homePage'));
              return const Center(child: CircularProgressIndicator(color: Colors.red,),);
              }
          } else {
            return const Center(child: CircularProgressIndicator(color: Colors.red,),);
          }
        }

      ),
    );
  }
}