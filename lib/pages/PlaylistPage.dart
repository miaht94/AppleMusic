
import 'package:apple_music/components/AudioController/AudioUi.dart';
import 'package:apple_music/components/ButtonWithIcon/WideButton.dart';
import 'package:apple_music/components/Other/PageLoadError.dart';
import 'package:apple_music/components/SongCardInPlaylist/SongCardInPlaylistList.dart';
import 'package:apple_music/constant.dart';
import 'package:apple_music/models_refactor/SongModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:get_it/get_it.dart';

import '../components/AudioController/AudioManager.dart';
import '../components/AudioController/AudioPageRouteManager.dart';
import '../components/ContextMenu/ContextMenuManager.dart';
import '../components/ContextMenu/PlaylistContextMenu.dart';
import '../models_refactor/PlaylistModel.dart';


class PlaylistView extends StatelessWidget {

  final Future<PlaylistModel?> playlistModel;
  
  // ignore: sort_constructors_first
  const PlaylistView({Key? key, required this.playlistModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<PlaylistModel?>(
        future: playlistModel,
        builder: (BuildContext context, AsyncSnapshot<PlaylistModel?> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            if (snapshot.data!.playlist_name == 'PlaylistError'){
              children = <Widget>[
                Scaffold(
                  appBar: AppBar(
                    leading:  IconButton(
                        icon:  const Icon(SFSymbols.chevron_left, color:Colors.red),
                        onPressed: () {
                          Navigator.pop(context);
                        })
                    ,backgroundColor: Colors.white,
                    elevation: 0,
                  ),
                  body: PageLoadError(title: 'Lỗi tải Playlist')
              )];
            } else {
              children = <Widget>[PlaylistViewContent(model: snapshot.data!)];
            }
          } else {
            children = <Widget>[const Center(child: CircularProgressIndicator(color: Colors.red))];
          }
          return Stack(
            children: children,
          );
        },
      ),
    );
  }
}

class PlaylistViewContent extends StatefulWidget {
  const PlaylistViewContent({Key? key, required this.model}) : super(key: key);

  final PlaylistModel model;

  @override
  _PlaylistViewContentState createState() => _PlaylistViewContentState();
}

class _PlaylistViewContentState extends State<PlaylistViewContent> {

  late ScrollController _scrollController = ScrollController();
  bool lastStatus = true;

  void _scrollListener() {
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
            icon:  Icon(SFSymbols.chevron_left, color: isShrink ?  Colors.red : Colors.white),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Visibility(
            // ignore: avoid_bool_literals_in_conditional_expressions
            visible: isShrink ? true : false,
            child: Text(widget.model.playlist_name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ))
        ),
        centerTitle: true,
        backgroundColor: isShrink ? Colors.white : Colors.transparent,
        elevation: 0,
        // ContextMenu Button
        actions: <Widget>[
          IconButton(
              icon:  Icon(SFSymbols.ellipsis, color: isShrink ?  Colors.red : Colors.white),
              onPressed: () {
                GetIt.I.get<ContextMenuManager>().insertOverlay(PlaylistContextMenu(playlistModel: widget.model));
              }),
          const SizedBox(width: 10),
        ],
      ),
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
              children: <Widget>[
                
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 450,
                  child: Stack(
                    children: <Widget>[
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: 450,
                          foregroundDecoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.black, Colors.transparent, Colors.transparent, Colors.black],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0, 0.2, 0.4, 1],
                            ),
                          ),
                          child: Image.network(widget.model.art_url,
                              fit: BoxFit.cover
                          )
                      ),
                      Column(
                        children: [
                          const SizedBox(height:240),
                          Container(
                              alignment: Alignment.topCenter,
                              child: Text(widget.model.playlist_name, textAlign: TextAlign.center, style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  height: 3
                              ))
                          ),
                          Container(
                              alignment: Alignment.topCenter,
                              child: GestureDetector(
                                onTap: () => {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => ArtistView(artistViewModel: HttpUtil().fetchArtistModel(artist_name:widget.model.artist.artist_name)),
                                  //   ),
                                  // )
                                },
                                child: Text(widget.model.public == true ? 'Playlist công khai' : 'Playlist không công khai', textAlign: TextAlign.center, style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Roboto',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                ),
                              )
                          ),
                          Container(
                              alignment: Alignment.topCenter,
                              child: const Text('CẬP NHẬT HÔM QUA', textAlign: TextAlign.center, style: TextStyle(
                                  color: Color.fromRGBO(196, 196, 196, 1),
                                  fontFamily: 'Roboto',
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  height: 2
                              ),)
                          ),

                          //Playlist play, shuffle buttons
                          Container(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                WideButton(
                                    onTap: (){
                                      if (kDebugMode) {
                                        print('Listing Album Songs');
                                      }
                                      final List<String> id = [];
                                      for (final SongModel song in widget.model.songs) {
                                        id.add(song.id);
                                        if (kDebugMode) {
                                          print('${song.id} added');
                                        }
                                      }
                                      GetIt.I.get<AudioManager>().clearAndAddAList(id);
                                      // ignore: inference_failure_on_instance_creation
                                      Navigator.push(GetIt.I.get<AudioPageRouteManager>().getMainContext(), PageRouteBuilder(opaque: false, pageBuilder: (_, __, ___) => const AudioUi()));
                                    },
                                    title: 'Phát', icon: SFSymbols.arrowtriangle_right_fill
                                ),
                                const SizedBox(width: 10),
                                WideButton(
                                    onTap: (){
                                      if (kDebugMode) {
                                        print("Everyday I'm Shuffling");
                                      }
                                      final List<String> id = [];
                                      for (final SongModel song in widget.model.songs) {
                                        id.add(song.id);
                                        if (kDebugMode) {
                                          print('${song.id}added');
                                        }
                                      }
                                      GetIt.I.get<AudioManager>().clearAndAddAList(id);
                                      GetIt.I.get<AudioManager>().shuffle();
                                      // ignore: inference_failure_on_instance_creation
                                      Navigator.push(GetIt.I.get<AudioPageRouteManager>().getMainContext(), PageRouteBuilder(opaque: false, pageBuilder: (_, __, ___) => const AudioUi()));
                                    },
                                    title: 'Xáo trộn', icon: SFSymbols.shuffle
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding*2),
                              child: RichText(overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                // ignore: unnecessary_null_comparison
                                text: TextSpan(text: (widget.model.playlist_description != null) ? widget.model.playlist_description : '', style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Roboto',
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  height: 1.5)
                              ),)
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: kDefaultPadding,),
                Container(
                  padding: const EdgeInsets.only(left: kDefaultPadding),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Danh sách bài hát',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ),
                Container(
                    padding: const EdgeInsets.only(left: kDefaultPadding, bottom: 200),
                    child: SongCardInPlaylistList(playlistModel: widget.model),
                ),
                
                // SizedBox(height: 120,)
              ]
          ),
        )
    );
  }
}
