

import 'dart:io';

import 'package:advance_notification/advance_notification.dart';
import 'package:apple_music/components/ContextMenu/ContextMenuManager.dart';
import 'package:apple_music/components/ContextMenu/SubscreenContextMenu.dart';
import 'package:apple_music/constant.dart';
import 'package:apple_music/models/CredentialModel.dart';
import 'package:apple_music/models_refactor/PlaylistModel.dart';
import 'package:apple_music/services/http_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:apple_music/components/TextButton/TextButton.dart'
as CustomTextButton;

class PlaylistSubscreenContextMenu extends SubscreenContextMenu {
  PlaylistSubscreenContextMenu({required this.playlistSelected}): super(
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
            height: 300,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: EditPlaylistPage(futurePlaylistModel: Future.value(playlistSelected))
            ),
          ),
      );
    },
    name: 'SongSubscreenContextMenu',
    onDispose: () 
      {
        // if (GetIt.I.isRegistered<SongSubscreenContextMenuManger>()) {
        //   GetIt.I.unregister<SongSubscreenContextMenuManger>();
        // }
      }
    );
    PlaylistModel playlistSelected;
}

class EditPlaylistPage extends StatefulWidget {
  EditPlaylistPage({
    Key ? key,
    this.futurePlaylistModel
  }): super(key: key);
  Future<PlaylistModel>? futurePlaylistModel;
  @override
  State < EditPlaylistPage > createState() => _EditPlaylistPageState();
}

class _EditPlaylistPageState extends State < EditPlaylistPage > {
  final ImagePicker _picker = ImagePicker();

  XFile ? image;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool firstTime = true;
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
        ),
        child: FutureBuilder<PlaylistModel>(
          future: widget.futurePlaylistModel,
          builder:(context, snapshot) {
            if (snapshot.hasData && snapshot.data != null && snapshot.connectionState != ConnectionState.waiting) {
            if (firstTime) {
              firstTime = false;
              titleController.text = snapshot.data!.playlist_name;
              descriptionController.text = snapshot.data!.playlist_description;
            }
            return Column(
            children: [
              const SizedBox(height: kDefaultPadding, ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                child: Row(children: [
                  if (Navigator.of(context).canPop())
                    CustomTextButton.TextButton(
                      text: 'Back',
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
                      // iconRight: SFSymbols.plus_circle_fill, 
                      color: Colors.blue,
                      textSize: 20,
                      onTap: () async {
                        final FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        if (titleController.text == '') {
                          const AdvanceSnackBar(
                            message: 'Bạn chưa điền tiêu đề',
                            mode: Mode.ADVANCE,
                            type: sType.ERROR,
                            duration: const Duration(seconds: 3), ).show(GetIt.I.get < ContextMenuManager > ().context);
                          return;
                        }
                        if (descriptionController.text == '') {
                          const AdvanceSnackBar(
                            message: 'Bạn chưa đền mô tả',
                            mode: Mode.ADVANCE,
                            type: sType.ERROR,
                            duration: Duration(seconds: 3), ).show(GetIt.I.get < ContextMenuManager > ().context);
                          return;
                        }
                        if (image == null) {
                          const AdvanceSnackBar(
                            message: 'Bạn chưa thêm ảnh',
                            mode: Mode.ADVANCE,
                            type: sType.ERROR,
                            duration: const Duration(seconds: 3), ).show(GetIt.I.get < ContextMenuManager > ().context);
                          return;
                        }
                        EasyLoading.show(status: 'Đang sửa playlist');
                        final bool suc = await HttpUtil().updatePlaylist(id: snapshot.data!.id ,playlist_name: titleController.text, playlist_description: descriptionController.text, imagePath: image != null ? image!.path : null,app_token: GetIt.I.get<CredentialModelNotifier>().value.appToken);
                        if (suc) {
                          EasyLoading.showSuccess('Thành công', duration: const Duration(seconds: 2));
                       
                        } else {
                          EasyLoading.showError('Có lỗi xảy ra', duration: const Duration(seconds: 2));
                        }
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        }
                      }
                    ),
                ], ),
              ),
              // ElevatedButton(onPressed: () async {
              //   image = await _picker.pickImage(source: ImageSource.gallery);
              //   setState(() {});
              // }, child: Text("PickImage")),
              // if (image != null)
              // Image.file(File(image!.path))
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(children: [
                        Flexible(
                          flex: 3,
                          child: GestureDetector(
                            onTap: () async {
                              image = await _picker.pickImage(source: ImageSource.gallery);
                              setState(() {});
                            },
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10),
                                image: image != null ? DecorationImage(image: Image.file(File(image!.path)).image, fit: BoxFit.cover) : DecorationImage(image: Image.network(snapshot.data!.art_url).image,  fit: BoxFit.cover)
                              ),
        
                              child: image == null ? SvgPicture.asset('assets/icons/Gallery.svg', color: Colors.white, ) : null,
                            ),
                          )
                        ),
                        Flexible(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Tiêu đề: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: const Color.fromARGB(255, 61, 61, 61)), ),
                                TextField(
                                  controller: titleController,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.zero
                                  ),
                                ),
                                const SizedBox(height: 10, ),
                                const Text('Mô tả: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: const Color.fromARGB(255, 61, 61, 61)), ),
                                TextField(
                                  controller: descriptionController,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.zero
                                  ),
                                )
                              ]),
                          )
                        )
                      ], ),
                    ),
                  ],
                )
        
              )
            ]);}
            else 
            return Center(child: CircularProgressIndicator(color: Colors.red));
          } 
          
        ),
      ),
    );
  }
}