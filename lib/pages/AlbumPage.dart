import 'dart:ui';

import 'package:apple_music/components/AlbumSongListView/AlbumSongListView.dart';
import 'package:apple_music/components/AudioController/AudioUi.dart';
import 'package:apple_music/components/ButtonWithIcon/WideButton.dart';
import 'package:apple_music/components/ContextMenu/AlbumContextMenu.dart';
import 'package:apple_music/components/Other/PageLoadError.dart';
import 'package:apple_music/components/TitleComponent/PageTitleBox.dart';
import 'package:apple_music/models/AlbumSongListViewModel.dart';
import 'package:apple_music/models/AlbumViewModel.dart';
import 'package:apple_music/models_refactor/AlbumModel.dart';
import 'package:apple_music/models_refactor/ArtistModel.dart';
import 'package:apple_music/models_refactor/SongModel.dart';
import 'package:apple_music/models_refactor/UserModel.dart';
import 'package:apple_music/services/http_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:get_it/get_it.dart';

import '../components/AudioController/AudioManager.dart';
import '../components/AudioController/AudioPageRouteManager.dart';
import '../components/ContextMenu/ContextMenuManager.dart';
import '../models/ArtistViewModel.dart';
import 'ArtistPage.dart';


class AlbumView extends StatelessWidget {

  final Future<AlbumModel?> albumViewModel;
  
  const AlbumView({Key? key, required this.albumViewModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<AlbumModel?>(
        future: albumViewModel,
        builder: (BuildContext context, AsyncSnapshot<AlbumModel?> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            if (snapshot.data!.album_name == "AlbumError"){
              children = <Widget>[Scaffold(
                  appBar: AppBar(
                    leading:  IconButton(
                        icon:  Icon(SFSymbols.chevron_left, color:Colors.red),
                        onPressed: () {
                          Navigator.pop(context);
                        })
                    ,backgroundColor: Colors.white,
                    elevation: 0,
                  ),
                  body: PageLoadError(title: "Lỗi tải Album")
              )];
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

  final AlbumModel model;

  @override
  _AlbumViewContentState createState() => _AlbumViewContentState();
}

class _AlbumViewContentState extends State<AlbumViewContent> {

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
        _scrollController.offset > (230);
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
    return Scaffold(
        appBar: AppBar(
          leading:  IconButton(
              icon:  Icon(SFSymbols.chevron_left, color:Colors.red),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Visibility(
          visible: isShrink ? true : false,
              child: Text(widget.model.album_name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ))
          ),
          centerTitle: true,
          backgroundColor: isShrink ? Colors.white : Colors.transparent,
          elevation: 0,
          // ContextMenu Button
          actions: <Widget>[
            IconButton(
                icon:  Icon(SFSymbols.ellipsis, color:Colors.red),
                onPressed: () {
                  GetIt.I.get<ContextMenuManager>().insertOverlay(AlbumContextMenu(name: 'AlbumContextMenu', albumViewModel: widget.model));
                }),
            SizedBox(width: 10),
          ],

        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          controller: _scrollController,
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
                                child: Image.network(widget.model.art_url)
                            )
                ),Container(
                    alignment: Alignment.topCenter,
                    child: Text(widget.model.album_name, textAlign: TextAlign.center, style: TextStyle(
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
                            builder: (context) => ArtistView(artistViewModel: HttpUtil().fetchArtistModel(artist_name:widget.model.artist.artist_name)),
                          ),
                        )
                      },
                      child: Text(widget.model.artist.artist_name, textAlign: TextAlign.center, style: TextStyle(
                          color: Color.fromRGBO(251, 46, 70, 1),
                          fontFamily: 'Roboto',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                ),Container(
                    alignment: Alignment.topCenter,
                    child: Text( widget.model.genre.toUpperCase() + ' - ' + widget.model.album_year.toString(), textAlign: TextAlign.center, style: TextStyle(
                    color: Color.fromRGBO(196, 196, 196, 1),
                    fontFamily: 'Roboto',
                    fontSize: 10,
                    fontWeight: FontWeight.normal,
                    height: 2
                    ),)
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical:10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                          WideButton(
                              onTap: (){
                                print("Listing Album Songs");
                                List<String> id = [];
                                for (final SongRawModel song in widget.model.songs) {
                                  id.add(song.id);
                                  print(song.id + " added");
                                }
                                GetIt.I.get<AudioManager>().clearAndAddAList(id);
                                Navigator.push(GetIt.I.get<AudioPageRouteManager>().getMainContext(), PageRouteBuilder(opaque: false, pageBuilder: (_, __, ___) => AudioUi()));
                              },
                              title: "Phát", icon: SFSymbols.arrowtriangle_right_fill
                      ),
                      SizedBox(width: 10),
                      WideButton(
                          onTap: (){
                            print("Everyday I'm Shuffling");
                            List<String> id = [];
                            for (final SongRawModel song in widget.model.songs) {
                              id.add(song.id);
                              print(song.id + "added");
                            }
                            GetIt.I.get<AudioManager>().clearAndAddAList(id);
                            GetIt.I.get<AudioManager>().shuffle();
                            Navigator.push(GetIt.I.get<AudioPageRouteManager>().getMainContext(), PageRouteBuilder(opaque: false, pageBuilder: (_, __, ___) => AudioUi()));
                          },
                          title: "Xáo trộn", icon: SFSymbols.shuffle
                      ),
                    ],
                  ),
                ),
                Container(
                    child: Text((widget.model.album_description != null) ? widget.model.album_description.toString() : '', textAlign: TextAlign.left, style: TextStyle(
                        color: Color.fromRGBO(126, 126, 130, 0.6700000166893005),
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        height: 2
                    ),)
                ),
                Container(padding: EdgeInsets.only(
                    bottom: 200),
                    child: AlbumSongListView(songList: widget.model.convertSongsRawToSongsModel(), albumViewModel: widget.model)),

              ]
          ),
        )
    );
  }
}
