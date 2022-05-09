import 'package:apple_music/components/HorizontalCard/HorizontalCardsWithTitle.dart';
import 'package:apple_music/components/TitleComponent/PageTitleBoxCompact.dart';
import 'package:apple_music/models/HScrollCircleModel.dart';
import 'package:apple_music/models/HScrollSquareModel.dart';
import 'package:apple_music/models/SongCardInPlaylistModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:get_it/get_it.dart';
import '../components/AudioController/AudioPageRouteManager.dart';
import '../components/RectangleCardSearchPage/ArtistRectangleCard.dart';
import '../components/SongCardInPlaylist/SongCardInPlaylist.dart';
import '../components/SquareCard/HScrollSquareCardWithText.dart';
import '../components/CircleCard/HScrollCircleCardWithText.dart';
import '../components/HorizontalCard/HorizontalCardsWithTitle.dart';
import '../models/ArtistRectangleCardModel.dart';
import '../models/ArtistViewModel.dart';
import '../models/HorizontalCardWithTitleModel.dart';
import '../components/SongCardInPlaylist/HScrollCardListWithText.dart';
import '../components/TextListView/TextListView.dart';
import '../components/TitleComponent/PageTitleBox.dart';
import '../constant.dart';
import 'ArtistPage.dart';

void onTapArtistCard(ArtistRectangleCardModel artistRectangleCardModel) {
  Navigator.push(
   GetIt.I.get<AudioPageRouteManager>().getMainContext(),
    MaterialPageRoute(
   builder: (context) => ArtistView(artistViewModel: ArtistViewModel.getArtist(artistRectangleCardModel.artistName)),
  ));
}

const String PAGE_TITLE = "Bài hát";

class SongSubPage extends StatefulWidget {
  const SongSubPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SongSubPage> createState() => _SongSubPageState();
}

class _SongSubPageState extends State<SongSubPage> {


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
                icon:  Icon(SFSymbols.chevron_left, color:Colors.red),
                onPressed: () {
                  print("Popped");
                  Navigator.pop(context);
                }),
            title: Visibility(
                visible: isShrink ? true : false,
                child: Text(PAGE_TITLE,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ))
            ),
            centerTitle: true,
            backgroundColor: isShrink ? Colors.white : Colors.transparent,
            elevation: 0),
        body: SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
              padding: const EdgeInsets.only(left: kDefaultPadding),
              child: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  PageTitleBoxCompact(title: PAGE_TITLE),
                  Padding(
                    padding: const EdgeInsets.only(left: kDefaultPadding),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: SongCardInPlaylistModel.getSampleDataList().length,
                      itemBuilder: (context, i){
                         return SongCardInPlaylist(songModel: SongCardInPlaylistModel.getSampleDataList()[i],);
                      },
                    // child: ListView(
                    //   children: <Widget>SongCardinPlaylistMode.
                    // )
                    ),
                  ),
                ],
              ),
            ),
        ),
      );
  }
}
