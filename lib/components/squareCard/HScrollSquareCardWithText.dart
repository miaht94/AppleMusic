import 'package:flutter/material.dart';
import 'package:apple_music/constant.dart';
import 'HScrollSquareCard.dart';
import '../TitleComponent/SeeAllButton.dart';
import '../TitleComponent/BoldTitle.dart';

class HScrollSquareCardWithText extends StatelessWidget{
  HScrollSquareCardWithText({Key? key,
    required this.title,
  }): super(key: key);

  final String title;
  final listItem = [
    {
      "imageUrl": "https://upload.wikimedia.org/wikipedia/vi/c/cd/Taylor_Swift_-_Lover.png",
      "name": "Lover",
      "author": "Taylor Swift",
    },
    {
      "imageUrl": "https://avatar-ex-swe.nixcdn.com/song/2020/09/15/3/7/8/3/1600184151280_640.jpg",
      "name": "At my worst",
      "author": "Pink Sweat\$"
    },
    {
      "imageUrl": "https://images.genius.com/d8a68a3aac2ab79bd4d4c5ee33fd69fa.1000x1000x1.png",
      "name": "Boulevard Of Broken Dreams",
      "author": "Green Day"
    },
    {
      "imageUrl": "https://cdn-profiles.tunein.com/s242677/images/logog.jpg?t=2",
      "name": "Hit Mới Hôm Nay",
      "author": "Các Bản Hit Apple Music"
    },
    {
      "imageUrl": "https://upload.wikimedia.org/wikipedia/vi/c/cd/Taylor_Swift_-_Lover.png",
      "name": "Lover",
      "author": "Taylor Swift",
    },
    {
      "imageUrl": "https://avatar-ex-swe.nixcdn.com/song/2020/09/15/3/7/8/3/1600184151280_640.jpg",
      "name": "At my worst",
      "author": "Pink Sweat\$"
    },
    {
      "imageUrl": "https://images.genius.com/d8a68a3aac2ab79bd4d4c5ee33fd69fa.1000x1000x1.png",
      "name": "Boulevard Of Broken Dreams",
      "author": "Green Day"
    },
    {
      "imageUrl": "https://cdn-profiles.tunein.com/s242677/images/logog.jpg?t=2",
      "name": "Hit Mới Hôm Nay",
      "author": "Các Bản Hit Apple Music"
    },

  ];

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
              height: 186,
              child: HScrollSquareCard(listItem: listItem),
            ),
          ),
        ],
      );
  }
}
