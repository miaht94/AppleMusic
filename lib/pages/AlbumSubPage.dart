import 'package:apple_music/components/HorizontalCard/HorizontalCardsWithTitle.dart';
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

class AlbumSubPage extends StatelessWidget {
  const AlbumSubPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          children: <Widget> [
            AppBar(
                leading:  IconButton(
                    icon:  Icon(SFSymbols.chevron_left, color:Colors.red),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ,backgroundColor: Colors.white,
            elevation: 0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  PageTitleBox(title: "Nghệ sĩ"),
                  ArtistRectangleCard(artistRectangleCardModel: ArtistRectangleCardModel.getSampleData(), onTapArtistCard: onTapArtistCard)
                ],
              ),
            ),
          ]
        ),
      );
  }
}
