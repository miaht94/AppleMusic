import 'package:apple_music/constant.dart';
import 'package:apple_music/models/HScrollSquareModel.dart';
import 'package:flutter/material.dart';

import '../TitleComponent/BoldTitle.dart';
import '../TitleComponent/SeeAllButton.dart';
import 'HScrollSquareCard.dart';
import 'HScrollSquareConstant.dart';

class HScrollSquareCardWithText extends StatelessWidget{
  const HScrollSquareCardWithText({Key? key,
    required this.title,
    required this.cards
  }): super(key: key);

  final String title;
  final List<HScrollSquareCardModel> cards;

  @override
  Widget build(BuildContext context){
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
            child: SizedBox(
              width: size.width,
              height: size.height * SQUARE_CARD_HEIGHT_RATIO,
              child: HScrollSquareCard(listItem: cards),
            ),
          ),
        ],
      );
  }
}

// = [
// {
// "imageUrl": "https://upload.wikimedia.org/wikipedia/vi/c/cd/Taylor_Swift_-_Lover.png",
// "name": "Lover",
// "author": "Taylor Swift",
// },
// {
// "imageUrl": "https://avatar-ex-swe.nixcdn.com/song/2020/09/15/3/7/8/3/1600184151280_640.jpg",
// "name": "At my worst",
// "author": "Pink Sweat\$"
// },
// {
// "imageUrl": "https://images.genius.com/d8a68a3aac2ab79bd4d4c5ee33fd69fa.1000x1000x1.png",
// "name": "Boulevard Of Broken Dreams",
// "author": "Green Day"
// },
// {
// "imageUrl": "https://cdn-profiles.tunein.com/s242677/images/logog.jpg?t=2",
// "name": "Hit Mới Hôm Nay",
// "author": "Các Bản Hit Apple Music"
// },
// {
// "imageUrl": "https://upload.wikimedia.org/wikipedia/vi/c/cd/Taylor_Swift_-_Lover.png",
// "name": "Lover",
// "author": "Taylor Swift",
// },
// {
// "imageUrl": "https://avatar-ex-swe.nixcdn.com/song/2020/09/15/3/7/8/3/1600184151280_640.jpg",
// "name": "At my worst",
// "author": "Pink Sweat\$"
// },
// {
// "imageUrl": "https://images.genius.com/d8a68a3aac2ab79bd4d4c5ee33fd69fa.1000x1000x1.png",
// "name": "Boulevard Of Broken Dreams",
// "author": "Green Day"
// },
// {
// "imageUrl": "https://cdn-profiles.tunein.com/s242677/images/logog.jpg?t=2",
// "name": "Hit Mới Hôm Nay",
// "author": "Các Bản Hit Apple Music"
// },

// ];
