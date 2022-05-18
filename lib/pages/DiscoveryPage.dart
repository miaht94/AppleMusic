import 'package:apple_music/components/HorizontalCard/HorizontalCardConstant.dart' show kCardHeight;
import 'package:apple_music/components/HorizontalCard/HorizontalCardsWithTitle.dart';
import 'package:apple_music/components/TitleComponent/BoldTitle.dart';
import 'package:apple_music/components/TitleComponent/SeeAllButton.dart';
import 'package:apple_music/models/DiscoveryPageModel.dart';
import 'package:apple_music/pages/PageSkeleton.dart';
import 'package:apple_music/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

import '../components/CircleCard/HScrollCircleCardWithText.dart';
import '../components/HorizontalCard/HorizontalCardsWithTitle.dart';
import '../components/SongCardInPlaylist/HScrollCardListConstants.dart';
import '../components/SongCardInPlaylist/HScrollCardListWithText.dart';
import '../components/SquareCard/HScrollSquareCardWithText.dart';
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

  DiscoveryPageModel discoveryPageModel = getIt<DiscoveryPageModel>();
  @override
  void initState() {
    super.initState();
    if(!discoveryPageModel.isInit){
      discoveryPageModel.init();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return
      ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          PageTitleBox(title: 'Khám Phá',hasAvt: true,)
          ,
          ValueListenableBuilder<bool>(
              valueListenable: discoveryPageModel.isNewAlbumsDone,
              builder: (context, isDone,_) {
                if (isDone) {
                  return
                    Container(
                      padding: const EdgeInsets.only(bottom: VerticalComponentPadding),
                      child: HorizontalCardsWithTitle(cards :discoveryPageModel.newAlbums),
                    );
                } else {
                  return SkeletonLoader(
                    builder:
                    Container(
                      // padding: EdgeInsets.only(left: kDefaultPadding),
                      height: kCardHeight * 1.4,
                      child: Row(
                        children: [
                          const HorizontalCardSkeleton(),
                          Container(
                            width: 5,
                            height: kCardHeight,
                          ),
                          const Expanded(
                            child: HorizontalCardSkeleton(),
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
              valueListenable: discoveryPageModel.isDoNotMissDone,
              builder: (context, isDone,_) {
                if (isDone) {
                  return
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:  [
                            const Padding(
                              padding: EdgeInsets.only(left: kDefaultPadding * 1.5),
                              child: BoldTitle(title: 'Đừng bỏ lỡ'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: kDefaultPadding),
                              child: SeeAllButton(typeOfList: TypeOfList.album, list: discoveryPageModel.doNotMissRaw,),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: VerticalComponentPadding),
                          child: HScrollSquareCardWithText(title: 'Đừng bỏ lỡ', cards: discoveryPageModel.doNotMiss),
                        ),
                      ],
                    );} else {
                  return SkeletonLoader(
                    builder:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ItemTitleSkeleton(),
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
                      ],
                    ),
                    highlightColor: Colors.lightBlue.shade300,
                  );
                }
              }
          ),
          ValueListenableBuilder<bool>(
              valueListenable: discoveryPageModel.isListFavoriteArtistDone,
              builder: (context, isDone,_) {
                if (isDone) {
                  return
                    Container(
                      padding: const EdgeInsets.only(bottom: VerticalComponentPadding),
                      child: HScrollCircleCardWithText(title: 'Nghệ Sĩ Được Yêu Thích', cards: discoveryPageModel.listFavoriteArtist),
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
              valueListenable: discoveryPageModel.isBestNewSongsDone,
              builder: (context, isDone,_) {
                if (isDone) {
                  return
                    Container(
                      padding: const EdgeInsets.only(bottom: VerticalComponentPadding),
                      child: HScrollCardListWithText(title: 'Ca Khúc Mới Hay Nhất', cards: discoveryPageModel.bestNewSongs),
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
          const SizedBox(height: 100)
        ],
      );
  }
}
