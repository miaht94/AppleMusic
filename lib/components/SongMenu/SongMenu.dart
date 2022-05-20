import 'package:apple_music/components/SongMenu/SongMenuIcon.dart';
import 'package:apple_music/components/SongMenu/SongMenuItem.dart';
import 'package:apple_music/models_refactor/UserModel.dart';
import 'package:apple_music/pages/AlbumSubPage.dart';
import 'package:apple_music/pages/ArtistSubPage.dart';
import 'package:apple_music/pages/SongSubPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:get_it/get_it.dart';

import '../../models/CredentialModel.dart';
import '../../services/http_util.dart';


class SongMenu extends StatelessWidget {
  const SongMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Column(
        children: [
          SongMenuItem(icon: SFSymbols.music_mic, title: 'Nghệ Sĩ', onTap: (){
            Navigator.push(
              context,
              // ignore: inference_failure_on_instance_creation
              MaterialPageRoute(
                builder: (context) => ValueListenableBuilder(
                  valueListenable: GetIt.I.get<UserModelNotifier>(),
                  builder: (context, _, __) => ArtistSubPage(artistlist:  HttpUtil().getFavoriteArtistList(app_token:GetIt.I.get<CredentialModelNotifier>().value.appToken))),
              ),
            );
          }),
          SongMenuItem(icon: SFSymbols.music_albums, title: 'Album', onTap: (){
            Navigator.push(
              context,
              // ignore: inference_failure_on_instance_creation
              MaterialPageRoute(
                builder: (context) => ValueListenableBuilder(
                  valueListenable: GetIt.I.get<UserModelNotifier>(),
                  builder:(context, value, child) =>  
                    AlbumSubPage(
                      albumlist:  HttpUtil().getFavoriteAlbumList(
                        app_token:GetIt.I.get<CredentialModelNotifier>().value.appToken)
                      )
                    ),
              ),
            );
          }),
          SongMenuItem(icon: SFSymbols.music_note_list, title: 'Bài Hát', onTap: (){
            Navigator.push(
              context,
              // ignore: inference_failure_on_instance_creation
              MaterialPageRoute(
                builder: (context) => SongSubPage(songlist:  HttpUtil().getFavoriteSongList(app_token:GetIt.I.get<CredentialModelNotifier>().value.appToken)),
              ),
            );
          }),
        ],
      );
  }
}
