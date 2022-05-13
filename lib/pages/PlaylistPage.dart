import 'dart:convert';
import 'dart:ui';
import 'package:apple_music/components/SongCardInPlaylist/SongCardInPlaylistList.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';

import '../components/Other/PageLoadError.dart';
import '../models_refactor/PlaylistModel.dart';
import '../models_refactor/ArtistModel.dart';

class PlaylistView extends StatefulWidget {
  final Future<PlaylistModel?> playlistModel;

  const PlaylistView({Key? key, required this.playlistModel}) : super(key: key);
  @override
  State<PlaylistView> createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {

  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;
  ValueNotifier isInit = ValueNotifier<bool>(false);

  late ScrollController _scrollController = ScrollController();
  bool lastStatus = true;

  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  // List<SongModel> TopListSongConverter(ArtistModel artistModel){
  //   List<SongModel> listSong = [];
  //   if (artistModel.top_song_list != null) {
  //     for (SongRawModelArtist song in artistModel.top_song_list!){
  //       listSong.add(SongModel(
  //         id: song.id,
  //         lyric_key: song.lyric_key,
  //         song_name: song.song_name,
  //         song_key: song.song_key,
  //         artist: ArtistRawModel(
  //           album_list_id: artistModel.album_list.map((item) => item.id as String).toList(),
  //           artist_description: artistModel.artist_description,
  //           artist_image_url: artistModel.artist_image_url,
  //           artist_name: artistModel.artist_name,
  //           top_song_list_id: artistModel.top_song_list != null ? artistModel.top_song_list!.map((item) => item.id as String).toList() : null,
  //           id: artistModel.id
  //         ),
  //         album: song.album,
  //       ));
  //     }
  //   }
  //   return listSong;
  // }


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
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<PlaylistModel?>(
        future: widget.playlistModel,
        builder: (BuildContext context, AsyncSnapshot<PlaylistModel?> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            if (snapshot.data!.playlist_name == "PlaylistError"){
              children = <Widget>[
                Scaffold(
                    appBar: AppBar(
                      leading: IconButton(
                          icon: const Icon(SFSymbols.chevron_left, color: Colors.red),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      backgroundColor: Colors.white,
                    ),
                    body: PageLoadError(title: "Lỗi tải playist")
                )
                ];
            } else {
              // if (snapshot.data!.artist_video_url != null && isInit.value == false) {
              //   videoPlayerController = VideoPlayerController.network(snapshot.data!.artist_video_url!);
              //   videoPlayerController?.addListener(() {
              //     if(videoPlayerController!.value.isInitialized){
              //       isInit.value = true;
              //     } else {
              //       isInit.value = false;
              //     }
              //   });
              //     chewieController = ChewieController(
              //         videoPlayerController: videoPlayerController!,
              //         aspectRatio: 16 / 16,
              //         fullScreenByDefault: false ,
              //         autoPlay: true,
              //         looping: true,
              //         showControls : false,
              //         showOptions : false,
              //         showControlsOnInitialize : false
              //     );
              // }
              return Scaffold(
              body: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder: (BuildContext context,
                    bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      leading: IconButton(
                          icon: const Icon(SFSymbols.chevron_left, color: Colors.red),
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
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Visibility(
                                  visible: isShrink ? false : true,
                                  child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Text(snapshot.data!.playlist_name,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                          ))),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: Visibility(
                                    visible: isShrink ? true : false,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Text(snapshot.data!.playlist_name,
                                              style: const TextStyle(
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
                                          padding: const EdgeInsets.only(right: 10),
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            child: const Icon(SFSymbols.play_fill,
                                                color: Colors.white, size: 12),
                                            style: ElevatedButton.styleFrom(
                                              shape: const CircleBorder(),
                                              padding: const EdgeInsets.all(0),
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
                        background: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: ValueListenableBuilder(
                            valueListenable: isInit,
                            builder: (context, a,_) {
                              if (a == true) {
                                return Container(
                                    width: size.width,
                                    child: AspectRatio(
                                      aspectRatio: 16 / 16,
                                      child: Chewie(controller: chewieController!),
                                    ),
                                );
                              } else {
                                return
                                  Container(
                                      width: size.width,
                                          child: FittedBox(
                                            fit: BoxFit.fill,
                                            child: Image.network(snapshot.data!.art_url)
                                          )
                                  );
                              }
                            }
                        )
                        ),
                      ),
                    )
                  ];
                },
                body: ListView(
                    shrinkWrap: true,
                    children: [
                       SongCardInPlaylistList(playlistModel: snapshot.data!)
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
                          icon: const Icon(SFSymbols.chevron_left, color: Colors.red),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    backgroundColor: Colors.white,
                  ),
                  body: const Center(
                      child: const CircularProgressIndicator(color: Colors.red))
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