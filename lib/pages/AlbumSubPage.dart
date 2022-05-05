import 'package:apple_music/components/HorizontalCard/HorizontalCardsWithTitle.dart';
import 'package:apple_music/components/RectangleCardSearchPage/AlbumRectangleCard.dart';
import 'package:apple_music/components/TitleComponent/PageTitleBoxCompact.dart';
import 'package:apple_music/models/AlbumRectangleCardModel.dart';
import 'package:apple_music/models/HScrollCircleModel.dart';
import 'package:apple_music/models/HScrollSquareModel.dart';
import 'package:apple_music/models/SongCardInPlaylistModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:get_it/get_it.dart';
import '../components/AudioController/AudioPageRouteManager.dart';
import '../components/RectangleCardSearchPage/ArtistRectangleCard.dart';
import '../components/SquareCard/HScrollSquareCardWithText.dart';
import '../components/CircleCard/HScrollCircleCardWithText.dart';
import '../components/HorizontalCard/HorizontalCardsWithTitle.dart';
import '../models/AlbumViewModel.dart';
import '../models/ArtistRectangleCardModel.dart';
import '../models/ArtistViewModel.dart';
import '../models/HorizontalCardWithTitleModel.dart';
import '../components/SongCardInPlaylist/HScrollCardListWithText.dart';
import '../components/TextListView/TextListView.dart';
import '../components/TitleComponent/PageTitleBox.dart';
import '../constant.dart';
import 'AlbumPage.dart';
import 'ArtistPage.dart';


void onTapAlbumCard(AlbumRectangleCardModel albumRectangleCardModel) {
  Navigator.push(
      GetIt.I.get<AudioPageRouteManager>().getMainContext(),
      MaterialPageRoute(
        builder: (context) => AlbumView(albumViewModel: AlbumViewModel.getAlbum(albumRectangleCardModel.albumName, albumRectangleCardModel.artistName),
      )));
}

const String PAGE_TITLE = "Album";

class AlbumSubPage extends StatefulWidget {
  const AlbumSubPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AlbumSubPage> createState() => _AlbumSubPageState();
}

class _AlbumSubPageState extends State<AlbumSubPage> {


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
            elevation: isShrink ? 1 : 0),
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
                    itemCount: AlbumRectangleCardModel.getSampleData().length,
                    itemBuilder: (context, i){
                      return  AlbumRectangleCard(albumRectangleCardModel: AlbumRectangleCardModel.getSampleData()[i], onTapAlbumCard: onTapAlbumCard);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
