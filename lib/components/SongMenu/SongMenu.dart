import 'package:apple_music/components/SongMenu/SongMenuIcon.dart';
import 'package:apple_music/components/SongMenu/SongMenuItem.dart';
import 'package:flutter/material.dart';


class SongMenu extends StatelessWidget {
  const SongMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Column(
        children: [
          SongMenuItem(iconName: iconNames['Micro'], title: "Nghệ Sĩ"),
          SongMenuItem(iconName: iconNames['Album'], title: "Album"),
          SongMenuItem(iconName: iconNames['MusicNode'], title: "Bài Hát"),
          SongMenuItem(iconName: iconNames['PlaylistIcon'], title: "Playlist"),
          SongMenuItem(iconName: iconNames['CircleDownload'], title: "Đã tải về"),
        ],
      );
  }
}
