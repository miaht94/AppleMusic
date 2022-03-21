import 'package:flutter/material.dart';
import 'package:apple_music/constant.dart';

class CircleCard extends StatelessWidget{
  const CircleCard({Key? key,
    required this.imageUrl,
    required this.artist,
    required this.id,

  }): super(key: key);

  final String imageUrl;
  final String artist;
  final int id;

  onCardTap() {
    print("ID: ${id}");
  }

  @override
  Widget build (BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        width: size.width * CIRCLE_CARD_WIDTH_RATIO,
        height: size.height * CIRCLE_CARD_HEIGHT_RATIO,
        padding: EdgeInsets.only(left: kDefaultPadding),
        child: InkWell(
          onTap: onCardTap,
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              Card(
                margin: EdgeInsets.zero,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: CircleBorder(
                ),
                child: Container(
                  height: size.width * CIRCLE_CARD_WIDTH_RATIO,
                  width: size.width * CIRCLE_CARD_WIDTH_RATIO,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                )
              ),
              Text(
                artist,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: kFontFamily,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: CIRCLE_CARD_FONT_SIZE_TEXT,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}