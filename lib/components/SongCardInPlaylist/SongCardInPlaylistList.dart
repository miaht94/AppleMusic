import 'package:flutter/material.dart';
import '../../models_refactor/PlaylistModel.dart';


import 'SongCardInPlaylist.dart';

class SongCardInPlaylistList extends StatelessWidget {
  SongCardInPlaylistList({
    Key? key,
    required this.playlistModel,
  }) : super(key: key);

  final PlaylistModel playlistModel;
  // final AlbumModel albumViewModel;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Align(
          alignment: Alignment.centerRight,
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return SongCardInPlaylist(songModel: playlistModel.songs[index]);
              },
              itemCount: playlistModel.songs.length))
    ]);
  }
}
