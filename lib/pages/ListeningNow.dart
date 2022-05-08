import 'package:apple_music/components/TitleComponent/BoldTitle.dart';
import 'package:apple_music/components/VerticalBigCard/VerticalBigCardsWithTitle.dart';
import 'package:apple_music/models/ListeningNowPageModel.dart';
import 'package:apple_music/pages/ListeningNowSkeleton.dart';
import 'package:apple_music/services/service_locator.dart';
import 'package:flutter/material.dart';
import '../components/SquareCard/HScrollSquareCardWithText.dart';
import '../components/CircleCard/HScrollCircleCardWithText.dart';
import '../components/TitleComponent/PageTitleBox.dart';
import '../constant.dart';

class ListeningNow extends StatefulWidget {
  ListeningNow({
    Key? key,
  }) : super(key: key);

  @override
  State<ListeningNow> createState() => _ListeningNowState();
}

class _ListeningNowState extends State<ListeningNow> {
  ListeningNowPageModel listeningNowPageModel = getIt<ListeningNowPageModel>();

  @override
  void initState() {
    super.initState();
    if(!listeningNowPageModel.isInit){
      listeningNowPageModel.init();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return
      FutureBuilder(
        future: listeningNowPageModel.isDone,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
            return ListView(
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
                  child: VerticalBigCardsWithTitle(cards :listeningNowPageModel.listBestChoice),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: VerticalComponentPadding),
                  child: HScrollSquareCardWithText(title: "Đừng bỏ lỡ", cards: listeningNowPageModel.listRencentlyPlayed),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: VerticalComponentPadding),
                  child: HScrollCircleCardWithText(title: "Nghệ Sĩ Được Yêu Thích", cards: listeningNowPageModel.listFavoriteArtist),
                ),
                Container(
                    padding: EdgeInsets.only(left: kDefaultPadding),
                    child: BoldTitle(title: "Replay cuối năm")
                ),
                Container(
                  padding: EdgeInsets.only(bottom: VerticalComponentPadding, left: kDefaultPadding),
                  child: VerticalBigCardsWithTitle(cards :listeningNowPageModel.listYearEndReplays),
                ),
              ],
            );
          } else {
            return ListeningNowSkeleton();
          }
        }

      );
  }
}
