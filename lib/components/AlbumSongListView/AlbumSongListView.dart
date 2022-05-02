import 'package:apple_music/models/AlbumSongListViewModel.dart';
import 'package:apple_music/pages/AlbumPage.dart';
import 'package:flutter/material.dart';
import 'package:apple_music/constant.dart';
import 'package:get_it/get_it.dart';
import '../../models/AlbumViewModel.dart';
import '../ContextMenu/AlbumContextMenu.dart';
import '../ContextMenu/ContextMenuManager.dart';
import '../TitleComponent/SeeAllButton.dart';
import '../TitleComponent/BoldTitle.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:apple_music/components/AudioController/AudioPageRouteManager.dart';
import 'package:apple_music/services/service_locator.dart';

class AlbumSongListView extends StatelessWidget {
  AlbumSongListView({
    Key? key,
    required this.songList,
    required this.albumViewModel
  }) : super(key: key);

  final List<AlbumSongListViewModel> songList;
  final AlbumViewModel albumViewModel;

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
                    albumSongListViewModel: songList[index], albumViewModel: albumViewModel );
              },
              itemCount: songList.length))
    ]);
  }
}

class AlbumSongButton extends StatelessWidget {
  AlbumSongButton({
    Key? key,
    required this.albumSongListViewModel,
    required this.albumViewModel
  }) : super(key: key);

  AlbumSongListViewModel albumSongListViewModel;
  AlbumViewModel albumViewModel;

  late AudioPageRouteManager audioPageRouteManager =
      getIt<AudioPageRouteManager>();

  triggerSongContextMenu(dynamic context) => (){
    GetIt.I.get<ContextMenuManager>().insertOverlay(AlbumSongContextMenu(name: 'AlbumSongContextMenu', albumSongListViewModel: this.albumSongListViewModel, albumViewModel: this.albumViewModel));
  };

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Tap'),
        ));
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
                                Text(albumSongListViewModel.trackNumber.toString(),
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
                                        Text(albumSongListViewModel.songName,
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
