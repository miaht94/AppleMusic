import 'package:flutter/material.dart';
import 'PageTitle.dart';
import 'TitleComponentConstant.dart';
import 'package:apple_music/constant.dart';

class PageTitleBox extends StatelessWidget {
  const PageTitleBox({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * PAGE_TITLE_BOX_HEIGHT_RATIO,
      padding: EdgeInsets.all(kDefaultPadding),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: PageTitle(title: title),
      )
    );
  }
}