import 'package:apple_music/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'SongMenuConstant.dart';
import 'SongMenuIcon.dart';

class SongMenuItem extends StatelessWidget{
  SongMenuItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap
  }): super(key: key);

  final IconData icon;
  final String title;
  final String leftArrowIcon = iconNames['LeftArrowIcon'];
  final Null Function() onTap;

  @override
  Widget build(BuildContext context){
    final size = MediaQuery.of(context).size;
    // ignore: non_constant_identifier_names
    final WIDTH = size.width - kDefaultPadding;
    return
      InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.only(bottom: kDefaultPadding),
              child: Column(
                children: [
                  Padding(
                    padding:const EdgeInsets.only(bottom: kDefaultPadding),
                    child: Container(
                      height: 1,
                      width: WIDTH,
                      color:kHeadlineColor,
                    )
                  ),
                  Container(
                    height: size.height * SONG_MENU_ITEM_HEIGHT_RATIO,
                    width: WIDTH,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                  child: Icon(icon, color: Colors.red),
                              ),
                              const WidgetSpan(
                                  child: SizedBox(
                                    width: kDefaultPadding,
                                  )
                              )
                              ,
                              TextSpan(
                                text: title,
                                style: const TextStyle(
                                  fontFamily: kFontFamily,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: SONG_MENU_ITEM_TITLE_FONT_SIZE,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: kDefaultPadding),
                          child: SvgPicture.asset(leftArrowIcon),
                        )
                      ],
                    ),
                  ),
                ],
              ),
          ),
      );
  }
}