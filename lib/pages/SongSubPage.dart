import 'package:apple_music/components/TitleComponent/PageTitleBoxCompact.dart';
import 'package:apple_music/models_refactor/SongModel.dart';
import 'package:apple_music/services/http_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:get_it/get_it.dart';

import '../components/AudioController/AudioPageRouteManager.dart';
import '../components/Other/PageLoadError.dart';
import '../components/SongCardInPlaylist/SongCardInPlaylist.dart';
import '../constant.dart';
import '../models/ArtistRectangleCardModel.dart';
import 'ArtistPage.dart';

void onTapArtistCard(ArtistRectangleCardModel artistRectangleCardModel) {
  Navigator.push(
   GetIt.I.get<AudioPageRouteManager>().getMainContext(),
    // ignore: inference_failure_on_instance_creation
    MaterialPageRoute(
   builder: (context) => ArtistView(artistViewModel: HttpUtil().fetchArtistModel(artist_name:artistRectangleCardModel.artistName)),
  ));
}

const String PAGE_TITLE = 'Bài hát';

class SongSubPage extends StatefulWidget {
  const SongSubPage({
    Key? key,
    required this.songlist,
  }) : super(key: key);

  final Future<List<SongModel>?> songlist;

  @override
  State<SongSubPage> createState() => _SongSubPageState();
}

class _SongSubPageState extends State<SongSubPage> {


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
        _scrollController.offset > (50);
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
    return
      Scaffold(
        appBar: AppBar(
            leading:  IconButton(
                icon:  const Icon(SFSymbols.chevron_left, color:Colors.red),
                onPressed: () {
                  // print("Popped");
                  Navigator.pop(context);
                }),
            title: Visibility(
                // ignore: avoid_bool_literals_in_conditional_expressions
                visible: isShrink ? true : false,
                child: const Text(PAGE_TITLE,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ))
            ),
            centerTitle: true,
            backgroundColor: isShrink ? Colors.white : Colors.transparent,
            elevation: 0),
        body: FutureBuilder<List<SongModel>?>(
          future: widget.songlist,
          builder: (BuildContext context, AsyncSnapshot<List<SongModel>?> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator(color: Colors.red));
            }
            else {
              if (snapshot.data!.isEmpty){
                return PageLoadError(title: 'Thư viện nhạc rỗng');
              }
              else {
                return SingleChildScrollView(
                  controller: _scrollController,
                  child: Padding(
                    padding: const EdgeInsets.only(left: kDefaultPadding),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        const PageTitleBoxCompact(title: PAGE_TITLE),
                        Padding(
                          padding: const EdgeInsets.only(left: kDefaultPadding),
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, i) {
                              return SongCardInPlaylist(songModel: snapshot.data![i]);
                            },
                            // child: ListView(
                            //   children: <Widget>SongCardinPlaylistMode.
                            // )
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

            }
          }
        ),
      );
  }
}
