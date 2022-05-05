import 'package:apple_music/components/SongMenu/SongMenuIcon.dart';
import 'package:apple_music/components/SongMenu/SongMenuItem.dart';
import 'package:apple_music/pages/AlbumSubPage.dart';
import 'package:apple_music/pages/ArtistSubPage.dart';
import 'package:apple_music/pages/SongSubPage.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../AudioController/AudioPageRouteManager.dart';


class SongMenu extends StatelessWidget {
  const SongMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Column(
        children: [
          SongMenuItem(iconName: iconNames['Micro'], title: "Nghệ Sĩ", onTap: (){
            Navigator.push(
                GetIt.I.get<AudioPageRouteManager>().getMainContext(),
                MaterialPageRoute(
                  builder: (context) => ArtistSubPage()),
            );
          }),
          SongMenuItem(iconName: iconNames['Album'], title: "Album", onTap: (){
            Navigator.push(
              GetIt.I.get<AudioPageRouteManager>().getMainContext(),
              MaterialPageRoute(
                  builder: (context) => AlbumSubPage()),
            );
          }),
          SongMenuItem(iconName: iconNames['MusicNode'], title: "Bài Hát", onTap: (){
            Navigator.push(
              GetIt.I.get<AudioPageRouteManager>().getMainContext(),
              MaterialPageRoute(
                  builder: (context) => SongSubPage())
            );
          }),
          // SongMenuItem(iconName: iconNames['PlaylistIcon'], title: "Playlist", onTap: (){
          //   Navigator.push(
          //     GetIt.I.get<AudioPageRouteManager>().getMainContext(),
          //     MaterialPageRoute(
          //         builder: (context) => ArtistSubPage()),
          //   );
          // })
        ],
      );
  }
}
