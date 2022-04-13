import 'dart:ui';

import 'package:apple_music/components/SongCardInPlaylist/HScrollCardListWithText.dart';
import 'package:apple_music/components/SquareCard/HScrollSquareCardWithText.dart';
import 'package:apple_music/constant.dart';
import 'package:apple_music/models/HScrollSquareModel.dart';
import 'package:apple_music/models/SongCardInPlaylistModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:uuid/uuid.dart';

import '../models/ArtistViewModel.dart';

class ArtistView extends StatefulWidget {
  final ArtistViewModel artistViewModel;
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
    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
        SliverAppBar(
                    leading: Icon(SFSymbols.chevron_left, color:Colors.red),
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
                                    alignment: Alignment.bottomCenter, child: Text(widget.artistViewModel.artistName, style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ))),
                              ),
                              Container(
                                padding: EdgeInsets.only(left:30),
                                child: Visibility(
                                  visible: isShrink ? true : false,
                                  child: Align(
                                      alignment: Alignment.bottomCenter, child: Text(widget.artistViewModel.artistName, style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                  ))),
                                ),
                              ),
                              Expanded(
                                  child:
                                  Visibility(
                                    visible: !isShrink,
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        width:40,
                                        height:30,
                                        padding: EdgeInsets.only(right: 10),
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: Icon(SFSymbols.play_fill, color: Colors.white, size:12),
                                          style: ElevatedButton.styleFrom(
                                            shape: CircleBorder(),
                                            padding: EdgeInsets.all(0),
                                            primary: Colors.red, // <-- Button color
                                            onPrimary: Colors.red, // <-- Splash color
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
                        widget.artistViewModel.artURL,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  )
        ];
      },
      body: ListView(
          shrinkWrap: true,
          children:[
                      ArtistHighlightAlbum(album: widget.artistViewModel.highlightAlbum),
                      HScrollCardListWithText(title: "Ca Khúc Mới Hay Nhất", cards: widget.artistViewModel.topSongList ),
                      Container(
                        padding: EdgeInsets.only(bottom: VerticalComponentPadding),
                        child: HScrollSquareCardWithText(title: "Album đã phát hành", cards: widget.artistViewModel.albumList),
                      )
                    ]
                ),

    );
  }

}

class ArtistHighlightAlbum extends StatelessWidget {
  const ArtistHighlightAlbum({
    Key? key,
    required this.album
  }) : super(key: key);

  final ArtistHighlightAlbumModel album;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left:20,bottom:20,right:10),
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

class ArtistHighlightAlbumModel {
  ArtistHighlightAlbumModel(this._albumName, this._albumArtist, this._albumYear, this._artURL) {
    id = Uuid().v4();
  }
  String _albumName;
  String _albumArtist;
  String _artURL;
  int _albumYear;
  late String id;

  String get albumName{
    return _albumName;
  }

  String get albumArtist{
    return _albumArtist;
  }

  int get albumYear{
    return _albumYear;
  }

  String get artURL{
    return _artURL;
  }

  static ArtistHighlightAlbumModel getSampleData() {
    return new ArtistHighlightAlbumModel("Message In A Bottle (Taylor's Version)", "Taylor Swift", 2022, "https://upload.wikimedia.org/wikipedia/en/4/47/Taylor_Swift_-_Red_%28Taylor%27s_Version%29.png" );
  }
}

