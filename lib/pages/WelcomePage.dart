import 'dart:convert';

import 'package:apple_music/constant.dart';
import 'package:apple_music/models/CredentialModel.dart';
import 'package:apple_music/models_refactor/UserModel.dart';
import 'package:apple_music/services/http_util.dart';
import 'package:apple_music/services/service_locator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart'
as http;
import 'package:loader_overlay/loader_overlay.dart';
import 'package:skeletons/skeletons.dart';
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

  Future <UserModel?> getUserInfo(String appToken) async {
    final UserModel? user = await HttpUtil().getUserModel(app_token: appToken);
    if (user != null) {
      GetIt.I.registerLazySingleton<UserModelNotifier>(() => UserModelNotifier(user));
    }
    return user;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
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
            FutureBuilder<UserModel?>(
              future: getUserInfo(args.appToken), 
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.connectionState != ConnectionState.waiting && snapshot.data != null) {
                  context.loaderOverlay.hide();
                  final UserModel user = snapshot.data!;
                  Animation < double > anc = AnimationController(vsync: this);
                  return Welcome(avatarURL: user.avatarURL, email: user.email, name: user.name, listenable: anc);

                } else {
                  return Container(child: Text("Loading"), );
                }
              }
            )
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
              child: CachedNetworkImage(
                imageUrl: avatarURL,
                imageBuilder: (context, imageProvider) => CircleAvatar(backgroundImage: imageProvider, ),
                placeholder: (context, url) => 
                  SkeletonAvatar(style: SkeletonAvatarStyle(shape: BoxShape.circle),),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
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
                    Navigator.of(context).popAndPushNamed('/homePage');
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