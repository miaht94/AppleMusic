import 'package:apple_music/components/AudioController/AudioPageRouteManager.dart';
import 'package:apple_music/components/ContextMenu/SongContextMenu.dart';
import 'package:apple_music/constant.dart';
import 'package:apple_music/models_refactor/AlbumModel.dart';
import 'package:apple_music/models_refactor/SongModel.dart';
import 'package:apple_music/services/service_locator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:get_it/get_it.dart';

import '../AudioController/AudioManager.dart';
import '../ContextMenu/ContextMenuManager.dart';

class AlbumSongListView extends StatelessWidget {
  const AlbumSongListView({
    Key? key,
    required this.songList,
    required this.albumViewModel
  }) : super(key: key);

  final List<SongModel> songList;
  final AlbumModel albumViewModel;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Align(
          alignment: Alignment.centerRight,
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                if (kDebugMode) {
                  print(songList[index].track_number);
                }
                return AlbumSongButton(
                    songModel: songList[index], albumViewModel: albumViewModel );
              },
              itemCount: songList.length))
    ]);
  }
}

// ignore: must_be_immutable
class AlbumSongButton extends StatelessWidget {
  AlbumSongButton({
    Key? key,
    required this.songModel,
    required this.albumViewModel
  }) : super(key: key);

  SongModel songModel;
  AlbumModel albumViewModel;

  late AudioPageRouteManager audioPageRouteManager =
      getIt<AudioPageRouteManager>();

  Null Function() triggerSongContextMenu(dynamic context) => (){
    // GetIt.I.get<ContextMenuManager>().insertOverlay(AlbumSongContextMenu(name: 'AlbumSongContextMenu', albumSongListViewModel: this.albumSongListViewModel, albumViewModel: this.albumViewModel));
    GetIt.I.get<ContextMenuManager>().insertOverlay(SongContextMenu(songModel: songModel));
  };

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GetIt.I.get<AudioManager>().addAndPlayASong(songModel.id);
      },
      onLongPress: triggerSongContextMenu(context),
      child: Container(
          padding: const EdgeInsets.all(0),
          height: 45,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
            Expanded(
                child: Column(
              children: [
                const Divider(
                  height: 1,
                  thickness: 0.8,
                  indent: kDefaultPadding * 2,
                  endIndent: 0,
                  color: Colors.grey,
                ),
                const SizedBox(height: 12),
                Row(
                  children: <Widget>[
                    Container(
                        padding: const EdgeInsets.only(left: kDefaultPadding * 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(songModel.track_number.toString(),
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.grey)),
                          ],
                        )),
                    GestureDetector(
                      onTap: () {
                        // print("$id");
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                // mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(songModel.song_name,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.black)),
                                ])),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: triggerSongContextMenu(context),
                          child: Container(
                              padding: const EdgeInsets.only(right: 17),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  // mainAxisSize: MainAxisSize.min,
                                  children: const <Widget>[

                                    Icon(SFSymbols.ellipsis, size: 15)
                                  ])),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ))
          ])),
    );
  }
}
