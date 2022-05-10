import 'package:advance_notification/advance_notification.dart';
import 'package:apple_music/components/AudioController/AudioPageRouteManager.dart';
import 'package:apple_music/components/ContextMenu/ContextMenu.dart';
import 'package:apple_music/components/ContextMenu/ContextMenuItem.dart';
import 'package:apple_music/components/ContextMenu/ContextMenuManager.dart';
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

class PlaylistContextMenu extends ContextMenu{
  PlaylistContextMenu({Key? key, required this.playlistModel}): 
    super(key: key,
      name: "PlaylistContextMenu",
      action: [
          ContextMenuItem(
            title: "Phát tất cả", 
            iconData: Icons.cloud_download_outlined,
            onTapItem: () {
              throw UnimplementedError();
              GetIt.I.get<ContextMenuManager>().contextMenuMap["PlaylistContextMenu"]!.anim.animateTo(-1, duration: const Duration(milliseconds: 300), curve: Curves.easeOutExpo);
              GetIt.I.get<ContextMenuManager>().contextMenuMap["PlaylistContextMenu"]!.anim.addStatusListener((status) {
                if (status.name == 'completed') {
                  GetIt.I.get<ContextMenuManager>().removeOverlay("PlaylistContextMenu");
                }
              });
              AdvanceSnackBar(message: "Yay! you got it", bgColor: Colors.blueAccent).show(GetIt.I.get<AudioPageRouteManager>().getMainContext());
            },
          ),
          if (GetIt.I.get<UserModelNotifier>().value.containPlaylist(playlistModel.id))
          ContextMenuItem(
            title: "Xóa playlist", 
            iconData: SFSymbols.delete_left,
            onTapItem: () async{
              // throw UnimplementedError();
              await EasyLoading.show(
                        status: 'loading...',
                        maskType: EasyLoadingMaskType.clear,
                      );
              bool success = await HttpUtil().deletePlaylist(id: playlistModel.id, app_token: GetIt.I.get<CredentialModelNotifier>().value.appToken);
              if (success)
                await EasyLoading.showSuccess("Đã xóa", duration: Duration(seconds: 3));
              else 
                await EasyLoading.showError("Xóa thất bại", duration: Duration(seconds: 3));
              GetIt.I.get<ContextMenuManager>().contextMenuMap["PlaylistContextMenu"]!.closeContextMenu(() {
                AdvanceSnackBar(message: "Yay! you got it", bgColor: Colors.blueAccent).show(GetIt.I.get<AudioPageRouteManager>().getMainContext());
                GetIt.I.get<SearchPageManager>().refresh();
              });
              
              
            },
          )
      ],
      header: Container(
        child: Row(
          
          children: [
            CachedNetworkImage(
              imageUrl: playlistModel.art_url, 
              placeholder: (_, __) => SkeletonAvatar(),
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
            SizedBox(width: kDefaultPadding * 2),
            Expanded(
              child: Column(
                children: [
                  Text(
                    playlistModel.playlist_name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    "Playlist",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                  
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              )
            )
          ]
        )
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

