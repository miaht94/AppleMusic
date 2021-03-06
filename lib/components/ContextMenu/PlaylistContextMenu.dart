import 'package:apple_music/components/ContextMenu/ContextMenu.dart';
import 'package:apple_music/components/ContextMenu/ContextMenuItem.dart';
import 'package:apple_music/components/ContextMenu/ContextMenuManager.dart';
import 'package:apple_music/components/ContextMenu/PlaylistSubscreenContextMenu.dart';
import 'package:apple_music/constant.dart';
import 'package:apple_music/models/CredentialModel.dart';
import 'package:apple_music/models/SearchPageModel.dart';
import 'package:apple_music/models_refactor/PlaylistModel.dart';
import 'package:apple_music/models_refactor/UserModel.dart';
import 'package:apple_music/services/http_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:get_it/get_it.dart';
import 'package:skeletons/skeletons.dart';

// ignore: must_be_immutable
class PlaylistContextMenu extends ContextMenu{
  PlaylistContextMenu({Key? key, required this.playlistModel}): 
    super(key: key,
      name: 'PlaylistContextMenu',
      action: [
          ContextMenuItem(
            title: 'Phát tất cả',
            iconData: SFSymbols.text_insert,
            onTapItem: () {
              GetIt.I.get<ContextMenuManager>().contextMenuMap['PlaylistContextMenu']!.anim.animateTo(-1, duration: const Duration(milliseconds: 300), curve: Curves.easeOutExpo);
              GetIt.I.get<ContextMenuManager>().contextMenuMap['PlaylistContextMenu']!.anim.addStatusListener((status) {
                if (status.name == 'completed') {
                  GetIt.I.get<ContextMenuManager>().removeOverlay('PlaylistContextMenu');
                }
              });
              // AdvanceSnackBar(message: "Yay! you got it", bgColor: Colors.blueAccent).show(GetIt.I.get<AudioPageRouteManager>().getMainContext());
            },
          ),
          if (GetIt.I.get<UserModelNotifier>().value.containPlaylist(playlistModel.id))
            ContextMenuItem(
              title: 'Xóa playlist',
              iconData: SFSymbols.delete_left,
              onTapItem: () async{
                // throw UnimplementedError();
                await EasyLoading.show(
                          status: 'Đang xóa',
                          maskType: EasyLoadingMaskType.clear,
                        );
                final bool success = await HttpUtil().deletePlaylist(id: playlistModel.id, app_token: GetIt.I.get<CredentialModelNotifier>().value.appToken);
                if (success) {
                  await EasyLoading.showSuccess('Đã xóa', duration: const Duration(seconds: 3));
                  await GetIt.I.get<UserModelNotifier>().refreshUser();
                }
                  
                else {
                  await EasyLoading.showError('Xóa thất bại', duration: const Duration(seconds: 3));
                }
                GetIt.I.get<ContextMenuManager>().contextMenuMap['PlaylistContextMenu']!.closeContextMenu(() {
                  // AdvanceSnackBar(message: "Yay! you got it", bgColor: Colors.blueAccent).show(GetIt.I.get<AudioPageRouteManager>().getMainContext());
                  GetIt.I.get<SearchPageManager>().refresh();
                });
                
                
              },
            ),
            if (GetIt.I.get<UserModelNotifier>().value.containPlaylist(playlistModel.id))
            ContextMenuItem(
              title: 'Sửa playlist',
              iconData: Icons.edit,
              onTapItem: () async{
                
                GetIt.I.get<ContextMenuManager>().contextMenuMap['PlaylistContextMenu']!.closeContextMenu(() {
                  // AdvanceSnackBar(message: "Yay! you got it", bgColor: Colors.blueAccent).show(GetIt.I.get<AudioPageRouteManager>().getMainContext());
                  GetIt.I.get<ContextMenuManager>().insertSubscreen(PlaylistSubscreenContextMenu(playlistSelected: playlistModel));
                });
                
                
              },
            )],
      header: Row(

        children: [
          CachedNetworkImage(
            imageUrl: playlistModel.art_url,
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
                  playlistModel.playlist_name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const Text(
                  'Playlist',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.w400
                  ),
                ),

              ],
            )
          )
        ]
      )
    );
  PlaylistModel playlistModel;
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

