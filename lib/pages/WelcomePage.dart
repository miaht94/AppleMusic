import 'dart:convert';

import 'package:apple_music/constant.dart';
import 'package:apple_music/manager/CurrentUserManager.dart';
import 'package:apple_music/models/UserModel.dart';
import 'package:apple_music/services/service_locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart'
as http;
import 'package:loader_overlay/loader_overlay.dart';
class WelcomePageArgument {
  final String appToken;
  WelcomePageArgument(this.appToken);
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({
    Key ? key
  }): super(key: key);

  @override
  State < WelcomePage > createState() => _WelcomePageState();
}

class _WelcomePageState extends State < WelcomePage > with TickerProviderStateMixin {

  CurrentUserManager currentUserManager = getIt<CurrentUserManager>();

  Future < UserModel > getUserInfo(String appToken) async {
    Uri httpURI = Uri(scheme: "http", host: SV_HOSTNAME, port: SV_PORT, path: MY_PROFILE_PATH, queryParameters: {
      'app_token': appToken
    });
    http.Response res = await http.get(httpURI);
    JsonDecoder decoder = JsonDecoder();
    UserModel user = UserModel.fromJson(decoder.convert(res.body));
    currentUserManager.setCurrentUser(user);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context) !.settings.arguments as WelcomePageArgument;
    return
    LoaderOverlay(
      child: LayoutBuilder(
        builder: (context, constraints) {
          context.loaderOverlay.show();
          return Scaffold(body:
            FutureBuilder(future: getUserInfo(args.appToken), builder: (context, snapshot) {
              if (snapshot.hasData) {
                context.loaderOverlay.hide();
                UserModel user = snapshot.data as UserModel;
                Animation < double > anc = AnimationController(vsync: this);
                return Welcome(avatarURL: user.avatarURL, email: user.email, name: user.name, listenable: anc);

              } else {
                return Container(child: Text("Loading"), );
              }
            })
          );
        }
      )
    );
  }
}


class Welcome extends AnimatedWidget {
  Welcome({
    required Listenable listenable,
    required this.avatarURL,
    required this.name,
    required this.email
  }): super(listenable: listenable);
  String avatarURL;
  String name;
  String email;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    // TODO: implement build
    return Center(child:
      Container(
        width: screenSize.width,
        height: screenSize.height / 2,

        child: Column(
          children: [
            Container(
              width: screenSize.width / 3,
              height: screenSize.width / 3,
              child: CircleAvatar(backgroundImage: Image.network(avatarURL).image, ),
            ),
            SizedBox(height: screenSize.height/20,),
            Container(
              child: Text("Hi! ${name}, welcome to Apple Muvik.", style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),
              width: screenSize.width/1.5,
            ),
            SizedBox(height: screenSize.height/20,),
            Container(
              width: screenSize.width/3,
              height: screenSize.height/16,
              child: Material(child: 
                InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () {
                    Navigator.of(context).pushNamed('/homePage');
                  },
                  child: Container( 
                    alignment: Alignment.center,
                    child: Text("Get Started", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color.fromARGB(183, 222, 89, 44).withOpacity(0.5)
                    )
                  ,)
                )
              ,)
            )
          ],
        ),
      ), );
  }

}