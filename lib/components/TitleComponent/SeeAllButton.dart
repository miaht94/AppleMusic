import 'package:apple_music/constant.dart';
import 'package:apple_music/pages/AlbumSubPage.dart';
import 'package:apple_music/pages/ArtistSubPage.dart';
import 'package:apple_music/pages/SongSubPage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'TitleComponentConstant.dart';

// ignore: must_be_immutable
class SeeAllButton extends StatelessWidget {
  SeeAllButton({Key? key, this.typeOfList, this.list
  }) : super(key: key);
  final TypeOfList ? typeOfList;
  dynamic list;
  // ignore: always_declare_return_types, inference_failure_on_function_return_type
  onSeeAllClick(BuildContext context){
    if (kDebugMode) {
      print('Xem tất cả');
    }
    if (typeOfList == TypeOfList.album){
      Navigator.push(
        context,
        // ignore: inference_failure_on_instance_creation
        MaterialPageRoute(
          builder: (context) => AlbumSubPage(albumlist: Future.value(list)),
        ),
      );
    } else {
      if (typeOfList == TypeOfList.artist) {
        Navigator.push(
          context,
          // ignore: inference_failure_on_instance_creation
          MaterialPageRoute(
            builder: (context) => ArtistSubPage(artistlist: Future.value(list)),
          ),
        );
      } else {
        if (typeOfList == TypeOfList.song) {
          Navigator.push(
            context,
            // ignore: inference_failure_on_instance_creation
            MaterialPageRoute(
              builder: (context) => SongSubPage(songlist: Future.value(list)),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context){
    return InkWell(
      onTap: () => onSeeAllClick(context),
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

enum TypeOfList {
  album,song,artist
}