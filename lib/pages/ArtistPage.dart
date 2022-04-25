import 'dart:convert';
import 'dart:ui';

import 'package:apple_music/components/SongCardInPlaylist/HScrollCardListWithText.dart';
import 'package:apple_music/components/SquareCard/HScrollSquareCardWithText.dart';
import 'package:apple_music/constant.dart';
import 'package:apple_music/models/HScrollSquareModel.dart';
import 'package:apple_music/models/SongCardInPlaylistModel.dart';
import 'package:apple_music/models/SongModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import '../components/Other/PageLoadError.dart';
import '../models/ArtistViewModel.dart';

class ArtistView extends StatefulWidget {
  final Future<ArtistViewModel> artistViewModel;

  const ArtistView({Key? key, required this.artistViewModel}) : super(key: key);
  @override
  State<ArtistView> createState() => _ArtistViewState();
}

class _ArtistViewState extends State<ArtistView> {

  late ScrollController _scrollController = ScrollController();

  bool lastStatus = true;

  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  bool get isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (300 - kToolbarHeight);
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ArtistViewModel>(
        future: widget.artistViewModel,
        builder: (BuildContext context, AsyncSnapshot<ArtistViewModel> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            if (snapshot.data!.artistName == "ArtistError"){
              children = <Widget>[
                Scaffold(
                    appBar: AppBar(
                      leading: IconButton(
                          icon: Icon(SFSymbols.chevron_left, color: Colors.red),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      backgroundColor: Colors.white,
                    ),
                    body: PageLoadError(title: "Lỗi tải nghệ sĩ")
                )
                ];
            } else {
            return Scaffold(
              body: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder: (BuildContext context,
                    bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      leading: IconButton(
                          icon: Icon(SFSymbols.chevron_left, color: Colors.red),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      pinned: true,
                      floating: false,
                      backgroundColor: Colors.white,
                      expandedHeight: 300.0,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title: Container(
                          alignment: Alignment.bottomLeft,
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Visibility(
                                  visible: isShrink ? false : true,
                                  child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Text(snapshot.data!.artistName,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                          ))),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 30),
                                  child: Visibility(
                                    visible: isShrink ? true : false,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Text(snapshot.data!.artistName,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                              ))),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child:
                                    Visibility(
                                      visible: !isShrink,
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Container(
                                          width: 40,
                                          height: 30,
                                          padding: EdgeInsets.only(right: 10),
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            child: Icon(SFSymbols.play_fill,
                                                color: Colors.white, size: 12),
                                            style: ElevatedButton.styleFrom(
                                              shape: CircleBorder(),
                                              padding: EdgeInsets.all(0),
                                              primary: Colors.red,
                                              // <-- Button color
                                              onPrimary: Colors
                                                  .red, // <-- Splash color
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                )
                              ]
                          ),
                        ),
                        background: Image.network(
                          snapshot.data!.artURL,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    )
                  ];
                },
                body: ListView(
                    shrinkWrap: true,
                    children: [
                      ArtistHighlightAlbum(
                          album: snapshot.data!.highlightSong),
                      HScrollCardListWithText(title: "Ca Khúc Mới Hay Nhất",
                          cards: snapshot.data!.topSongList),
                      Container(
                        padding: EdgeInsets.only(
                            bottom: VerticalComponentPadding),
                        child: HScrollSquareCardWithText(
                            title: "Album đã phát hành",
                            cards: snapshot.data!.albumList),
                      )
                    ]
                ),

              ),
            );
            }
          } else {
            children = <Widget>[
              Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                          icon: Icon(SFSymbols.chevron_left, color: Colors.red),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    backgroundColor: Colors.white,
                  ),
                  body: Center(
                      child: CircularProgressIndicator(color: Colors.red))
              )
            ];
          }
          return Stack(
            children: children,
          );
        }
    );
  }

}

class ArtistHighlightAlbum extends StatelessWidget {
  const ArtistHighlightAlbum({
    Key? key,
    required this.album
  }) : super(key: key);

  final ArtistHighlightSongModel album;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image.network(
                    album.artURL,
                    height: 100,
                    width: 100,
                  ),
                )
            ),
            Expanded(
                child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                                Text(album.albumYear.toString(), style: TextStyle(fontSize: 11, color: Colors.grey)),
                                SizedBox(height: 5),
                                Text(album.albumName, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                SizedBox(height: 5),
                                Text(album.albumArtist, style: TextStyle(fontSize: 11, color: Colors.grey)),
                                SizedBox(height: 5),
                                Container(
                                  height:19,
                                  width:19,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: Icon(SFSymbols.plus, color: Colors.red, size:16),
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      padding: EdgeInsets.all(0),
                                      primary: Color.fromRGBO(250, 250, 250, 100), // <-- Button color
                                      onPrimary: Color.fromRGBO(250, 250, 250, 100), // <-- Splash color
                                    ),
                                  ),
                                ),
                              ],
                            )
            )
      ])
    );
  }
}

class ArtistHighlightSongModel {
  ArtistHighlightSongModel(this._songName, this._songArtist, this._albumYear, this._artURL, this._id);

  String _songName;
  String _songArtist;
  String _artURL;
  int _albumYear;
  String _id;

  String get albumName{
    return _songName;
  }

  String get albumArtist{
    return _songArtist;
  }

  int get albumYear{
    return _albumYear;
  }

  String get artURL{
    return _artURL;
  }
  String get id{
    return _id;
  }

  factory ArtistHighlightSongModel.fromJson(Map<String, dynamic> json) {
    return ArtistHighlightSongModel(
      json['song']['song_name'],
      json['song']['artist']['artist_name'],
      json['song']['album']['album_year'],
      json['song']['album']['art_url'],
      json['song']['_id']
    );
  }

  static Future<ArtistHighlightSongModel> getHighlightSongByID(id) async {
    final Uri httpURI = Uri(scheme: 'http', host: SV_HOSTNAME, port: SV_PORT, path: SONG_PATH, queryParameters: {
      '_id': id
    });
    final  response = await http.get(httpURI);
    if (response.statusCode == 200){
      JsonDecoder decoder = JsonDecoder();
      ArtistHighlightSongModel song = ArtistHighlightSongModel.fromJson(decoder.convert(response.body));
      return song;
    } else {
      return Future.error('No song for Id(${id})');
    }
  }

  static ArtistHighlightSongModel getSampleData() {
    return new ArtistHighlightSongModel("Message In A Bottle (Taylor's Version)", "Taylor Swift", 2022, "https://upload.wikimedia.org/wikipedia/en/4/47/Taylor_Swift_-_Red_%28Taylor%27s_Version%29.png", "123456");
  }
}

