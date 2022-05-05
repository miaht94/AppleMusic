import 'package:apple_music/components/HorizontalCard/HorizontalCardsWithTitle.dart';
import 'package:apple_music/models/HScrollCircleModel.dart';
import 'package:apple_music/models/HScrollSquareModel.dart';
import 'package:apple_music/models/SongCardInPlaylistModel.dart';
import 'package:flutter/material.dart';
import '../components/SquareCard/HScrollSquareCardWithText.dart';
import '../components/CircleCard/HScrollCircleCardWithText.dart';
import '../components/HorizontalCard/HorizontalCardsWithTitle.dart';
import '../models/HorizontalCardWithTitleModel.dart';
import '../components/SongCardInPlaylist/HScrollCardListWithText.dart';
import '../components/TextListView/TextListView.dart';
import '../components/TitleComponent/PageTitleBox.dart';
import '../constant.dart';

class DiscoveryPage extends StatefulWidget {
  const DiscoveryPage({
    Key? key,
  }) : super(key: key);

  @override
  State<DiscoveryPage> createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return
      ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          PageTitleBox(title: "Khám Phá")
          ,
          Container(
            padding: EdgeInsets.only(bottom: VerticalComponentPadding),
            child: HorizontalCardsWithTitle(cards :HorizontalCardWithTitleModel.getSampleData()),
          ),
          Container(
            padding: EdgeInsets.only(bottom: VerticalComponentPadding),
            child: HScrollSquareCardWithText(title: "Đừng bỏ lỡ", cards: HScrollSquareCardModel.getSampleData()),
          ),
          Container(
            padding: EdgeInsets.only(bottom: VerticalComponentPadding),
            child: HScrollCircleCardWithText(title: "Nghệ Sĩ Được Yêu Thích", cards: HScrollCircleCardModel.getSampleData()),
          ),
          Container(
            padding: EdgeInsets.only(bottom: VerticalComponentPadding),
            child: HScrollCardListWithText(title: "Ca Khúc Mới Hay Nhất", cards: SongCardInPlaylistModel.getSampleDataList()),
          ),
          Container(
            padding: EdgeInsets.only(bottom: VerticalComponentPadding),
            child: TextListView(title: "Khám Phá Thêm"),
          ),
        ],
      );
  }
}
