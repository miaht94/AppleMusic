import 'package:advance_notification/advance_notification.dart';
import 'package:apple_music/components/AudioController/AudioManager.dart';
import 'package:apple_music/components/AudioController/AudioPageRouteManager.dart';
import 'package:apple_music/components/ContextMenu/ContextMenu.dart';
import 'package:apple_music/components/ContextMenu/ContextMenuItem.dart';
import 'package:apple_music/components/ContextMenu/ContextMenuManager.dart';
import 'package:apple_music/constant.dart';
import 'package:apple_music/models/AlbumSongListViewModel.dart';
import 'package:apple_music/models/AlbumViewModel.dart';
import 'package:apple_music/models/CredentialModel.dart';
import 'package:apple_music/models/SongCardInPlaylistModel.dart';
import 'package:apple_music/models_refactor/AlbumModel.dart';
import 'package:apple_music/models_refactor/UserModel.dart';
import 'package:apple_music/pages/AlbumPage.dart';
import 'package:apple_music/services/http_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:get_it/get_it.dart';
import 'package:skeletons/skeletons.dart';

import '../../models_refactor/SongModel.dart';

class AlbumContextMenu extends ContextMenu{
  AlbumContextMenu({Key? key, required this.albumViewModel}):
    super(key: key,
      name: "AlbumContextMenu",
      action: [
          ContextMenuItem(
            title: "Phát tiếp theo", 
            iconData: SFSymbols.text_insert,
            onTapItem: () {
              EasyLoading.show(status: "Đang thêm album");
              GetIt.I.get<AudioManager>().addAList(albumViewModel.songs.map((e) => e.id).toList());
              GetIt.I.get<ContextMenuManager>().contextMenuMap["AlbumContextMenu"]!.closeContextMenu(() {
                EasyLoading.showSuccess('Đã thêm', duration:Duration(seconds: 3));
                GetIt.I.get<ContextMenuManager>().removeOverlay("AlbumContextMenu");
              });
            },
          ),
          ValueListenableBuilder<UserModel>(valueListenable: GetIt.I.get<UserModelNotifier>(), builder: (context, userModel, _) {
            return !userModel.containFavAlbum(albumViewModel.id) ?
          ContextMenuItem(
            title: "Thêm vào yêu thích", 
            iconData: SFSymbols.heart,
            onTapItem: () async {
              EasyLoading.show(status: "Đang thêm album vào yêu thích");
              bool suc = await HttpUtil().updateFavorite(favorite_albums: [albumViewModel.id], action: FAVORITE_ACTION.push, app_token: GetIt.I.get<CredentialModelNotifier>().value.appToken);
              if (suc) {
                await GetIt.I.get<UserModelNotifier>().refreshUser();
                GetIt.I.get<ContextMenuManager>().contextMenuMap["AlbumContextMenu"]!.closeContextMenu(() {
                EasyLoading.showSuccess('Đã thêm', duration:Duration(seconds: 3));
                GetIt.I.get<ContextMenuManager>().removeOverlay("AlbumContextMenu");
                });
              } else {
                EasyLoading.showError("Thất bại", duration: Duration(seconds: 3));
              }
              
            },
          ) :
          ContextMenuItem(
            title: "Xóa khỏi yêu thích", 
            iconData: SFSymbols.heart_slash,
            onTapItem: () async {
              EasyLoading.show(status: "Đang xóa album khỏi yêu thích");
              bool suc = await HttpUtil().updateFavorite(favorite_albums: [albumViewModel.id], action: FAVORITE_ACTION.pop, app_token: GetIt.I.get<CredentialModelNotifier>().value.appToken);
              if (suc) {
                await GetIt.I.get<UserModelNotifier>().refreshUser();
                GetIt.I.get<ContextMenuManager>().contextMenuMap["AlbumContextMenu"]!.closeContextMenu(() {
                EasyLoading.showSuccess('Đã xóa', duration:Duration(seconds: 3));
                GetIt.I.get<ContextMenuManager>().removeOverlay("AlbumContextMenu");
                });
              } else {
                EasyLoading.showError("Thất bại", duration: Duration(seconds: 3));
              }
              
            },
          );
          })
          
      ],
      header: Container(
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: albumViewModel.art_url,
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
                    albumViewModel.album_name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    '${albumViewModel.artist.artist_name}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                  Text(
                    'Album',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[400],
                      fontWeight: FontWeight.w400
                    ),
                  )
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              )
            )
          ]
        )
      )
    );
  AlbumModel albumViewModel;
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

class AlbumSongContextMenu extends ContextMenu{
  AlbumSongContextMenu({Key? key, required this.albumSongListViewModel,required this.albumViewModel}):
        super(key: key,
          name: 'AlbumSongContextMenu',
          action: [
            
            ContextMenuItem(
              title: "Phát tiếp theo",
              iconData: SFSymbols.text_insert,
              onTapItem: () {
                GetIt.I.get<AudioManager>().insertNext(albumSongListViewModel.id);
                GetIt.I.get<ContextMenuManager>().removeOverlay('AlbumSongContextMenu');
                AdvanceSnackBar(message: 'Yay! you got it', bgColor: Colors.blueAccent).show(GetIt.I.get<AudioPageRouteManager>().getMainContext());
              },
            ),
            ContextMenuItem(
              title: "Phát cuối cùng",
              iconData: SFSymbols.text_append,
              onTapItem: () {
                GetIt.I.get<AudioManager>().insertTail(albumSongListViewModel.id);
              },
            ),
            ContextMenuItem(
              title: "Thêm vào playlist",
              iconData: SFSymbols.text_badge_plus,
              onTapItem: () {
                throw UnimplementedError();
              },
            )
          ],
          header: Container(
              child: Row(

                  children: [
                    CachedNetworkImage(
                      imageUrl: albumViewModel.art_url,
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
                              albumSongListViewModel.song_name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                              albumViewModel.artist.artist_name,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w400
                              ),
                            )
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        )
                    )
                  ]
              )
          )
      );
  SongRawModel albumSongListViewModel;
  AlbumModel albumViewModel;
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