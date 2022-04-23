import 'package:apple_music/models/AlbumSongListViewModel.dart';
import 'package:apple_music/pages/AlbumPage.dart';
import 'package:flutter/material.dart';
import 'package:apple_music/constant.dart';
import '../TitleComponent/SeeAllButton.dart';
import '../TitleComponent/BoldTitle.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

class AlbumSongListView extends StatelessWidget {
  AlbumSongListView({
    Key? key,
    required this.songList,
  }) : super(key: key);

  final List<AlbumSongListViewModel> songList;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Align(
          alignment: Alignment.centerRight,
          child: ListView.builder(
              padding: const EdgeInsets.all(0),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return AlbumSongButton(
                    songName: songList[index].songName,
                    trackNumber: songList[index].trackNumber,
                    collaboration: songList[index].collaboration,
                    value: songList[index].value);
              },
              itemCount: songList.length))
    ]);
  }
}

class AlbumSongButton extends StatelessWidget {
  AlbumSongButton({
    Key? key,
    required this.songName,
    required this.trackNumber,
    required this.collaboration,
    required this.value,
  }) : super(key: key);

  final String songName;
  final int trackNumber;
  final String collaboration;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    height: 25,
                    thickness: 0.8,
                    indent: kDefaultPadding * 2,
                    endIndent: 0,
                    color: Colors.grey,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(left: kDefaultPadding * 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("$trackNumber",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey)),
                            ],
                          )),
                      Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  // mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(songName,
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black)),
                                  ])),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                              padding: EdgeInsets.only(right: 17),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  // mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(SFSymbols.ellipsis, size: 15),
                                  ])),
                        ),
                      )
                    ],
                  ),
                ],
              ))
            ])));
  }
}
