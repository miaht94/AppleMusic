import 'package:apple_music/constant.dart';
import 'package:apple_music/models/PlaylistRectangleCardModel.dart';
import 'package:apple_music/models_refactor/PlaylistModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:skeletons/skeletons.dart';

class PlaylistRectangleCard extends StatelessWidget {
  PlaylistRectangleCard({Key? key, required this.playlistModel, this.onTapPlaylistCard, this.onTapPlaylistMoreButton, this.renderMoreButton, this.renderDivider}) : super(key: key);
  PlaylistModel playlistModel;
  bool? renderMoreButton;
  bool? renderDivider;
  Function(PlaylistModel)? onTapPlaylistCard;
  Function(PlaylistModel)? onTapPlaylistMoreButton;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () {
          if (onTapPlaylistCard != null) {
            onTapPlaylistCard!(playlistModel);
          }
        },
        child: Container(
            width: screenSize.width,
            // margin: EdgeInsets.only(bottom: kDefaultPadding),
            child: Row(children: [
              Container(
                width: 60,
                height: 60,
                margin: EdgeInsets.only(right: kDefaultPadding),
                decoration: BoxDecoration(
                  // image: DecorationImage(
                  //   image: Image.network(playlistRectangleCardModel.artURL).image, 
                  //   fit: BoxFit.cover
                  // ),
                  borderRadius: BorderRadius.all(Radius.circular(8))
                ),
                child: CachedNetworkImage(
                  imageUrl: playlistModel.art_url,
                  fit: BoxFit.cover,
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
                ),),
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
                    if (renderDivider == null || renderDivider!)
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
                            Text(playlistModel.playlist_name, style: TextStyle(fontSize: 16, color: Colors.black)),
                            Text("Playlist", style: TextStyle(fontSize: 13, color: Colors.grey),)
                                              ],),
                          ),
                          if (renderMoreButton?? true) 
                          Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Material(
                                
                                  child: Ink(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle
                                    ),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Icon(SFSymbols.ellipsis, size: 18),
                                      onTap: () {
                                        if (onTapPlaylistMoreButton != null) {
                                          onTapPlaylistMoreButton!(playlistModel);
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
              
            ],
            ),
          ),
      ),
    );
  }

}