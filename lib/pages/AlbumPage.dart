import 'dart:ui';

import 'package:apple_music/components/AlbumSongListView/AlbumSongListView.dart';
import 'package:apple_music/components/TitleComponent/PageTitleBox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';



class AlbumView extends StatelessWidget {

  final List<Song> sampleSongList = [];

  AlbumView(){
    sampleSongList.add(Song(1, "I Forgot That You Existed", "Value", 'none'));
    sampleSongList.add(Song(2, "Cruel Summer", "Value", 'none'));
    sampleSongList.add(Song(3, "Lover", "Value", 'none'));
    sampleSongList.add(Song(4, "The Man", "Value", 'none'));
    sampleSongList.add(Song(5, "The Archer", "Value", 'none'));
    sampleSongList.add(Song(6, "I Think He Knows", "Value", 'none'));
    sampleSongList.add(Song(7, "Miss Americana & The Heartbreak Prince", "Value", 'none'));
    sampleSongList.add(Song(8, "Paper Rings", "Value", 'none'));
    sampleSongList.add(Song(9, "Cornelia Street", "Value", 'none'));
    sampleSongList.add(Song(10, "Death By a Thousand Cuts", "Value", 'none'));
  }

  @override
  Widget build(BuildContext context) {
    print(sampleSongList[0].songName);
    return AlbumViewContent(
        albumName: "Lover",
        albumArtist: "Taylor Swift",
        albumGenre: "Pop",
        albumYear: "2019",
        artURL: "https://upload.wikimedia.org/wikipedia/vi/c/cd/Taylor_Swift_-_Lover.png",
        songList: sampleSongList,
        albumDescription: "Bức thư tình lãng mạn được viết bởi những giai điệu ngọt ngào."
    );
  }
}


class AlbumViewContent extends StatefulWidget {
  const AlbumViewContent({Key? key, required this.albumName, required this.albumArtist,required this.albumGenre, required this.albumYear, required this.artURL, required this.songList,  required this.albumDescription}) : super(key: key);
  final String albumName;
  final String albumArtist;
  final String albumDescription;
  final String albumGenre;
  final String albumYear;
  final List<Song> songList;
  final String artURL;

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
                                child: Image.network(widget.artURL)
                            )
                ),Container(
                    alignment: Alignment.topCenter,
                    child: Text(widget.albumName, textAlign: TextAlign.center, style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        height: 3
                    ))
                ),Container(
                    alignment: Alignment.topCenter,
                    child: Text(widget.albumArtist, textAlign: TextAlign.center, style: TextStyle(
                        color: Color.fromRGBO(251, 46, 70, 1),
                        fontFamily: 'Roboto',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                ),Container(
                    alignment: Alignment.topCenter,
                    child: Text( widget.albumGenre.toUpperCase() + ' - ' + widget.albumYear.toUpperCase(), textAlign: TextAlign.center, style: TextStyle(
                    color: Color.fromRGBO(196, 196, 196, 1),
                    fontFamily: 'Roboto',
                    fontSize: 10,
                    fontWeight: FontWeight.normal,
                    height: 2
                    ),)
                ),Container(
                    child: Text(widget.albumDescription, textAlign: TextAlign.left, style: TextStyle(
                        color: Color.fromRGBO(126, 126, 130, 0.6700000166893005),
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        height: 2
                    ),)
                ),
                AlbumSongListView(songList: widget.songList),

              ]
          ),
        )
    );
  }
}
        