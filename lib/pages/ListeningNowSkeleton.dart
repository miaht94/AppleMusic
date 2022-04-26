import 'package:apple_music/components/VerticalBigCard/VerticalBigCardConstant.dart';
import 'package:apple_music/constant.dart';
import 'package:flutter/material.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import '../components/SongCardInPlaylist/HScrollCardListConstants.dart';

class ListeningNowSkeleton extends StatefulWidget {
  ListeningNowSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  State<ListeningNowSkeleton> createState() => _ListeningNowSkeletonState();
}

class _ListeningNowSkeletonState extends State<ListeningNowSkeleton> with WidgetsBindingObserver {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SkeletonLoader(
      builder:
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BigtitleSkeleton(),
            ItemTitleSkeleton(),
            Container(
              padding: EdgeInsets.only(bottom: VerticalComponentPadding, left: kDefaultPadding),
              height: size.height * kVCardHeightRatio,
              child: Row(
                children: [
                  VerticalBigCardSkeleton(size: size),
                  Container(
                    width: 10.0,
                    height: size.height * kVCardHeightRatio,
                  ),
                  Expanded(
                    child: VerticalBigCardSkeleton(size: size),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ItemTitleSkeleton(),
                Padding(
                  padding: const EdgeInsets.only(right: kDefaultPadding),
                  child: SmallTitleSkeleton(),
                ),
              ],
            ),
            Container(
              height: size.height * SQUARE_CARD_HEIGHT_RATIO,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: kDefaultPadding),
                    child: SquareCardWithTextSkeleton(size: size),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: kDefaultPadding),
                    child: SquareCardWithTextSkeleton(size: size),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: kDefaultPadding),
                      child: SquareCardWithTextSkeleton(size: size),
                    ),
                  ),
                ],
              ),
            )
          ]
      )
      ,
      items: 1,
      period: Duration(seconds: 2),
      highlightColor: Colors.lightBlue.shade300,
      direction: SkeletonDirection.ltr,
    );
  }

}

class SquareCardWithTextSkeleton extends StatelessWidget {
  const SquareCardWithTextSkeleton({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: size.height * SQUARE_IMAGE_RATIO,
          width: size.height * SQUARE_IMAGE_RATIO,
          color: Colors.white70,
        ),
        Container(
          padding: EdgeInsets.only(top: kDefaultPadding),
          child: SmallTitleSkeleton(),
        ),
        Expanded(
          child: SmallTitleSkeleton(),
        )
      ],
    );
  }
}

class VerticalBigCardSkeleton extends StatelessWidget {
  const VerticalBigCardSkeleton({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SmallTitleSkeleton(),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(bottom: VerticalComponentPadding, left: kDefaultPadding),
            width: size.height * kVCardWidthRatio,
            height: size.height * kVCardHeightRatio,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}

class SmallTitleSkeleton extends StatelessWidget {
  const SmallTitleSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding),
      width: 100,
      height: 10,
      color: Colors.white70,
    );
  }
}

class ItemTitleSkeleton extends StatelessWidget {
  const ItemTitleSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: kDefaultPadding , bottom: kDefaultPadding),
        child: Container(
          height: 20,
          width: 200,
          color: Colors.white70,
        )
    );
  }
}

class BigtitleSkeleton extends StatelessWidget {
  const BigtitleSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: kDefaultPadding * 4 , bottom: kDefaultPadding, left: kDefaultPadding),
        child: Container(
          height: 40,
          width: 150,
          color: Colors.white70,
        )
    );
  }
}