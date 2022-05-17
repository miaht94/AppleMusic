import 'package:apple_music/constant.dart';
import 'package:flutter/material.dart';

import 'TitleComponentConstant.dart';

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
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontFamily: kFontFamily,
        color: Colors.black,
        fontWeight: FontWeight.w900,
        fontSize: FONT_SIZE_BOLD_TITLE,
        fontStyle: FontStyle.normal,
      ),
    );
  }
}