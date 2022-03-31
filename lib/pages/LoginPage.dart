import 'dart:async';
import 'dart:convert';

import 'package:apple_music/constant.dart';
import 'package:apple_music/pages/WelcomePage.dart';
import 'package:flutter/material.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter/services.dart' show PlatformException;
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginPage extends StatelessWidget {
  final redirectUrl = REDIRECT_URI;
  Future<String> authGoogle() async {
    // var grant = oauth2.AuthorizationCodeGrant(identifier, authorizationEndpoint, tokenEndpoint);
    // var authorizationUrl = grant.getAuthorizationUrl(redirectUrl, scopes: ['https://www.googleapis.com/auth/userinfo.profile', 'https://www.googleapis.com/auth/userinfo.email']);
    await redirect(Uri(scheme: "http", host: SV_HOSTNAME, port: SV_PORT, path: "oauth"));
    var responseUrl = await listen(redirectUrl);
    Uri httpURI = Uri(scheme: 'http', host: SV_HOSTNAME, path: 'verify', port: SV_PORT, queryParameters: {"code": responseUrl.queryParameters['code'], "state": responseUrl.queryParameters['state']});
    var responseJson = await http.get(httpURI);
    print(responseJson.body);
    return responseJson.body;
  }

  Future<void> redirect(Uri url) async {
    launch(url.toString());
  }

  Future<Uri> listen(Uri redirectUrl) async {
    Completer<Uri> com = Completer();  
    linkStream.listen((String? link) {
      if (link.toString().startsWith(redirectUrl.toString())) {
        com.complete(Uri.parse(link!));
      }
    });
    return com.future;
  }
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
          height: screenSize.height/2,
          child: Column(
            children: [
              Image.asset("assets/images/AppleIcon.png", width: screenSize.width/2,),
              SizedBox(height: screenSize.height/10,),
              Container(
                width: screenSize.width * 0.6,
                height: screenSize.height * 0.05,
                child: GestureDetector(
                  child: SignInButton(
                    Buttons.Google,
                    text: "Sign in with Google",
                    onPressed: () async {
                      JsonDecoder decoder = const JsonDecoder();
                      Map<String, dynamic> response = decoder.convert(await authGoogle());
                      if (response['status'] == "Error") {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Xảy ra lỗi khi đăng nhập")));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Đăng nhập thành công")));
                        Navigator.of(context).pushNamed("/welcomePage", arguments:  WelcomePageArgument(response['appToken']));
                      }
                    },
                  ),
                ),
              )
            ]
          ),
        ),
      ),
    );
  }
  
}

