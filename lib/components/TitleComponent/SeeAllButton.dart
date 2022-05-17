import 'package:apple_music/constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'TitleComponentConstant.dart';

class SeeAllButton extends StatelessWidget {
  const SeeAllButton({Key? key}) : super(key: key);


  // ignore: always_declare_return_types, inference_failure_on_function_return_type
  onSeeAllClick(){
    if (kDebugMode) {
      print('Xem tất cả');
    }
  }

  @override
  Widget build(BuildContext context){
    return InkWell(
      onTap: onSeeAllClick,
      child: const Text(
        'Xem tất cả',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
        style: TextStyle(
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