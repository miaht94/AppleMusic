import 'package:flutter/material.dart';
import 'package:apple_music/constant.dart';

class BoldTitle extends StatelessWidget {
  const BoldTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.left,
      style: const TextStyle(
        fontFamily: kFontFamily,
        color: Colors.black,
        fontWeight: FontWeight.w900,
        fontSize: SQUARE_CARD_FONT_SIZE_TITLE,
        fontStyle: FontStyle.normal,
      ),
    );
  }
}