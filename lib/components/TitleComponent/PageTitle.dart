import 'package:apple_music/constant.dart';
import 'package:flutter/material.dart';

import 'TitleComponentConstant.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({
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
        fontWeight: FontWeight.w500,
        fontSize: FONT_SIZE_PAGE_TITLE,
        fontStyle: FontStyle.normal,
      ),
    );
  }
}