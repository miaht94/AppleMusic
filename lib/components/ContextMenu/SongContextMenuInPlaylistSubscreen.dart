import 'package:advance_notification/advance_notification.dart';
import 'package:apple_music/components/AudioController/AudioManager.dart';
import 'package:apple_music/components/AudioController/AudioPageRouteManager.dart';
import 'package:apple_music/components/ContextMenu/ContextMenu.dart';
import 'package:apple_music/components/ContextMenu/ContextMenuItem.dart';
import 'package:apple_music/components/ContextMenu/ContextMenuManager.dart';
import 'package:apple_music/constant.dart';
import 'package:apple_music/models/CredentialModel.dart';
import 'package:apple_music/models_refactor/PlaylistModel.dart';
import 'package:apple_music/models_refactor/SongModel.dart';
import 'package:apple_music/services/http_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:get_it/get_it.dart';
import 'package:skeletons/skeletons.dart';

// ignore: must_be_immutable
class SongContextMenuInPlaylistSubscreen extends ContextMenu{
  SongContextMenuInPlaylistSubscreen({Key? key, required this.songModel, required this.playlist, this.afterDeleteSong}): 
    super(key: key,
      name: 'SongContextMenuInPlaylistSubscreen',
      action: [

          ContextMenuItem(
            title: 'Phát tiếp theo',
            iconData: SFSymbols.text_insert,
            onTapItem: () {
              GetIt.I.get<AudioManager>().insertNext(songModel.id);
              GetIt.I.get<ContextMenuManager>().contextMenuMap['SongContextMenuInPlaylistSubscreen']!.anim.animateTo(-1, duration: const Duration(milliseconds: 300), curve: Curves.easeOutExpo);
              GetIt.I.get<ContextMenuManager>().contextMenuMap['SongContextMenuInPlaylistSubscreen']!.anim.addStatusListener((status) {
                if (status.name == 'completed') {
                  GetIt.I.get<ContextMenuManager>().removeOverlay('SongContextMenuInPlaylistSubscreen');
                }
              });
              const AdvanceSnackBar(message: 'Yay! you got it', bgColor: Colors.blueAccent).show(GetIt.I.get<AudioPageRouteManager>().getMainContext());
            },
          ),
          ContextMenuItem(
            title: 'Phát cuối cùng',
            iconData: SFSymbols.text_append,
            onTapItem: () {
              GetIt.I.get<AudioManager>().insertTail(songModel.id);
              GetIt.I.get<ContextMenuManager>().contextMenuMap['SongContextMenuInPlaylistSubscreen']!.anim.animateTo(-1, duration: const Duration(milliseconds: 300), curve: Curves.easeOutExpo);
              GetIt.I.get<ContextMenuManager>().contextMenuMap['SongContextMenuInPlaylistSubscreen']!.anim.addStatusListener((status) {
                if (status.name == 'completed') {
                  GetIt.I.get<ContextMenuManager>().removeOverlay('SongContextMenuInPlaylistSubscreen');
                }
              });
              const AdvanceSnackBar(message: 'Yay! you got it', bgColor: Colors.blueAccent).show(GetIt.I.get<AudioPageRouteManager>().getMainContext());
            },
          ),
          ContextMenuItem(
            title: 'Xóa khỏi playlist', 
            iconData: SFSymbols.text_badge_plus,
            onTapItem: () async {
              // throw UnimplementedError();
              await EasyLoading.show(status: 'Đang xóa');
              final bool suc = await HttpUtil().removeSongFromPlaylist(playlist_id : playlist.id, song_id: songModel.id, app_token: GetIt.I.get<CredentialModelNotifier>().value.appToken);
              if (suc) {
                await EasyLoading.showSuccess('Đã xóa', duration: const Duration(seconds: 2));
              } else {
                await EasyLoading.showError('Có lỗi xảy ra', duration: const Duration(seconds: 2));
              }
              await GetIt.I.get<ContextMenuManager>().contextMenuMap['SongContextMenuInPlaylistSubscreen']!.anim.animateTo(-1, duration: const Duration(milliseconds: 300), curve: Curves.easeOutExpo);
              GetIt.I.get<ContextMenuManager>().contextMenuMap['SongContextMenuInPlaylistSubscreen']!.anim.addStatusListener((status) {
                if (status.name == 'completed') {
                  GetIt.I.get<ContextMenuManager>().removeOverlay('SongContextMenuInPlaylistSubscreen');

                  if (afterDeleteSong != null) {
                    afterDeleteSong();
                  }
                }
              });
              const AdvanceSnackBar(message: 'Yay! you got it', bgColor: Colors.blueAccent).show(GetIt.I.get<AudioPageRouteManager>().getMainContext());
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
  PlaylistModel playlist;
  Function? afterDeleteSong;
  
}

