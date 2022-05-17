import 'package:apple_music/components/AudioController/AudioManager.dart';
import 'package:apple_music/components/ContextMenu/ContextMenu.dart';
import 'package:apple_music/components/ContextMenu/ContextMenuItem.dart';
import 'package:apple_music/components/ContextMenu/ContextMenuManager.dart';
import 'package:apple_music/components/ContextMenu/SongSubscreenContextMenu.dart';
import 'package:apple_music/constant.dart';
import 'package:apple_music/models/CredentialModel.dart';
import 'package:apple_music/models_refactor/SongModel.dart';
import 'package:apple_music/models_refactor/UserModel.dart';
import 'package:apple_music/services/http_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:get_it/get_it.dart';
import 'package:skeletons/skeletons.dart';

// ignore: must_be_immutable
class SongContextMenu extends ContextMenu{
  SongContextMenu({Key? key, required this.songModel}): 
    super(key: key,
      name: 'SongContextMenu',
      action: [
          ContextMenuItem(
            title: 'Phát tiếp theo', 
            iconData: SFSymbols.text_insert,
            onTapItem: () {
              GetIt.I.get<AudioManager>().insertNext(songModel.id);
              GetIt.I.get<ContextMenuManager>().contextMenuMap['SongContextMenu']!.anim.animateTo(-1, duration: const Duration(milliseconds: 300), curve: Curves.easeOutExpo);
              GetIt.I.get<ContextMenuManager>().contextMenuMap['SongContextMenu']!.anim.addStatusListener((status) {
                if (status.name == 'completed') {
                  GetIt.I.get<ContextMenuManager>().removeOverlay('SongContextMenu');
                }
              });
              // AdvanceSnackBar(message: 'Yay! you got it', bgColor: Colors.blueAccent).show(GetIt.I.get<AudioPageRouteManager>().getMainContext());
            },
          ),
          ContextMenuItem(
            title: 'Phát cuối cùng', 
            iconData: SFSymbols.text_append,
            onTapItem: () {
              GetIt.I.get<AudioManager>().insertTail(songModel.id);
              GetIt.I.get<ContextMenuManager>().contextMenuMap['SongContextMenu']!.anim.animateTo(-1, duration: const Duration(milliseconds: 300), curve: Curves.easeOutExpo);
              GetIt.I.get<ContextMenuManager>().contextMenuMap['SongContextMenu']!.anim.addStatusListener((status) {
                if (status.name == 'completed') {
                  GetIt.I.get<ContextMenuManager>().removeOverlay('SongContextMenu');
                }
              });
              // AdvanceSnackBar(message: 'Yay! you got it', bgColor: Colors.blueAccent).show(GetIt.I.get<AudioPageRouteManager>().getMainContext());
            },
          ),
          ValueListenableBuilder<UserModel>(valueListenable: GetIt.I.get<UserModelNotifier>(), builder: (context, userModel, _) {
            if (!GetIt.I.get<UserModelNotifier>().value.containFavSong(songModel.id)) {
              return ContextMenuItem(
            title: 'Thêm vào yêu thích', 
            iconData: SFSymbols.heart,
            onTapItem: () async {
              // throw UnimplementedError();
              await EasyLoading.show(status: 'Đang thêm vào yêu thích');
              final bool suc = await HttpUtil().updateFavorite(app_token: GetIt.I.get<CredentialModelNotifier>().value.appToken, action: FAVORITE_ACTION.push, favorite_songs: [songModel.id]);
              await GetIt.I.get<UserModelNotifier>().refreshUser();
              GetIt.I.get<ContextMenuManager>().contextMenuMap['SongContextMenu']!.closeContextMenu(() {
                if (suc) {
                  EasyLoading.showSuccess('Thành công', duration: const Duration(seconds: 2));
                } else {
                  EasyLoading.showError('Thất bại', duration: const Duration(seconds: 2));
                }
                
              });
              // AdvanceSnackBar(message: 'Đã thêm vào yêu thích', bgColor: Colors.blueAccent).show(GetIt.I.get<AudioPageRouteManager>().getMainContext());
            },
          );
            } else {
              return ContextMenuItem(
            title: 'Xóa khỏi yêu thích', 
            iconData: SFSymbols.heart_slash,
            onTapItem: () async {
              // throw UnimplementedError();
              await EasyLoading.show(status: 'Đang xóa khỏi yêu thích');
              final bool suc = await HttpUtil().updateFavorite(app_token: GetIt.I.get<CredentialModelNotifier>().value.appToken, action: FAVORITE_ACTION.pop, favorite_songs: [songModel.id]);
              await GetIt.I.get<UserModelNotifier>().refreshUser();
              GetIt.I.get<ContextMenuManager>().contextMenuMap['SongContextMenu']!.closeContextMenu(() {
                if (suc) {
                  EasyLoading.showSuccess('Thành công', duration: const Duration(seconds: 2));
                } else {
                  EasyLoading.showError('Thất bại', duration: const Duration(seconds: 2));
                }
                
              });
              // AdvanceSnackBar(message: 'Đã thêm vào yêu thích', bgColor: Colors.blueAccent).show(GetIt.I.get<AudioPageRouteManager>().getMainContext());
            },
          );
            }
          }),
          ContextMenuItem(
            title: 'Thêm vào playlist', 
            iconData: SFSymbols.text_badge_plus,
            onTapItem: () {
              // throw UnimplementedError();

              GetIt.I.get<ContextMenuManager>().contextMenuMap['SongContextMenu']!.anim.animateTo(-1, duration: const Duration(milliseconds: 300), curve: Curves.easeOutExpo);
              GetIt.I.get<ContextMenuManager>().contextMenuMap['SongContextMenu']!.anim.addStatusListener((status) {
                if (status.name == 'completed') {
                  GetIt.I.get<ContextMenuManager>().removeOverlay('SongContextMenu');
                  GetIt.I.get<ContextMenuManager>().insertSubscreen(
                    SongSubscreenContextMenu(songModel: songModel)
                  );
                }
              });
              // AdvanceSnackBar(message: 'Yay! you got it', bgColor: Colors.blueAccent).show(GetIt.I.get<AudioPageRouteManager>().getMainContext());
            },
          )
      ],
      header: Row(

        children: [
          CachedNetworkImage(
            imageUrl: songModel.album.art_url,
            placeholder: (_, __) => const SkeletonAvatar(),
            imageBuilder: (context, imageProvider) =>
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(image: imageProvider, fit: BoxFit.cover)
                ),
              ),
          ),
          const SizedBox(width: kDefaultPadding * 2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  songModel.song_name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  songModel.artist.artist_name,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.w400
                  ),
                ),
                Text(
                  songModel.album.genre,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400
                  ),
                )
              ],
            )
          )
        ]
      )
    );
  SongModel songModel;
  // @override
  // Widget build(BuildContext context) {
  //   return ContextMenu(
  //       name: name,
  //       action: [
          
  //       ], 
  //       // header: ,
  //     );
  // }
  
}

