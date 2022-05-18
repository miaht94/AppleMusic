import 'package:apple_music/components/SquareCard/RencentlyViewed.dart';
import 'package:apple_music/constant.dart';
import 'package:apple_music/services/http_util.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../components/SongMenu/SongMenu.dart';
import '../components/TitleComponent/PageTitleBox.dart';
import '../models/CredentialModel.dart';


class LibraryPage extends StatelessWidget {
  const LibraryPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Container(
        // padding: const EdgeInsets.only(left: kDefaultPadding),
        child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              PageTitleBox(title: "Thư Viện"),
              Container(
                padding: EdgeInsets.only(left: kDefaultPadding, bottom: kDefaultPadding),
                child: SongMenu(),
              ),
              Container(
                padding: EdgeInsets.only(left: kDefaultPadding),
                child: RecentlyViewed(playlistlist: HttpUtil().getMyPlaylists(app_token:GetIt.I.get<CredentialModelNotifier>().value.appToken)),
              ),
              SizedBox(height: 140)
            ]
        ),
      );
  }
}
