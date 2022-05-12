import 'dart:io';
import 'package:apple_music/components/AudioController/AudioPageRouteManager.dart';
import 'package:apple_music/components/ButtonWithIcon/WideButton.dart';
import 'package:apple_music/components/ContextMenu/ContextMenuItem.dart';
import 'package:apple_music/components/ContextMenu/ContextMenuManager.dart';
import 'package:apple_music/components/ContextMenu/SubscreenContextMenu.dart';
import 'package:apple_music/constant.dart';
import 'package:apple_music/models/CredentialModel.dart';
import 'package:apple_music/models_refactor/UserModel.dart';
import 'package:apple_music/services/http_util.dart';
import 'package:apple_music/services/service_locator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:get_it/get_it.dart';
import 'package:apple_music/components/TextButton/TextButton.dart'
as CustomTextButton;
import 'package:image_picker/image_picker.dart';

class UserSubscreenContextMenu extends SubscreenContextMenu {
  UserSubscreenContextMenu(): super(
    init: () {
      // if (GetIt.I.isRegistered<SongSubscreenContextMenuManger>()) {
      //     GetIt.I.unregister<SongSubscreenContextMenuManger>();
      //   }
      //   GetIt.I.registerLazySingleton<SongSubscreenContextMenuManger>(() => SongSubscreenContextMenuManger());
      //   GetIt.I.get<SongSubscreenContextMenuManger>().songSelected = songModel;
    },
    body: (context) {

      final Size size = MediaQuery.of(context).size;
      return Container(
        // width: size.width,
        // height: size.height/2,
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          // color: Colors.red,
          child: Container(
            height: 270,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Material(child: UserModelView(), type: MaterialType.transparency, )
            ),
          ),
      );
    },
    name: "UserSubscreenContextMenu",
    onDispose: () {
      // if (GetIt.I.isRegistered<SongSubscreenContextMenuManger>()) {
      //   GetIt.I.unregister<SongSubscreenContextMenuManger>();
      // }
    }
  );


}

class UserModelView extends StatefulWidget {
  UserModelView({
    Key ? key
  }): super(key: key);
  Future < bool > refreshUserModel = GetIt.I.get < UserModelNotifier > ().refreshUser();
  @override
  State < UserModelView > createState() => _UserModelViewState();
}

class _UserModelViewState extends State < UserModelView > {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size size = MediaQuery.of(context).size;
    print(size);
    return FutureBuilder < bool > (
      future: widget.refreshUserModel,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.connectionState != ConnectionState.waiting && snapshot.data!) {
          return
          ValueListenableBuilder < UserModel > (
            valueListenable: GetIt.I.get < UserModelNotifier > (),
            builder: (BuildContext context, UserModel userModel, Widget ? child) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Column(children: [
                  const SizedBox(height: kDefaultPadding, ),
                    Container(
                      child: Text("Thông tin cá nhân", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), )
                    ),
                    Row(children: [
                      Expanded(child: Divider(thickness: 1, color: Colors.grey[300], height: 10, indent: 0, endIndent: 0, ))
                    ], ),

                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[100]
                                  ),
                                  child: Row(
                                    children: [
                                      CachedNetworkImage(imageUrl: userModel.avatarURL, imageBuilder: (context, provider) {
                                        return Container(
                                          width: size.width / 5,
                                          height: size.width / 5,
                                          child: CircleAvatar(
                                            backgroundImage: provider,
                                          ),
                                          margin: EdgeInsets.only(right: 10),
                                        );
                                      }),

                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(userModel.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600), ),
                                          Text(userModel.email, style: TextStyle(color: Colors.grey))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            ], ),
                          SizedBox(height: kDefaultPadding * 2, ),
                          // Row(children: [
                          //   const Expanded(child: Divider(thickness: 0.5, color: Colors.black, height: 10, indent: 40.0, endIndent: 0, ))
                          // ], ),
                          Container(
                            // color: Colors.amber,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(
                              children: [
                                ContextMenuItem(
                                  title: "Sửa thông tin cá nhân",
                                  iconData: Icons.edit,
                                  onTapItem: () {
                                    Navigator.of(context).push(_createRoutePageEditProfile());
                                  },
                                ),
                                Row(children: [
                                  Expanded(child: Divider(thickness: 1, color: Colors.grey[300], height: 10, indent: 40.0, endIndent: 10, ))
                                ], ),
                                ContextMenuItem(
                                  title: "Đăng xuất",
                                  iconData: Icons.exit_to_app,
                                  onTapItem: () {
                                    GetIt.I.get < ContextMenuManager > ().subscreenMap['UserSubscreenContextMenu'] !.closeSubscreen(() async {
                                      EasyLoading.show(status: "Đang đăng xuất");
                                      bool suc = await LoginUtil().deleteCredential();
                                      if (suc) {
                                        EasyLoading.showSuccess("Đã đăng xuất", duration: Duration(seconds: 3));
                                        Navigator.of(GetIt.I.get < AudioPageRouteManager > ().getMainContext()).pushReplacementNamed('/loginPage');
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: kDefaultPadding, )
                        ],
                      ),
                    ),

                ], )
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator(color: Colors.red));
        }
      }
    );
  }

}

class UserModelEdit extends StatefulWidget {
   UserModelEdit({
    Key ? key
  }): super(key: key);

  @override
  State<UserModelEdit> createState() => _UserModelEditState();
}

class _UserModelEditState extends State<UserModelEdit> {
  final ImagePicker _picker = ImagePicker();

  XFile ? image;

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // TODO: implement build
    return ValueListenableBuilder < UserModel > (
      valueListenable: GetIt.I.get < UserModelNotifier > (),
      builder: (BuildContext context, UserModel userModel, Widget ? child) {
        nameController.text == '' ? nameController.text = userModel.name : "";
        return Material(
          type: MaterialType.transparency,
          child: Container(
            
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
            ),
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(children: [
        
              SizedBox(height: kDefaultPadding,),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                    child: Row(children: [
                      if (Navigator.of(context).canPop())
                      CustomTextButton.TextButton(
                        text: 'Quay lại',
                        iconLeft: SFSymbols.chevron_left,
                        color: Colors.blue,
                        textSize: 20,
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      Expanded(child: Container()),
                      CustomTextButton.TextButton(
                        text: 'Xác nhận ',
                        iconRight: SFSymbols.plus_circle_fill,
                        color: Colors.blue,
                        textSize: 20,
                        onTap: () async {
                          EasyLoading.show(status: "Đang cập nhật");
                          bool suc = await HttpUtil().updateProfile(app_token: GetIt.I.get<CredentialModelNotifier>().value.appToken, name: nameController.text, avtPath: image != null ? image!.path : null);
                          if (suc) {
                            await GetIt.I.get<UserModelNotifier>().refreshUser();
                            EasyLoading.showSuccess("Thành công", duration: const Duration(seconds: 3));
                            Navigator.of(context).canPop() ? Navigator.of(context).pop() : "";
                          } else {
                            EasyLoading.showError("Có lỗi xảy ra", duration: const Duration(seconds: 3));
                          }
                          
                        }
                      ),
                    ], ),
                ),
                Row(children: [
                  const Expanded(child: Divider(thickness: 0.2, color: Colors.black, height: 10, indent: 0, endIndent: 0, ))
                ], ),
              CachedNetworkImage(imageUrl: userModel.avatarURL, imageBuilder: (context, provider) {
                return Container(
                  width: size.width / 3,
                  height: size.width / 3,
                  child: GestureDetector(
                    onTap: () async {
                      image = await _picker.pickImage(source: ImageSource.gallery);
                      setState(() {});
                    },
                    child: CircleAvatar(
                      backgroundImage: image == null ? provider : Image.file(File(image!.path)).image,
                    ),
                  ),
                  margin: EdgeInsets.only(right: 10),
                );
              }),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Họ và tên"
                ),
              )
            ], )
          ),
        );
      },
    );

  }
}


Route _createRoutePageEditProfile() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => UserModelEdit(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}