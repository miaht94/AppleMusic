import 'package:apple_music/components/AudioController/AudioPageRouteManager.dart';
import 'package:flutter/material.dart';
import 'package:apple_music/constant.dart';
import 'package:get_it/get_it.dart';
import '../../models/ArtistViewModel.dart';
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
        margin: EdgeInsets.only(left: kDefaultPadding),
        child: InkWell(
          onTap: () => {
            
              Navigator.push(
                GetIt.I.get<AudioPageRouteManager>().getMainContext(),
                MaterialPageRoute(
                  builder: (context) => ArtistView(artistViewModel: ArtistViewModel.getArtist(this.artist)),
                ),
              )
          },
          child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Card(
                margin: EdgeInsets.zero,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: CircleBorder(
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