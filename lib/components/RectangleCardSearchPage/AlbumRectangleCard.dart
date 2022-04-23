import 'package:apple_music/components/HorizontalCard/HorizontalCardConstant.dart';
import 'package:apple_music/constant.dart';
import 'package:apple_music/models/AlbumRectangleCardModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

class AlbumRectangleCard extends StatelessWidget {
  AlbumRectangleCard({Key? key, required this.albumRectangleCardModel, this.onTapAlbumCard}) : super(key: key);
  AlbumRectangleCardModel albumRectangleCardModel;
  Function(AlbumRectangleCardModel)? onTapAlbumCard;
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
                image: Image.network(albumRectangleCardModel.artURL).image, 
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
                        Text(albumRectangleCardModel.albumName, style: TextStyle(fontSize: 16, color: Colors.black)),
                        Text("${albumRectangleCardModel.artistName} - Album", style: TextStyle(fontSize: 13, color: Colors.grey),)
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
                                    if (onTapAlbumCard != null) {
                                      onTapAlbumCard!(albumRectangleCardModel);
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