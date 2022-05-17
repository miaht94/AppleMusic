import 'package:apple_music/constant.dart';
import 'package:apple_music/services/http_util.dart';
import 'package:flutter/material.dart';

import '../../pages/ArtistPage.dart';
import 'HScrollCircleConstant.dart';

class CircleCard extends StatelessWidget{
  const CircleCard({Key? key,
    required this.imageUrl,
    required this.artist,
    required this.id,

  }): super(key: key);

  final String imageUrl;
  final String artist;
  final int id;

  // onCardTap(context) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => ArtistView(artistViewModel: ArtistViewModel.getArtist(this.artist)),
  //     ),
  //   );
  // }

  @override
  Widget build (BuildContext context) {
    final size = MediaQuery.of(context).size;
    final WIDTH = size.height * CIRCLE_IMAGE_RATIO;
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        width: WIDTH,
        height: size.height * CIRCLE_CARD_HEIGHT_RATIO,
        margin: const EdgeInsets.only(left: kDefaultPadding),
        child: InkWell(
          onTap: () => {
              Navigator.push(
                context,
                // ignore: inference_failure_on_instance_creation
                MaterialPageRoute(
                  builder: (context) => ArtistView(artistViewModel: HttpUtil().fetchArtistModel(artist_name:artist)),
                ),
              )
          },
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Card(
                margin: EdgeInsets.zero,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: const CircleBorder(
                ),
                child: Container(
                  height: WIDTH,
                  width: WIDTH,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                )
              ),
              Text(
                artist,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: kFontFamily,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: CIRCLE_CARD_FONT_SIZE_TEXT,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}