import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:apple_music/constant.dart';
import 'package:apple_music/main.dart';
import 'package:apple_music/models/CredentialModel.dart';
import 'package:apple_music/pages/WelcomePage.dart';
import 'package:apple_music/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart'
as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter/services.dart'
show PlatformException;
import 'package:flutter_signin_button/flutter_signin_button.dart';
class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final redirectUrl = REDIRECT_URI;

  Future < String > authGoogle() async {
    // var grant = oauth2.AuthorizationCodeGrant(identifier, authorizationEndpoint, tokenEndpoint);
    // var authorizationUrl = grant.getAuthorizationUrl(redirectUrl, scopes: ['https://www.googleapis.com/auth/userinfo.profile', 'https://www.googleapis.com/auth/userinfo.email']);

    await redirect(Uri(scheme: 'http', host: SV_HOSTNAME, port: SV_PORT, path: 'oauth'));
    var responseUrl = await listen(redirectUrl);
    Uri httpURI = Uri(scheme: 'http', host: SV_HOSTNAME, path: 'verify2', port: SV_PORT, queryParameters: {
      'code': responseUrl.queryParameters['code'],
      'state': responseUrl.queryParameters['state']
    });
    var responseJson = await http.get(httpURI);
    print(responseJson.body);
    // GetIt.I.registerSingleton<CredentialModel>(CredentialModel())
    return responseJson.body;
  }

  Future < void > redirect(Uri url) async {
    launch(url.toString());
  }

  Future < Uri > listen(Uri redirectUrl) async {
    final Completer < Uri > com = Completer();
    print('Listening');
    linkStream.listen((String ? link) {
      print(link);
      if (link.toString().startsWith(redirectUrl.toString())) {
        com.complete(Uri.parse(link!));
      }
    });
    return com.future;
  }

  @override
  Widget build(BuildContext context) {
    LoginUtil util = GetIt.I.get<LoginUtil>();
    Size screenSize = MediaQuery.of(context).size;
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
                      Text("Chào mừng đến với\nBach Music!", textAlign: TextAlign.center, style: TextStyle(
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
                              Map < String, dynamic > response = decoder.convert(await authGoogle());

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