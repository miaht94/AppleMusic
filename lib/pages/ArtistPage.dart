import 'dart:convert';
import 'package:apple_music/components/AudioController/AudioManager.dart';
import 'package:apple_music/components/AudioController/AudioPageRouteManager.dart';
import 'package:apple_music/components/AudioController/AudioUi.dart';
import 'package:apple_music/components/SongCardInPlaylist/HScrollCardListWithText.dart';
import 'package:apple_music/components/SquareCard/HScrollSquareCardWithText.dart';
import 'package:apple_music/constant.dart';
import 'package:apple_music/models/CredentialModel.dart';
import 'package:apple_music/models/HScrollSquareModel.dart';
import 'package:apple_music/models_refactor/SongModel.dart';
import 'package:apple_music/models_refactor/UserModel.dart';
import 'package:apple_music/services/http_util.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';

import '../components/ContextMenu/ArtistContextMenu.dart';
import '../components/ContextMenu/ContextMenuManager.dart';
import '../components/Other/PageLoadError.dart';
import '../models_refactor/ArtistModel.dart';

class ArtistView extends StatefulWidget {
  final Future<ArtistModel?> artistViewModel;

  // ignore: sort_constructors_first
  const ArtistView({Key? key, required this.artistViewModel}) : super(key: key);
  @override
  State<ArtistView> createState() => _ArtistViewState();
}

class _ArtistViewState extends State<ArtistView> {


  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;
  // ignore: strict_raw_type
  ValueNotifier isInit = ValueNotifier<bool>(false);

  late ScrollController _scrollController = ScrollController();
  bool lastStatus = true;

  void _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  ArtistHighlightSongModel HighlighSongConverter(ArtistModel artist) {
    int _albumYear = 0;
    String _artURL = 'https://i1.sndcdn.com/artworks-000145857756-irf4fe-t500x500.jpg';
    for (final AlbumRawModel album in artist.album_list){
      for (final String songId in album.songsId){
        if (songId == artist.highlight_song?.id){
          _albumYear = album.album_year;
          _artURL = album.art_url;
        }
      }
    }
    return ArtistHighlightSongModel(
        artist.highlight_song!.song_name,
        artist.artist_name,
        _albumYear,
        _artURL,
        artist.highlight_song!.id
    );
  }

  List<SongModel> TopListSongConverter(ArtistModel artistModel){
    final List<SongModel> listSong = [];
    if (artistModel.top_song_list != null) {
      for (final SongRawModelArtist song in artistModel.top_song_list!){
        listSong.add(SongModel(
          id: song.id,
          lyric_key: song.lyric_key,
          song_name: song.song_name,
          song_key: song.song_key,
          artist: ArtistRawModel(
            album_list_id: artistModel.album_list.map((item) => item.id).toList(),
            artist_description: artistModel.artist_description,
            artist_image_url: artistModel.artist_image_url,
            artist_name: artistModel.artist_name,
            top_song_list_id: artistModel.top_song_list != null ? artistModel.top_song_list!.map((item) => item.id).toList() : null,
            id: artistModel.id
          ),
          album: song.album,
        ));
      }
    }
    return listSong;
  }

  List<HScrollSquareCardModel> SquareCardsConverter(ArtistModel artistModel){
    final List<HScrollSquareCardModel> listSquareCard = [];
    for (final AlbumRawModel album in artistModel.album_list){
      listSquareCard.add(HScrollSquareCardModel(
        album.album_name,
        artistModel.artist_name,
        album.art_url,
        album.id,
      ));
    }
    return listSquareCard;
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
    final Size size = MediaQuery.of(context).size;
    return FutureBuilder<ArtistModel?>(
        future: widget.artistViewModel,
        builder: (BuildContext context, AsyncSnapshot<ArtistModel?> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            if (snapshot.data!.artist_name == 'ArtistError'){
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
                    body: PageLoadError(title: 'Lỗi tải nghệ sĩ')
                )
                ];
            } else {
              if (snapshot.data!.artist_video_url != null && isInit.value == false) {
                videoPlayerController = VideoPlayerController.network(snapshot.data!.artist_video_url!);
                videoPlayerController?.addListener(() {
                  if(videoPlayerController!.value.isInitialized){
                    isInit.value = true;
                  } else {
                    isInit.value = false;
                  }
                });
                  chewieController = ChewieController(
                      videoPlayerController: videoPlayerController!,
                      aspectRatio: 16 / 16 ,
                      autoPlay: true,
                      looping: true,
                      showControls : false,
                      showOptions : false,
                      showControlsOnInitialize : false
                  );
              }
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
                      actions: <Widget>[
                        IconButton(
                            icon:  const Icon(SFSymbols.ellipsis, color:Colors.red),
                            onPressed: () {
                              GetIt.I.get<ContextMenuManager>().insertOverlay(ArtistContextMenu(artistModel: snapshot.data!,));
                            }),
                        const SizedBox(width: 10),
                      ],
                      pinned: true,
                      backgroundColor: Colors.white,
                      expandedHeight: 300,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title: Container(
                          alignment: Alignment.bottomLeft,
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Visibility(
                                  // ignore: avoid_bool_literals_in_conditional_expressions
                                  visible: isShrink ? false : true,
                                  child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Text(snapshot.data!.artist_name,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ))),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: Visibility(
                                    // ignore: avoid_bool_literals_in_conditional_expressions
                                    visible: isShrink ? true : false,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Text(snapshot.data!.artist_name,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
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
                                            onPressed: () async {
                                              if (snapshot.data!.top_song_list != null) {
                                                final List<String> id = [];
                                                final List<SongRawModelArtist> topSong = snapshot.data!.top_song_list!;
                                                for (final SongRawModelArtist song in topSong) {
                                                  id.add(song.id);
                                                  if (kDebugMode) {
                                                    print('${song.id} added');
                                                  }
                                                }
                                                await EasyLoading.showToast('Play top song of ${snapshot.data!.artist_name}', duration: const Duration(milliseconds:  500));
                                                await GetIt.I.get<AudioManager>().clearAndAddAList(id);
                                                // ignore: inference_failure_on_instance_creation
                                                await Navigator.push(GetIt.I.get<AudioPageRouteManager>().getMainContext(), PageRouteBuilder(opaque: false, pageBuilder: (_, __, ___) => const AudioUi()));
                                              } else {
                                                final List<String> id = snapshot.data!.album_list[0].songsId;

                                                await EasyLoading.showToast('Play first album of ${snapshot.data!.artist_name}', duration: const Duration(milliseconds:  500));
                                                await GetIt.I.get<AudioManager>().clearAndAddAList(id);
                                                // ignore: inference_failure_on_instance_creation
                                                await Navigator.push(GetIt.I.get<AudioPageRouteManager>().getMainContext(), PageRouteBuilder(opaque: false, pageBuilder: (_, __, ___) => const AudioUi()));
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              shape: const CircleBorder(),
                                              padding: const EdgeInsets.all(0),
                                              primary: Colors.red,
                                              // <-- Button color
                                              onPrimary: Colors
                                                  .red, // <-- Splash color
                                            ),
                                            child: const Icon(SFSymbols.play_fill,
                                                color: Colors.white, size: 12),
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
                                            child: Image.network(snapshot.data!.artist_image_url)
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
                      if (snapshot.data!.highlight_song!.song_name != 'NoHighlightSong')
                        ArtistHighlightSong(
                          album: HighlighSongConverter(snapshot.data!)
                        )
                      else
                        Container(),

                      if (snapshot.data!.top_song_list!.isNotEmpty)
                        HScrollCardListWithText(
                          title: 'Ca Khúc Mới Hay Nhất',
                          cards: TopListSongConverter(snapshot.data!)
                      )
                      else
                        Container(),

                      if (snapshot.data!.album_list.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.only(
                              bottom: VerticalComponentPadding),
                        child: HScrollSquareCardWithText(
                            title: 'Album đã phát hành',
                            cards: SquareCardsConverter(snapshot.data!)
                        ),
                      )
                      else
                        Container(),
                      const SizedBox(
                        height:200
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
                          icon: const Icon(SFSymbols.chevron_left, color: Colors.red),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    backgroundColor: Colors.white,
                  ),
                  body: const Center(
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

class ArtistHighlightSong extends StatelessWidget {
  const ArtistHighlightSong({
    Key? key,
    required this.album
  }) : super(key: key);

  final ArtistHighlightSongModel album;

  @override
  Widget build(BuildContext context) {
    return Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
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
                              Text(album.songYear.toString(), style: const TextStyle(fontSize: 11, color: Colors.grey)),
                              const SizedBox(height: 5),
                              Text(album.songName, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 5),
                              Text(album.songArtist, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                              const SizedBox(height: 5),
                              Container(
                                height:19,
                                width:19,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    await EasyLoading.show(status: 'Đang thêm vào yêu thích');
                                    final bool suc = await HttpUtil().updateFavorite(app_token: GetIt.I.get<CredentialModelNotifier>().value.appToken, action: FAVORITE_ACTION.push, favorite_songs: [album.id]);
                                    await GetIt.I.get<UserModelNotifier>().refreshUser();
                                    if (suc) {
                                      await EasyLoading.showSuccess('Thành công', duration: const Duration(seconds: 2));
                                    } else {
                                      await EasyLoading.showError('Thất bại', duration: const Duration(seconds: 2));
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(0),
                                    primary: const Color.fromRGBO(250, 250, 250, 100), // <-- Button color
                                    onPrimary: const Color.fromRGBO(250, 250, 250, 100), // <-- Splash color
                                  ),
                                  child: const Icon(SFSymbols.plus, color: Colors.red, size:16),
                                ),
                              ),
                            ],
                          )
          )
    ]);
  }
}

class ArtistHighlightSongModel {
  ArtistHighlightSongModel(this._songName, this._songArtist, this._albumYear, this._artURL, this._id);

  String _songName;
  String _songArtist;
  String _artURL;
  int _albumYear;
  String _id;

  String get songName{
    return _songName;
  }

  String get songArtist{
    return _songArtist;
  }

  int get songYear{
    return _albumYear;
  }

  String get artURL{
    return _artURL;
  }
  String get id{
    return _id;
  }

  // ignore: sort_constructors_first
  factory ArtistHighlightSongModel.fromJson(Map<String, dynamic> json) {
    return ArtistHighlightSongModel(
      json['song']['song_name'],
      json['song']['artist']['artist_name'],
      json['song']['album']['album_year'],
      json['song']['album']['art_url'],
      json['song']['_id']
    );
  }

  // ignore: inference_failure_on_untyped_parameter
  static Future<ArtistHighlightSongModel> getHighlightSongByID(id) async {
    final Uri httpURI = Uri(scheme: 'http', host: SV_HOSTNAME, port: SV_PORT, path: SONG_PATH, queryParameters: {
      '_id': id
    });
    final  response = await http.get(httpURI);
    if (response.statusCode == 200){
      const JsonDecoder decoder = JsonDecoder();
      final ArtistHighlightSongModel song = ArtistHighlightSongModel.fromJson(decoder.convert(response.body));
      return song;
    } else {
      return Future.error('No song for Id($id)');
    }
  }

  // ignore: prefer_constructors_over_static_methods
  static ArtistHighlightSongModel getSampleData() {
    return ArtistHighlightSongModel("Message In A Bottle (Taylor's Version)", 'Taylor Swift', 2022, 'https://upload.wikimedia.org/wikipedia/en/4/47/Taylor_Swift_-_Red_%28Taylor%27s_Version%29.png', '123456');
  }
}

