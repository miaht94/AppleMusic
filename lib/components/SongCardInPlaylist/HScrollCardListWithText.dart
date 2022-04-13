import 'package:apple_music/components/SongCardInPlaylist/HScroll_CardList.dart';
import 'package:flutter/material.dart';
import 'package:apple_music/constant.dart';
import '../TitleComponent/SeeAllButton.dart';
import '../TitleComponent/BoldTitle.dart';

class HScrollCardListWithText extends StatelessWidget{
  HScrollCardListWithText({Key? key,
    required this.title,

  }): super(key: key);

  final String title;
  

  @override
  Widget build(BuildContext context) {
    return
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: kDefaultPadding * 2),
                child: BoldTitle(title: title),
              ),
              Padding(
                padding: EdgeInsets.only(right: kDefaultPadding * 2),
                child: SeeAllButton(),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 230,
              child: HScrollCardList(),
            ),
          ),
        ],
      );
  }
}
