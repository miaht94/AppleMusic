import 'package:apple_music/components/TitleComponent/BoldTitle.dart';
import 'package:apple_music/components/VerticalBigCard/VerticalBigCardsWithTitle.dart';
import 'package:apple_music/models/VerticalCardWithTitleModel.dart';
import 'package:flutter/material.dart';
import '../components/squareCard/HScrollSquareCardWithText.dart';
import '../components/CircleCard/HScrollCircleCardWithText.dart';
import '../components/TitleComponent/PageTitleBox.dart';
import '../constant.dart';

class ListeningNow extends StatelessWidget {
  const ListeningNow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          PageTitleBox(title: "Nghe Ngay")
          ,
          Container(
            padding: EdgeInsets.only(left: kDefaultPadding),
            child: BoldTitle(title: "Lựa Chọn Hàng Đầu")
          ),
          Container(
            padding: EdgeInsets.only(bottom: VerticalComponentPadding, left: kDefaultPadding),
            child: VerticalBigCardsWithTitle(cards :VerticalCardWithTitleModel.getSampleData()),
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
              padding: EdgeInsets.only(left: kDefaultPadding),
              child: BoldTitle(title: "Replay cuối năm")
          ),
          Container(
            padding: EdgeInsets.only(bottom: VerticalComponentPadding, left: kDefaultPadding),
            child: VerticalBigCardsWithTitle(cards :VerticalCardWithTitleModel.getSampleData()),
          ),

        ],
      );
  }
}
