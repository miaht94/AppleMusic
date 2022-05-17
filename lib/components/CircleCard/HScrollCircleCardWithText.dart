import 'package:apple_music/constant.dart';
import 'package:apple_music/models/HScrollCircleModel.dart';
import 'package:flutter/material.dart';

import '../TitleComponent/BoldTitle.dart';
import '../TitleComponent/SeeAllButton.dart';
import 'HScrollCircleCard.dart';
import 'HScrollCircleConstant.dart';

class HScrollCircleCardWithText extends StatelessWidget{
  const HScrollCircleCardWithText({Key? key,
    required this.title,
    required this.cards,
  }): super(key: key);

  final String title;
  final List<HScrollCircleCardModel> cards;


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: kDefaultPadding * 1.5),
                child: BoldTitle(title: title),
              ),
              Padding(
                padding: const EdgeInsets.only(right: kDefaultPadding),
                child: SeeAllButton(),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: size.width,
              height: size.height * CIRCLE_CARD_HEIGHT_RATIO,
              child: HScrollCircleCard(listItem: cards),
            ),
          ),
        ],
      );
  }
}
