import 'package:flutter/material.dart';
import 'package:apple_music/constant.dart';
import 'TitleComponentConstant.dart';

class SeeAllButton extends StatelessWidget {

  onSeeAllClick(){
    print("Xem tất cả");
  }

  @override
  Widget build(BuildContext context){
    return InkWell(
      onTap: onSeeAllClick,
      child: Text(
        "Xem tất cả",
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontFamily: kFontFamily,
          color: Color(SEE_ALL_COLOR_TEXT),
          fontWeight: FontWeight.w400,
          fontSize: SEE_ALL_SIZE,
          fontStyle: FontStyle.normal,
        ),
      ),
    );
  }
}