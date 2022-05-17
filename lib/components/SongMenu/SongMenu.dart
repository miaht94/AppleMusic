import 'package:apple_music/components/SongMenu/SongMenuIcon.dart';
import 'package:apple_music/components/SongMenu/SongMenuItem.dart';
import 'package:apple_music/pages/AlbumSubPage.dart';
import 'package:apple_music/pages/ArtistSubPage.dart';
import 'package:apple_music/pages/SongSubPage.dart';
import 'package:flutter/material.dart';
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
          SongMenuItem(iconName: iconNames['Micro'], title: 'Nghệ Sĩ', onTap: (){
            Navigator.push(
              context,
              // ignore: inference_failure_on_instance_creation
              MaterialPageRoute(
                builder: (context) => ArtistSubPage(artistlist:  HttpUtil().getFavoriteArtistList(app_token:GetIt.I.get<CredentialModelNotifier>().value.appToken)),
              ),
            );
          }),
          SongMenuItem(iconName: iconNames['Album'], title: 'Album', onTap: (){
            Navigator.push(
              context,
              // ignore: inference_failure_on_instance_creation
              MaterialPageRoute(
                builder: (context) => AlbumSubPage(albumlist:  HttpUtil().getFavoriteAlbumList(app_token:GetIt.I.get<CredentialModelNotifier>().value.appToken)),
              ),
            );
          }),
          SongMenuItem(iconName: iconNames['MusicNode'], title: 'Bài Hát', onTap: (){
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
