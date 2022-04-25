import 'package:apple_music/constant.dart';
import 'package:apple_music/models/ArtistRectangleCardModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:skeletons/skeletons.dart';

class ArtistRectangleCard extends StatelessWidget {
  ArtistRectangleCard({Key? key, required this.artistRectangleCardModel, this.onTapArtistCard}) : super(key: key);
  ArtistRectangleCardModel artistRectangleCardModel;
  Function(ArtistRectangleCardModel)? onTapArtistCard;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
        width: screenSize.width,
        margin: EdgeInsets.only(bottom: kDefaultPadding),
        child: Row(children: [
          Container(
            // clipBehavior: Clip.antiAlias,
            width: 60,
            height: 60,
            margin: EdgeInsets.only(right: kDefaultPadding),
            child: CachedNetworkImage(
              imageUrl: artistRectangleCardModel.artistImageURL, 
              imageBuilder:(context, imageProvider) => 
                CircleAvatar(backgroundImage: imageProvider),
              placeholder: (context, url) => SkeletonAvatar(style: SkeletonAvatarStyle(shape: BoxShape.circle))
              ),
               
              
            // child: CircleAvatar(backgroundImage : Image.network(albumRectangleCardModel.artURL,).image)
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
                        Text(artistRectangleCardModel.artistName, style: TextStyle(fontSize: 16, color: Colors.black)),
                        Text("Ca sĩ", style: TextStyle(fontSize: 13, color: Colors.grey),)
                                          ],),
                      ),

                    ],
                  ),
                )
                
                ]),
            ),
          ),
          
        ],
        ),
      );
  }
  
}