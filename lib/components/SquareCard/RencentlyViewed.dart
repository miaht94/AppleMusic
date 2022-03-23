import 'package:flutter/material.dart';
import 'package:apple_music/constant.dart';
import 'SquareCard.dart';
import 'HScrollSquareConstant.dart';

class RencentlyViewed extends StatelessWidget{

  final _listItem = [
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
  ];

  @override
  Widget build(BuildContext context){
    final size = MediaQuery.of(context).size;
    final WIDTH = size.width * RENCENTLY_VIEWED_WIDTH_RATIO;
    return
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: kDefaultPadding * 2,
            children: _listItem.map((item) => SquareCard(
              imageUrl: item['imageUrl']!,
              name: item['name']!,
              artist: item['author']!,
              id: _listItem.indexOf(item),
              width: WIDTH,
              )
            ).toList(),
        );
  }
}