import 'package:apple_music/constant.dart';
import 'package:apple_music/models/PlaylistRectangleCardModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

class PlaylistRectangleCard extends StatelessWidget {
  PlaylistRectangleCard({Key? key, required this.playlistRectangleCardModel}) : super(key: key);
  PlaylistRectangleCardModel playlistRectangleCardModel;
  Function(PlaylistRectangleCardModel)? onTapPlaylistCard;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
        width: screenSize.width,
        margin: EdgeInsets.only(bottom: kDefaultPadding),
        child: Row(children: [
          Container(
            width: 60,
            height: 60,
            margin: EdgeInsets.only(right: kDefaultPadding),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Image.network(playlistRectangleCardModel.artURL).image, 
                fit: BoxFit.cover
              ),
              borderRadius: BorderRadius.all(Radius.circular(8))
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
                        Text(playlistRectangleCardModel.playlistName, style: TextStyle(fontSize: 16, color: Colors.black)),
                        Text("Playlist", style: TextStyle(fontSize: 13, color: Colors.grey),)
                                          ],),
                      ),
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
                                    if (onTapPlaylistCard != null) {
                                      onTapPlaylistCard!(playlistRectangleCardModel);
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
      );
  }

}