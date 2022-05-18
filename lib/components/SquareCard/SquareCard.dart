import 'package:apple_music/constant.dart';
import 'package:apple_music/pages/AlbumPage.dart';
import 'package:apple_music/pages/PlaylistPage.dart';
import 'package:apple_music/services/http_util.dart';
import 'package:flutter/material.dart';

import 'HScrollSquareConstant.dart';

// ignore: must_be_immutable
class SquareCard extends StatelessWidget{
  SquareCard({Key? key,
    required this.imageUrl,
    required this.name,
    required this.artist,
    required this.id,
    required this.width,
    required this.isPlaylist,
    this.playlistModel
  }): super(key: key);

  final String imageUrl;
  final String name;
  final String artist;
  final int id;
  final double width;
  final bool isPlaylist;
  dynamic playlistModel;

  @override
  Widget build (BuildContext context) {

    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        width: width,
        margin :const EdgeInsets.only(left: kDefaultPadding),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              // ignore: inference_failure_on_instance_creation
              MaterialPageRoute(
                builder: (context) =>
                isPlaylist ?  PlaylistView(playlistModel: playlistModel) :
                AlbumView(albumViewModel:  HttpUtil().getAlbumModel(album_name: name,artist_name:  artist)),
              ),
            );
          },
          onLongPress: () {

          },
          child: ListView(
            shrinkWrap: true,
            physics:const NeverScrollableScrollPhysics(),
            children: [
              Card(
                margin: EdgeInsets.zero,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(SQUARE_CARD_RADIUS),
                ),
                child:Container(
                  height: width,
                  width: width,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                )
              ),
              const SizedBox(height:4),
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontFamily: kFontFamily,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: SQUARE_CARD_FONT_SIZE_TEXT,
                  fontStyle: FontStyle.normal,
                ),
              ),
              Text(
                artist,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontFamily: kFontFamily,
                  color: Color(SQUARE_CARD_GREY),
                  fontWeight: FontWeight.w400,
                  fontSize: SQUARE_CARD_FONT_SIZE_TEXT,
                  fontStyle: FontStyle.normal,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}