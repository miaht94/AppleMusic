import 'package:flutter/material.dart';
import 'package:apple_music/constant.dart';
import 'HScrollCircleCard.dart';
import '../TitleComponent/SeeAllButton.dart';
import '../TitleComponent/BoldTitle.dart';

class HScrollCircleCardWithText extends StatelessWidget{
  HScrollCircleCardWithText({Key? key,
    required this.title,
  }): super(key: key);

  final String title;
  final listItem = [
    {
      "imageUrl": "https://is3-ssl.mzstatic.com/image/thumb/Music126/v4/94/95/85/94958532-4e64-f3b3-84b2-f4d207e31c85/21UM1IM25046.rgb.jpg/486x486bb-60.jpg",
      "artist": "Taylor Swift",
    },
    {
      "imageUrl": "https://is2-ssl.mzstatic.com/image/thumb/Music126/v4/2f/22/a9/2f22a9a6-5af1-5846-a44e-ba016724ed69/21UM1IM58860.rgb.jpg/486x486bb.webp",
      "artist": "The Weeknd",
    },
    {
      "imageUrl": "https://is5-ssl.mzstatic.com/image/thumb/Features126/v4/5e/f8/5b/5ef85b6d-1edd-9a96-0a70-fd300b56c4a8/mza_10642029259611882840.png/110x110sr.webp",
      "artist": "Olivia Rodrigo",
    },
    {
      "imageUrl": "https://is4-ssl.mzstatic.com/image/thumb/Music115/v4/5a/60/84/5a60849d-4fcd-13a6-0715-4621186bab23/pr_source.png/220x220sr-60.jpg",
      "artist": "Ed Sheeran",
    },
    {
      "imageUrl": "https://is4-ssl.mzstatic.com/image/thumb/Music125/v4/97/ef/7c/97ef7c7a-d8b9-d550-cab9-97b6cacaef33/pr_source.png/220x220sr-60.jpg",
      "artist": "LISA",
    },
    {
      "imageUrl": "https://is4-ssl.mzstatic.com/image/thumb/Music126/v4/a8/8b/e5/a88be50d-1248-e484-cb30-0a524524d57a/pr_source.png/380x380cc-60.jpg",
      "artist": "Le\$",
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
                padding: EdgeInsets.only(left: kDefaultPadding * 1.5),
                child: BoldTitle(title: title),
              ),
              Padding(
                padding: EdgeInsets.only(right: kDefaultPadding),
                child: SeeAllButton(),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 186,
              child: HScrollCircleCard(listItem: listItem),
            ),
          ),
        ],
      );
  }
}
