import 'package:apple_music/components/HorizontalCard/HorizontalCardConstant.dart';
import 'package:apple_music/components/VerticalBigCard/VerticalBigCardConstant.dart';
import 'package:apple_music/constant.dart';
import 'package:flutter/material.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import '../components/SongCardInPlaylist/HScrollCardListConstants.dart';

class PageSkeleton extends StatefulWidget {
  const PageSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  State<PageSkeleton> createState() => _PageSkeletonState();
}

// ignore: prefer_mixin
class _PageSkeletonState extends State<PageSkeleton> with WidgetsBindingObserver {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SkeletonLoader(
      builder:
      Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BigtitleSkeleton(),
            const ItemTitleSkeleton(),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                ItemTitleSkeleton(),
                Padding(
                  padding: EdgeInsets.only(right: kDefaultPadding),
                  child: SmallTitleSkeleton(),
                ),
              ],
            ),
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
            )
          ]
      ),
      highlightColor: Colors.lightBlue.shade300,
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: size.height * SQUARE_IMAGE_RATIO,
          width: size.height * SQUARE_IMAGE_RATIO,
          color: Colors.white70,
        ),
        Container(
          padding: const EdgeInsets.only(top: kDefaultPadding),
          child: const SmallTitleSkeleton(),
        ),
        const Expanded(
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SmallTitleSkeleton(),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(bottom: VerticalComponentPadding, left: kDefaultPadding),
            width: size.height * kVCardWidthRatio,
            height: size.height * kVCardHeightRatio,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}

class HorizontalCardSkeleton extends StatelessWidget {
  const HorizontalCardSkeleton({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SmallTitleSkeleton(),
        const SmallTitleSkeleton(),
        const SmallTitleSkeleton(),
        Container(
            width: kCardWidth,
            height: kCardHeight,
            margin: const EdgeInsets.only(right: 15),
            child: Stack(children: [
              Positioned(
                  top: 0,
                  left: 0,
                  width: kCardWidth,
                  height: kCardHeight,
                    child: Container(
                      width: kCardWidth,
                      height: kCardHeight,
                      color: Colors.white70,
                    ),
                  ),
              Positioned(
                bottom: kCardHeight * 0.05,
                width: kCardWidth,
                left: 0,
                child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Container(
                      padding: const EdgeInsets.only(left: kDefaultCardPadding),
                      margin: const EdgeInsets.only(right: kDefaultCardPadding),
                      width: kCardWidth * 0.7,
                      color: Colors.white70,
                  ),
                ]),
              )
            ])),
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
      margin: const EdgeInsets.only(bottom: kDefaultPadding),
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
        padding: const EdgeInsets.only(left: kDefaultPadding , bottom: kDefaultPadding),
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
        padding: const EdgeInsets.only(top: kDefaultPadding * 4 , bottom: kDefaultPadding, left: kDefaultPadding),
        child: Container(
          height: 40,
          width: 150,
          color: Colors.white70,
        )
    );
  }
}