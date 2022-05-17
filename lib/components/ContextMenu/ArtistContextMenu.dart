import 'package:apple_music/components/ContextMenu/ContextMenu.dart';
import 'package:apple_music/components/ContextMenu/ContextMenuItem.dart';
import 'package:apple_music/components/ContextMenu/ContextMenuManager.dart';
import 'package:apple_music/constant.dart';
import 'package:apple_music/models/CredentialModel.dart';
import 'package:apple_music/models_refactor/ArtistModel.dart';
import 'package:apple_music/models_refactor/UserModel.dart';
import 'package:apple_music/services/http_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:get_it/get_it.dart';
import 'package:skeletons/skeletons.dart';


// ignore: must_be_immutable
class ArtistContextMenu extends ContextMenu{
  ArtistContextMenu({Key? key, required this.artistModel}):
    super(key: key,
      name: 'ArtistContextMenu',
      action: [
          ValueListenableBuilder<UserModel>(valueListenable: GetIt.I.get<UserModelNotifier>(), builder: (context, userModel, _) {
            return !userModel.containFavArtist(artistModel.id) ?
          ContextMenuItem(
            title: 'Thêm vào yêu thích',
            iconData: SFSymbols.heart,
            onTapItem: () async {
              await EasyLoading.show(status: 'Đang thêm nghệ sĩ vào yêu thích');
              final bool suc = await HttpUtil().updateFavorite(favorite_artists: [artistModel.id], action: FAVORITE_ACTION.push, app_token: GetIt.I.get<CredentialModelNotifier>().value.appToken);
              if (suc) {
                await GetIt.I.get<UserModelNotifier>().refreshUser();
                GetIt.I.get<ContextMenuManager>().contextMenuMap['ArtistContextMenu']!.closeContextMenu(() {
                EasyLoading.showSuccess('Đã thêm', duration:const Duration(seconds: 3));
                GetIt.I.get<ContextMenuManager>().removeOverlay('ArtistContextMenu');
                });
              } else {
                await EasyLoading.showError('Thất bại', duration: const Duration(seconds: 3));
              }
              
            },
          ) :
          ContextMenuItem(
            title: 'Xóa khỏi yêu thích',
            iconData: SFSymbols.heart_slash,
            onTapItem: () async {
              await EasyLoading.show(status: 'Đang xóa nghệ sĩ khỏi yêu thích');
              final bool suc = await HttpUtil().updateFavorite(favorite_artists: [artistModel.id], action: FAVORITE_ACTION.pop, app_token: GetIt.I.get<CredentialModelNotifier>().value.appToken);
              if (suc) {
                await GetIt.I.get<UserModelNotifier>().refreshUser();
                GetIt.I.get<ContextMenuManager>().contextMenuMap['ArtistContextMenu']!.closeContextMenu(() {
                EasyLoading.showSuccess('Đã xóa', duration:const Duration(seconds: 3));
                GetIt.I.get<ContextMenuManager>().removeOverlay('ArtistContextMenu');
                });
              } else {
                await EasyLoading.showError('Thất bại', duration: const Duration(seconds: 3));
              }
              
            },
          );
          })
          
      ],
      header: Row(
        children: [
          CachedNetworkImage(
            imageUrl: artistModel.artist_image_url,
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
                  artistModel.artist_name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),

                Text(
                  'Nghệ sĩ',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[400],
                    fontWeight: FontWeight.w400
                  ),
                )
              ],
            )
          )
        ]
      )
    );
  ArtistModel artistModel;
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

