import 'package:apple_music/constant.dart';
import 'package:flutter/material.dart';
import '../components/SongMenu/SongMenu.dart';
import '../components/SquareCard/RencentlyViewed.dart';
import '../components/TitleComponent/PageTitleBox.dart';


class LibraryPage extends StatelessWidget {
  const LibraryPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            PageTitleBox(title: "Thư Viện"),
            Container(
              padding: EdgeInsets.only(left: kDefaultPadding, bottom: kDefaultPadding),
              child: SongMenu(),
            ),
            Container(
              child: RencentlyViewed(),
            )
          ]
      );
  }
}
