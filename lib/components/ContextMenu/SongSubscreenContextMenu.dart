import 'dart:io';

import 'package:advance_notification/advance_notification.dart';
import 'package:apple_music/components/ContextMenu/ContextMenuManager.dart';
import 'package:apple_music/components/ContextMenu/PlaylistContextMenu.dart';
import 'package:apple_music/components/ContextMenu/SongContextMenuInPlaylistSubscreen.dart';
import 'package:apple_music/components/ContextMenu/SubscreenContextMenu.dart';
import 'package:apple_music/components/RectangleCardSearchPage/PlaylistRectangleCard.dart';
import 'package:apple_music/components/SongCardInPlaylist/SongCardInPlaylistBigger.dart';
import 'package:apple_music/components/TextButton/TextButton.dart'
// ignore: library_prefixes
as CustomTextButton;
import 'package:apple_music/constant.dart';
import 'package:apple_music/models/CredentialModel.dart';
import 'package:apple_music/models_refactor/PlaylistModel.dart';
import 'package:apple_music/models_refactor/SongModel.dart';
import 'package:apple_music/models_refactor/UserModel.dart';
import 'package:apple_music/services/http_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class SongSubscreenContextMenu extends SubscreenContextMenu {
  SongSubscreenContextMenu({Key? key,
    this.songModel
  }): super(key: key,
    init: () {

    },
    body: (context) {
      
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
              home: ViewAllPlaylistsPage(songSelected: songModel)
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
    
    
    SongModel? songModel;
}

// ignore: strict_raw_type
Route _createRoutePageCreatePlaylist() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const CreateNewPlaylistPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1, 0);
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

// ignore: strict_raw_type
Route _createRoutePageViewSongPlaylist(PlaylistModel playlistModel, SongModel? songToAdd) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => ViewAllSongsInPlaylist(playlistSelected: playlistModel, songSelected: songToAdd,),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1, 0);
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

class ViewAllPlaylistsPage extends StatefulWidget {
  ViewAllPlaylistsPage({
    SongModel? songSelected,
    Key ? key,
  }): super(key: key) {
    if (GetIt.I.isRegistered<ViewAllPlaylistManagerNotifier>()) {
      GetIt.I.unregister<ViewAllPlaylistManagerNotifier>();
    }
    GetIt.I.registerLazySingleton<ViewAllPlaylistManagerNotifier>(() => ViewAllPlaylistManagerNotifier(ViewAllPlaylistManager(songSelected : songSelected)));
  }
  @override
  State<ViewAllPlaylistsPage> createState() => _ViewAllPlaylistsPageState();
}

class _ViewAllPlaylistsPageState extends State<ViewAllPlaylistsPage> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // print(MediaQuery.of(context).size);
    return Material(
      type: MaterialType.transparency,
      child: ValueListenableBuilder<ViewAllPlaylistManager>(
        valueListenable: GetIt.I.get<ViewAllPlaylistManagerNotifier>(),
        builder: (context, viewAllPlaylistsManager, _) => 
        Column(
          children: [
            const SizedBox(height: kDefaultPadding, ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                  child: Row(children: [
                    CustomTextButton.TextButton(
                      text: 'Thoát',
                      iconLeft: SFSymbols.chevron_left,
                      color: Colors.blue,
                      textSize: 20,
                      onTap: () {
                        GetIt.I.get < ContextMenuManager > ().subscreenMap['SongSubscreenContextMenu'] !.closeSubscreen(() {});
                      },
                    ),
                    Expanded(child: Container()),
                    CustomTextButton.TextButton(
                      text: 'Tạo Playlist ',
                      iconRight: SFSymbols.plus_circle_fill,
                      color: Colors.blue,
                      textSize: 20,
                      onTap: () {
                        Navigator.of(context).push(_createRoutePageCreatePlaylist());
                      }
                    ),
                  ], ),
              ),
              Row(children: const [
                Expanded(child: Divider(thickness: 0.2, color: Colors.black, height: 10, indent: 0, endIndent: 0, ))
              ], ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  margin: const EdgeInsets.only(bottom: kDefaultPadding),
                    child: 
                    const Text(
                      'Chọn Playlist', 
                      style: TextStyle(
                        fontWeight: FontWeight.bold, 
                        fontSize: 16
                      ), 
                    ),
              ),
              FutureBuilder<List<PlaylistModel>?>(
                future: viewAllPlaylistsManager.futureAllPlaylists,
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.connectionState != ConnectionState.done) {
                    return const CircularProgressIndicator();
                  }
                  // ignore: always_put_control_body_on_new_line
                  if (snapshot.data == null) return Container();
                  final List < Widget > playlistsWidget = [];
                  for (final PlaylistModel playlistModel in snapshot.data!) {
                    playlistsWidget.add(
                      PlaylistRectangleCard(
                        onTapPlaylistCard: (playlistSelected) {
                          
                          Navigator.of(context).push(_createRoutePageViewSongPlaylist(playlistModel, viewAllPlaylistsManager.songSelected));
                        },
                        playlistModel: playlistModel,
                        renderMoreButton: true,
                        renderDivider: false,
                        onTapPlaylistMoreButton: (playlistRectangleCardModel) {
                          GetIt.I.get<ContextMenuManager>().insertOverlay(PlaylistContextMenu(playlistModel: playlistModel));
                        },
                      ),
                    );
                    // ignore: cascade_invocations
                    playlistsWidget.add(const SizedBox(height: kDefaultPadding, ));
                  }
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: 
                        SingleChildScrollView(
                          child: Column(children: playlistsWidget),
                        )
                );}
              )
          ],
        ),
      ),
    );
  }
}

class CreateNewPlaylistPage extends StatefulWidget {
  const CreateNewPlaylistPage({
    Key ? key
  }): super(key: key);

  @override
  State < CreateNewPlaylistPage > createState() => _CreateNewPlaylistPageState();
}

class _CreateNewPlaylistPageState extends State < CreateNewPlaylistPage > {
  final ImagePicker _picker = ImagePicker();

  XFile ? image;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
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
        child: Column(
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
                          duration: Duration(seconds: 3), ).show(GetIt.I.get < ContextMenuManager > ().context);
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
                          duration: Duration(seconds: 3), ).show(GetIt.I.get < ContextMenuManager > ().context);
                        return;
                      }
                      await EasyLoading.show(status: 'Đang tạo playlist');
                      final bool suc = await HttpUtil().addPlaylist(title: titleController.text, description: descriptionController.text, imagePath: image!.path,app_token: GetIt.I.get<CredentialModelNotifier>().value.appToken);
                      if (suc) {
                        await GetIt.I.get<UserModelNotifier>().refreshUser();
                        await EasyLoading.showSuccess('Thành công', duration: const Duration(seconds: 2));
                        
                        GetIt.I.get<ViewAllPlaylistManagerNotifier>().refreshPage();
                      } else {
                        await EasyLoading.showError('Có lỗi xảy ra', duration: const Duration(seconds: 2));
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
                              image: image != null ? DecorationImage(image: Image.file(File(image!.path)).image, fit: BoxFit.cover) : null
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Tiêu đề: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color.fromARGB(255, 61, 61, 61)), ),
                              TextField(
                                controller: titleController,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero
                                ),
                              ),
                              const SizedBox(height: 10, ),
                              const Text('Mô tả: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color.fromARGB(255, 61, 61, 61)), ),
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
          ]),
      ),
    );
  }
}

class ViewAllSongsInPlaylist extends StatefulWidget {
  ViewAllSongsInPlaylist({
    Key ? key,
    required PlaylistModel playlistSelected,
    SongModel? songSelected
  }): super(key: key) {
    if (GetIt.I.isRegistered<ViewAllSongPageManagerNotifer>()) {
      GetIt.I.unregister<ViewAllSongPageManagerNotifer>();
    }
    GetIt.I.registerLazySingleton<ViewAllSongPageManagerNotifer>(() => ViewAllSongPageManagerNotifer(ViewAllSongPageManager(playlistSelected: playlistSelected, songSelected: songSelected)));
  }
  @override
  State < ViewAllSongsInPlaylist > createState() => _ViewAllSongsInPlaylistState();
}

class _ViewAllSongsInPlaylistState extends State < ViewAllSongsInPlaylist > {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      child: ValueListenableBuilder<ViewAllSongPageManager>(
        valueListenable: GetIt.I.get<ViewAllSongPageManagerNotifer>(),
        builder: (context, viewAllSongPageManager, _) => 
        Column(
          children: [
            const SizedBox(height: kDefaultPadding, ),
            Container(
      
              decoration: BoxDecoration(
      
                borderRadius: BorderRadius.circular(10)
              ),
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
                    if (viewAllSongPageManager.songSelected != null)
                      CustomTextButton.TextButton(
                        text: 'Thêm vào playlist',
                        iconRight: SFSymbols.plus_circle_fill,
                        color: Colors.blue,
                        textSize: 20,
                        onTap: () async {
                          await EasyLoading.show(status: 'Đang tải');
                          final bool success = await HttpUtil().addSongToPlaylist(song_id : viewAllSongPageManager.songSelected!.id, playlist_id: viewAllSongPageManager.playlistSelected.id, app_token: GetIt.I.get<CredentialModelNotifier>().value.appToken);
                          if (success) {
                            await EasyLoading.showSuccess('Thành công', duration: const Duration(seconds: 3));

                          } else {
                            await EasyLoading.showError('Có lỗi xảy ra', duration: const Duration(seconds: 3));
                          }
                          GetIt.I.get<ViewAllSongPageManagerNotifer>().refreshPage();
                        }
                      ),
                ], ),
            ),
            Row(children: const [
              Expanded(child: Divider(thickness: 0.2, color: Colors.black, height: 10, indent: 0, endIndent: 0, ))
            ], ),
      
            Expanded(
              child: FutureBuilder <PlaylistModel?> (
                future: viewAllSongPageManager.futurePlaylistModel,
      
                builder: (context, snapshot) {
                  final List < Widget > songsWidget = [];
                  if (snapshot.hasData && snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                    final PlaylistModel playlistModel = snapshot.data!;
                    songsWidget.add(
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        margin: const EdgeInsets.only(bottom: kDefaultPadding),
                        child: const Text('Danh sách bài hát', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16), ),
                      )
                    );
                    for (final songModel in playlistModel.songs) {
                      songsWidget.add(
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                          child: SongCardInPlaylistBigger(
                            songModel: songModel,
                            // renderMoreButton: true,
                            // renderDivider: false,
                            onTapSongCardMoreButton: (songModel) {
                              GetIt.I.get < ContextMenuManager > ().insertOverlay(
                                SongContextMenuInPlaylistSubscreen(
                                  playlist: viewAllSongPageManager.playlistSelected,
                                  songModel: songModel, 
                                  afterDeleteSong: () {
                                    setState(() {
                                      GetIt.I.get<ViewAllSongPageManagerNotifer>().refreshPage();
                                    });
                                  }
                                )
                              );
                            },
                          ),
                        ),
                      );
                      // ignore: cascade_invocations
                      songsWidget.add(const SizedBox(height: kDefaultPadding, ));
                    }
                    return CustomScrollView(
                      slivers: [
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Column(children: songsWidget),
                        )
                      ],
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
      
      
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// bắt đầu từ màn hình chọn playlist
// thông tin cần có: songSelected? optional, có thể có hoặc ko, nếu có thì khi khởi tạo page
// xem toàn bộ bài hát của playlist có thể thêm vào playlist đó, nếu ko thì chỉ có thể xem danh sách bài hát.
// futureAllPlaylist để load toàn bộ playlist private của người dùng
class ViewAllPlaylistManager {
  ViewAllPlaylistManager({this.songSelected}) {
    futureAllPlaylists = HttpUtil().searchPlaylist(public: false, app_token: GetIt.I.get<CredentialModelNotifier>().value.appToken);
  }
  // Song được chọn từ page nào đó lúc khởi tạo song subscreen context menu, buộc phải có nếu muốn thêm vào playlist
  SongModel? songSelected;
  late Future<List<PlaylistModel>?> futureAllPlaylists;
}

class ViewAllPlaylistManagerNotifier extends ValueNotifier<ViewAllPlaylistManager> {
  ViewAllPlaylistManagerNotifier(ViewAllPlaylistManager value) : super(value);
  void refreshPage() {
    value.futureAllPlaylists = HttpUtil().searchPlaylist(public: false, app_token: GetIt.I.get<CredentialModelNotifier>().value.appToken);
    notifyListeners();
  }
}

// Subscreen xem toàn bộ bài hát trong 1 playlist, cần:
// songSelected (optional) là bài hát đang được lựa chọn để thêm vào danh sách 
// bài hát trong playlist đang xem.
// futurePlaylistModel để load playlist hiện tại (xem danh sách bài hát) 
class ViewAllSongPageManager {
  ViewAllSongPageManager({required this.playlistSelected, this.songSelected}) {
    futurePlaylistModel = Future.value(playlistSelected);
  }
  
  SongModel? songSelected;
  PlaylistModel playlistSelected;
  late Future<PlaylistModel?> futurePlaylistModel;
}

class ViewAllSongPageManagerNotifer extends ValueNotifier<ViewAllSongPageManager> {
  ViewAllSongPageManagerNotifer(ViewAllSongPageManager value) : super(value);
  // ignore: use_setters_to_change_properties
  void changeSongSelected(SongModel songSelected) {
    value.songSelected = songSelected;
  }
  void changePlaylistSelected(PlaylistModel playlistSelected) {
    value.playlistSelected = playlistSelected;
    refreshPage();
  }

  void refreshPage() {
    value.futurePlaylistModel = HttpUtil().getPlaylistModel(public: false, app_token: GetIt.I.get<CredentialModelNotifier>().value.appToken, id: value.playlistSelected.id);
    notifyListeners();
  }
}

class AlbumSubscreenContextMenu {

}