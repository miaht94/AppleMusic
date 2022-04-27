import 'dart:ui';

import 'package:apple_music/components/AlbumSongListView/AlbumSongListView.dart';
import 'package:apple_music/components/Other/PageLoadError.dart';
import 'package:apple_music/components/TitleComponent/PageTitleBox.dart';
import 'package:apple_music/models/AlbumViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

import '../models/ArtistViewModel.dart';
import 'ArtistPage.dart';


class AlbumView extends StatelessWidget {

  final Future<AlbumViewModel> albumViewModel;
  
  const AlbumView({Key? key, required this.albumViewModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:  IconButton(
            icon:  Icon(SFSymbols.chevron_left, color:Colors.red),
            onPressed: () {
              Navigator.pop(context);
            })
        ,backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder<AlbumViewModel>(
        future: albumViewModel,
        builder: (BuildContext context, AsyncSnapshot<AlbumViewModel> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            if (snapshot.data!.albumName == "AlbumError"){
              children = <Widget>[PageLoadError(title: "Lỗi tải Album")];
            } else {
              children = <Widget>[AlbumViewContent(model: snapshot.data!)];
            }
          } else {
            children = <Widget>[Center(child: CircularProgressIndicator(color: Colors.red))];
          }
          return Stack(
            children: children,
          );
        },
      ),
    );
  }
}

class AlbumViewContent extends StatefulWidget {
  const AlbumViewContent({Key? key, required this.model}) : super(key: key);

  final AlbumViewModel model;

  @override
  _AlbumViewContentState createState() => _AlbumViewContentState();
}

class _AlbumViewContentState extends State<AlbumViewContent> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
                                child: Image.network(widget.model.artURL)
                            )
                ),Container(
                    alignment: Alignment.topCenter,
                    child: Text(widget.model.albumName, textAlign: TextAlign.center, style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        height: 3
                    ))
                ),Container(
                    alignment: Alignment.topCenter,
                    child: GestureDetector(
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArtistView(artistViewModel: ArtistViewModel.getArtist(widget.model.albumArtist)),
                          ),
                        )
                      },
                      child: Text(widget.model.albumArtist, textAlign: TextAlign.center, style: TextStyle(
                          color: Color.fromRGBO(251, 46, 70, 1),
                          fontFamily: 'Roboto',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                ),Container(
                    alignment: Alignment.topCenter,
                    child: Text( widget.model.albumGenre.toUpperCase() + ' - ' + widget.model.albumYear.toUpperCase(), textAlign: TextAlign.center, style: TextStyle(
                    color: Color.fromRGBO(196, 196, 196, 1),
                    fontFamily: 'Roboto',
                    fontSize: 10,
                    fontWeight: FontWeight.normal,
                    height: 2
                    ),)
                ),Container(
                    child: Text(widget.model.albumDescription, textAlign: TextAlign.left, style: TextStyle(
                        color: Color.fromRGBO(126, 126, 130, 0.6700000166893005),
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        height: 2
                    ),)
                ),
                Container(padding: EdgeInsets.only(
                    bottom: 200),
                    child: AlbumSongListView(songList: widget.model.songList)),

              ]
          ),
        )
    );
  }
}
