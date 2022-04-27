import 'package:apple_music/components/HorizontalCard/HorizontalCardConstant.dart';
import 'package:apple_music/constant.dart';
import 'package:apple_music/models/AlbumRectangleCardModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:skeletons/skeletons.dart';

class AlbumRectangleCard extends StatelessWidget {
  AlbumRectangleCard({
    Key ? key,
    required this.albumRectangleCardModel,
    this.onTapAlbumCard,
    this.onTapAlbumMoreButton
  }): super(key: key);
  AlbumRectangleCardModel albumRectangleCardModel;
  Function(AlbumRectangleCardModel) ? onTapAlbumCard;
  Function(AlbumRectangleCardModel) ? onTapAlbumMoreButton;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () {
          if (onTapAlbumCard != null) {
            onTapAlbumCard!(albumRectangleCardModel);
          }
        },
        child: Container(
          width: screenSize.width,
          margin: const EdgeInsets.only(bottom: kDefaultPadding),
          child: Row(children: [
            Container(
              width: 60,
              height: 60,
              margin: const EdgeInsets.only(right: kDefaultPadding),
              decoration: const BoxDecoration(
                // image: DecorationImage(
                //   image: Image.network(albumRectangleCardModel.artURL).image, 
                //   fit: BoxFit.cover
                // ),
                borderRadius: BorderRadius.all(Radius.circular(8))
              ),
              // child: CircleAvatar(backgroundImage : Image.network(albumRectangleCardModel.artURL,).image)
              child: CachedNetworkImage(
                imageUrl: albumRectangleCardModel.artURL,
                placeholder: (context, _) => SkeletonAvatar(),
                imageBuilder: (context, imageProvider) =>
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8))
                  ), ),
              ),
            ),
            Expanded(
              child: Container(
                height: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Divider(
                      height: 4,
                      thickness: 0.4,
                      indent: 10,
                      endIndent: 0,
                      color: Colors.grey,
                    ),
          
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(albumRectangleCardModel.albumName, style: TextStyle(fontSize: 16, color: Colors.black)),
                                Text("${albumRectangleCardModel.artistName} - Album", style: TextStyle(fontSize: 13, color: Colors.grey), )
                              ], ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Material(
                                type: MaterialType.transparency,
                                child: Ink(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Icon(SFSymbols.ellipsis, size: 18),
                                    onTap: () {
                                      if (onTapAlbumMoreButton != null) {
                                        onTapAlbumMoreButton!(albumRectangleCardModel);
                                      }
                                    },
                                  ),
                                )
                              )
                            )
                          )
                        ],
                      ),
                    )
          
                  ]),
              ),
            ),
          
          ], ),
        ),
      ),
    );
  }

}