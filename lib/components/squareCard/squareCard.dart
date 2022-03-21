import 'package:flutter/material.dart';
import 'package:apple_music/constant.dart';

class SquareCard extends StatelessWidget{
  const SquareCard({Key? key,
    required this.imageUrl,
    required this.name,
    required this.artist,
    required this.id,

  }): super(key: key);

  final String imageUrl;
  final String name;
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
        width: size.width * SQUARE_CARD_WIDTH_RATIO,
        height: size.height * SQUARE_CARD_HEIGHT_RATIO,
        padding: EdgeInsets.only(left: kDefaultPadding),
        child: InkWell(
          onTap: onCardTap,
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              Card(
                margin: EdgeInsets.zero,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(SQUARE_CARD_RADIUS),
                ),
                child: Container(
                  height: size.width * SQUARE_CARD_WIDTH_RATIO,
                  width: size.width * SQUARE_CARD_WIDTH_RATIO,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                )
              ),
              Text(
                name,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontFamily: kFontFamily,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: SQUARE_CARD_FONT_SIZE_TEXT,
                  fontStyle: FontStyle.normal,
                ),
              ),
              Text(
                artist,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontFamily: kFontFamily,
                  color: Color(SQUARE_CARD_GREY),
                  fontWeight: FontWeight.w400,
                  fontSize: SQUARE_CARD_FONT_SIZE_TEXT,
                  fontStyle: FontStyle.normal,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}