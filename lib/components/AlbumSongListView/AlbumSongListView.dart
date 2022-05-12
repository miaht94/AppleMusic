import 'package:apple_music/components/ContextMenu/SongContextMenu.dart';
import 'package:apple_music/models_refactor/AlbumModel.dart';
import 'package:apple_music/models_refactor/SongModel.dart';
import 'package:apple_music/models_refactor/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:apple_music/constant.dart';
import 'package:get_it/get_it.dart';
import '../AudioController/AudioManager.dart';
import '../ContextMenu/AlbumContextMenu.dart';
import '../ContextMenu/ContextMenuManager.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:apple_music/components/AudioController/AudioPageRouteManager.dart';
import 'package:apple_music/services/service_locator.dart';

class AlbumSongListView extends StatelessWidget {
  AlbumSongListView({
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
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return AlbumSongButton(
                    songModel: songList[index], albumViewModel: albumViewModel );
              },
              itemCount: songList.length))
    ]);
  }
}

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

  triggerSongContextMenu(dynamic context) => (){
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
          padding: EdgeInsets.all(0),
          height: 45,
          child: Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                Expanded(
                    child: Column(
                  children: [
                    Divider(
                      height: 1,
                      thickness: 0.8,
                      indent: kDefaultPadding * 2,
                      endIndent: 0,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.only(left: kDefaultPadding * 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(songModel.track_number.toString(),
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey)),
                              ],
                            )),
                        GestureDetector(
                          onTap: () {
                            // print("$id");
                          },
                          child: Container(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      // mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(songModel.song_name,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black)),
                                      ])),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: triggerSongContextMenu(context),
                              child: Container(
                                  padding: EdgeInsets.only(right: 17),
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      // mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[

                                        Icon(SFSymbols.ellipsis, size: 15)
                                      ])),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ))
              ]))),
    );
  }
}
