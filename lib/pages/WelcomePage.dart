import 'package:apple_music/models_refactor/UserModel.dart';
import 'package:apple_music/services/http_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:skeletons/skeletons.dart';
class WelcomePageArgument {
  final String appToken;
  // ignore: sort_constructors_first
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
                  final Animation < double > anc = AnimationController(vsync: this);
                  return Welcome(avatarURL: user.avatarURL, email: user.email, name: user.name, listenable: anc);

                } else {
                  return const Text('Loading');
                }
              }
            )
          );
        }
      )
    );
  }
}


// ignore: must_be_immutable
class Welcome extends AnimatedWidget {
  Welcome({Key? key,
    required Listenable listenable,
    required this.avatarURL,
    required this.name,
    required this.email
  }): super(key: key, listenable: listenable);
  String avatarURL;
  String name;
  String email;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
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
                  const SkeletonAvatar(style: SkeletonAvatarStyle(shape: BoxShape.circle),),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            SizedBox(height: screenSize.height/20,),
            Container(
              width: screenSize.width/1.5,
              child: Text('Hi! $name, welcome to Apple Muzic.', style: const TextStyle(fontSize: 20), textAlign: TextAlign.center,),
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color.fromARGB(183, 222, 89, 44).withOpacity(0.5)
                    )
                  ,
                    child: const Text('Get Started', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),)
                )
              ,)
            )
          ],
        ),
      ), );
  }

}