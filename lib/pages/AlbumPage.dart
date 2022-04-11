import 'dart:ui';

import 'package:apple_music/components/AlbumSongListView/AlbumSongListView.dart';
import 'package:apple_music/components/TitleComponent/PageTitleBox.dart';
import 'package:apple_music/models/AlbumViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';



class AlbumView extends StatelessWidget {
  final AlbumViewModel albumViewModel;

  const AlbumView({Key? key, required this.albumViewModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlbumViewContent(
        albumViewModel: albumViewModel,
    );
  }
}


class AlbumViewContent extends StatefulWidget {
  const AlbumViewContent({Key? key, required this.albumViewModel}) : super(key: key);

  final AlbumViewModel albumViewModel;

  @override
  _AlbumViewContentState createState() => _AlbumViewContentState();
}

class Song {
  String songName = '';
  int trackNumber = 0;
  String collaboration = 'none';
  String value = '';

  Song(this.trackNumber, this.songName, this.value, this.collaboration);
}

class _AlbumViewContentState extends State<AlbumViewContent> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            leading: Icon(SFSymbols.chevron_left, color:Colors.red),

            backgroundColor: Colors.white,
            elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 10),
          child: Column(
              children: <Widget>[
                Container(
                  width: 200,
                  height: 200,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x40FFCCFF),
                          spreadRadius: 1,
                          blurRadius: 30,
                          offset: Offset(0, 0), // Shadow position
                        ),
                      ],
                    ),
                  child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(widget.albumViewModel.artURL)
                            )
                ),Container(
                    alignment: Alignment.topCenter,
                    child: Text(widget.albumViewModel.albumName, textAlign: TextAlign.center, style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        height: 3
                    ))
                ),Container(
                    alignment: Alignment.topCenter,
                    child: Text(widget.albumViewModel.albumArtist, textAlign: TextAlign.center, style: TextStyle(
                        color: Color.fromRGBO(251, 46, 70, 1),
                        fontFamily: 'Roboto',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                ),Container(
                    alignment: Alignment.topCenter,
                    child: Text( widget.albumViewModel.albumGenre.toUpperCase() + ' - ' + widget.albumViewModel.albumYear.toUpperCase(), textAlign: TextAlign.center, style: TextStyle(
                    color: Color.fromRGBO(196, 196, 196, 1),
                    fontFamily: 'Roboto',
                    fontSize: 10,
                    fontWeight: FontWeight.normal,
                    height: 2
                    ),)
                ),Container(
                    child: Text(widget.albumViewModel.albumDescription, textAlign: TextAlign.left, style: TextStyle(
                        color: Color.fromRGBO(126, 126, 130, 0.6700000166893005),
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        height: 2
                    ),)
                ),
                AlbumSongListView(songList: widget.albumViewModel.songList),

              ]
          ),
        )
    );
  }
}
        