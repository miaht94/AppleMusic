import 'package:apple_music/components/HorizontalCard/HorizontalCardsWithTitle.dart';
import 'package:flutter/material.dart';
import '../components/squareCard/HScrollSquareCardWithText.dart';
import '../components/CircleCard/HScrollCircleCardWithText.dart';
import '../components/HorizontalCard/HorizontalCardsWithTitle.dart';
import '../model/HorizontalCardWithTitleModel.dart';
import '../components/SongCardInPlaylist/HScrollCardListWithText.dart';
import '../components/TextListView/TextListView.dart';
import '../components/TitleComponent/PageTitleBox.dart';
import '../constant.dart';

class DiscoveryPage extends StatelessWidget {
  const DiscoveryPage({
    Key? key,
  }) : super(key: key);

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
            child: HScrollSquareCardWithText(title: "Đừng bỏ lỡ",),
          ),
          Container(
            padding: EdgeInsets.only(bottom: VerticalComponentPadding),
            child: HScrollCircleCardWithText(title: "Nghệ Sĩ Được Yêu Thích",),
          ),
          Container(
            padding: EdgeInsets.only(bottom: VerticalComponentPadding),
            child: HScrollCardListWithText(title: "Ca Khúc Mới Hay Nhất"),
          ),
          Container(
            padding: EdgeInsets.only(bottom: VerticalComponentPadding),
            child: TextListView(title: "Khám Phá Thêm"),
          ),
        ],
      );
  }
}
