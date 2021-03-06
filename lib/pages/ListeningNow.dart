import 'package:apple_music/components/TitleComponent/BoldTitle.dart';
import 'package:apple_music/components/TitleComponent/SeeAllButton.dart';
import 'package:apple_music/components/VerticalBigCard/VerticalBigCardConstant.dart';
import 'package:apple_music/components/VerticalBigCard/VerticalBigCardsWithTitle.dart';
import 'package:apple_music/models/CredentialModel.dart';
import 'package:apple_music/models/ListeningNowPageModel.dart';
import 'package:apple_music/pages/PageSkeleton.dart';
import 'package:apple_music/services/service_locator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

import '../components/CircleCard/HScrollCircleCardWithText.dart';
import '../components/SongCardInPlaylist/HScrollCardListConstants.dart';
import '../components/SquareCard/HScrollSquareCardWithText.dart';
import '../components/TitleComponent/PageTitleBox.dart';
import '../constant.dart';

class ListeningNow extends StatefulWidget {
  const ListeningNow({
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
    if (kDebugMode) {
      print(GetIt.I.get<CredentialModelNotifier>().value.appToken);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return
      ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                PageTitleBox(title: 'Nghe Ngay', hasAvt: true,)
                ,
                Container(
                  padding: const EdgeInsets.only(left: kDefaultPadding),
                  child: const BoldTitle(title: 'Lựa chọn hàng đầu')
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: listeningNowPageModel.isListBestChoiceDone,
                  builder: (context, isDone,_) {
                  if (isDone) {
                    return
                    Container(
                      padding: const EdgeInsets.only(bottom: VerticalComponentPadding),
                      child: VerticalBigCardsWithTitle(cards :listeningNowPageModel.listBestChoice),
                    );
                  } else {
                    return SkeletonLoader(
                        builder:
                        Container(
                          padding: const EdgeInsets.only(bottom: VerticalComponentPadding, left: kDefaultPadding),
                          height: size.height * kVCardHeightRatio,
                          child: Row(
                            children: [
                                VerticalBigCardSkeleton(size: size),
                                Container(
                                  width: 10,
                                  height: size.height * kVCardHeightRatio,
                                ),
                                Expanded(
                                child: VerticalBigCardSkeleton(size: size),
                                ),
                              ],
                            ),
                          ),
                        highlightColor: Colors.lightBlue.shade300,
                    );
                    }
                  }
                ),
                ValueListenableBuilder<bool>(
                    valueListenable: listeningNowPageModel.isListRencentlyPlayedDone,
                    builder: (context, isDone,_) {
                      if (isDone) {
                        return
                          Column(
                            children: [
                              Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: kDefaultPadding),
                                  child: BoldTitle(title: 'Album nổi bật'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: kDefaultPadding),
                                  child: SeeAllButton(typeOfList: TypeOfList.album, list: listeningNowPageModel.listRencentlyPlayedRaw,),
                                ),
                              ],
                            ),
                              Container(
                                padding: const EdgeInsets.only(bottom: VerticalComponentPadding),
                                child: HScrollSquareCardWithText(title: 'Album nổi bật', cards: listeningNowPageModel.listRencentlyPlayed),
                              ),
                            ],
                          );} else {
                        return SkeletonLoader(
                          builder:
                          Container(
                            height: size.height * SQUARE_CARD_HEIGHT_RATIO,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(left: kDefaultPadding),
                                  child: SquareCardWithTextSkeleton(size: size),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: kDefaultPadding),
                                  child: SquareCardWithTextSkeleton(size: size),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.only(left: kDefaultPadding),
                                    child: SquareCardWithTextSkeleton(size: size),
                                  ),
                                ),
                              ],
                            ),
                        ),
                          highlightColor: Colors.lightBlue.shade300,
                        );
                      }
                    }
                ),
                ValueListenableBuilder<bool>(
                    valueListenable: listeningNowPageModel.isListFavoriteArtistDone,
                    builder: (context, isDone,_) {
                      if (isDone) {
                        return
                          Container(
                            padding: const EdgeInsets.only(bottom: VerticalComponentPadding),
                            child: HScrollCircleCardWithText(title: 'Nghệ sĩ được yêu thích', cards: listeningNowPageModel.listFavoriteArtist),
                          );} else {
                        return SkeletonLoader(
                          builder:
                          Container(
                            height: size.height * SQUARE_CARD_HEIGHT_RATIO,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(left: kDefaultPadding),
                                  child: SquareCardWithTextSkeleton(size: size),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: kDefaultPadding),
                                  child: SquareCardWithTextSkeleton(size: size),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.only(left: kDefaultPadding),
                                    child: SquareCardWithTextSkeleton(size: size),
                                  ),
                                ),
                              ],
                            ),
                        ),
                      highlightColor: Colors.lightBlue.shade300,
                      );
                      }
                    }
                ),
                Container(
                    padding: const EdgeInsets.only(left: kDefaultPadding),
                    child: const BoldTitle(title: 'Replay cuối năm')
                ),
                ValueListenableBuilder<bool>(
                    valueListenable: listeningNowPageModel.isListYearEndReplaysDone,
                    builder: (context, isDone,_) {
                      if (isDone) {
                        return
                          Container(
                            padding: const EdgeInsets.only(bottom: VerticalComponentPadding),
                            child: VerticalBigCardsWithTitle(cards :listeningNowPageModel.listYearEndReplays),
                          );} else {
                        return SkeletonLoader(
                          builder:
                          Container(
                            padding: const EdgeInsets.only(bottom: VerticalComponentPadding, left: kDefaultPadding),
                            height: size.height * kVCardHeightRatio,
                            child: Row(
                              children: [
                                VerticalBigCardSkeleton(size: size),
                                Container(
                                  width: 10,
                                  height: size.height * kVCardHeightRatio,
                                ),
                                Expanded(
                                  child: VerticalBigCardSkeleton(size: size),
                                ),
                              ],
                            ),
                        ),
                      highlightColor: Colors.lightBlue.shade300,
                      );
                      }
                    }
                ),
                const SizedBox(height: 100)
              ],
            );
          }
        }
