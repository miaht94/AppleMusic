import 'package:apple_music/components/SongCardInPlaylist/HScroll_CardList.dart';
import 'package:apple_music/constant.dart';
import 'package:apple_music/models_refactor/SongModel.dart';
import 'package:flutter/material.dart';

import '../TitleComponent/BoldTitle.dart';
import '../TitleComponent/SeeAllButton.dart';

class HScrollCardListWithText extends StatelessWidget{
  const HScrollCardListWithText({Key? key,
    required this.title,
    required this.cards
  }): super(key: key);

  final String title;
  final List<SongModel> cards;

  @override
  Widget build(BuildContext context) {
    return
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: kDefaultPadding * 2),
                child: BoldTitle(title: title),
              ),
              Padding(
                padding: const EdgeInsets.only(right: kDefaultPadding * 2),
                child: SeeAllButton(typeOfList: TypeOfList.song, list: cards,),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 230,
              child: HScrollCardList(cards: cards),
            ),
          ),
        ],
      );
  }
}
