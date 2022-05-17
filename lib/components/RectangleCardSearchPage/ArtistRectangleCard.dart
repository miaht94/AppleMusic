import 'package:apple_music/constant.dart';
import 'package:apple_music/models_refactor/ArtistModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:skeletons/skeletons.dart';

// ignore: must_be_immutable
class ArtistRectangleCard extends StatelessWidget {
  ArtistRectangleCard({Key? key, required this.artistModel, this.onTapArtistCard, this.onTapArtistCardMoreButton}) : super(key: key);
  ArtistModel artistModel;
  // ignore: inference_failure_on_function_return_type
  Function(ArtistModel)? onTapArtistCard;
  // ignore: inference_failure_on_function_return_type
  Function(ArtistModel)? onTapArtistCardMoreButton;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Material(
      child: InkWell(
        onTap: () {
          if (onTapArtistCard != null) {
            onTapArtistCard!(artistModel);
          }
        },
        child: Container(
            width: screenSize.width,
            margin: const EdgeInsets.only(bottom: kDefaultPadding),
            child: Row(children: [
              Container(
                // clipBehavior: Clip.antiAlias,
                width: 60,
                height: 60,
                margin: const EdgeInsets.only(right: kDefaultPadding),
                child: CachedNetworkImage(
                  imageUrl: artistModel.artist_image_url, 
                  imageBuilder:(context, imageProvider) => 
                    CircleAvatar(backgroundImage: imageProvider),
                  placeholder: (context, url) => const SkeletonAvatar(style: SkeletonAvatarStyle(shape: BoxShape.circle))
                  ),
                   
                  
                // child: CircleAvatar(backgroundImage : Image.network(albumRectangleCardModel.artURL,).image)
                ),
              Expanded(
                child: Container(
                  height: 60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    const Divider(
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
                            Text(artistModel.artist_name, style: const TextStyle(fontSize: 16, color: Colors.black)),
                            const Text('Ca sĩ', style: TextStyle(fontSize: 13, color: Colors.grey),)
                                              ],),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Material(
                                type: MaterialType.transparency,
                                child: Ink(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(100),
                                    child: const Icon(SFSymbols.ellipsis, size: 18),
                                    onTap: () {
                                      if (onTapArtistCardMoreButton != null) {
                                        onTapArtistCardMoreButton!(artistModel);
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
              // Text("ahc")
              
            ],
            ),
          ),
      ),
    );
  }
  
}