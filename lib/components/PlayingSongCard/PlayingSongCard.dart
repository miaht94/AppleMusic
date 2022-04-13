import 'package:apple_music/components/PlayingSongCard/PlayingSongCardConstant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

class PlayingSongCard extends StatefulWidget {
  PlayingSongCard({Key? key, required this.songName,
    required this.artistName,
    required this.artURL,
    this.size,
    this.imageSize,
    this.songNameFontSize,
    this.artistFontSize,
    this.songNameColor,
    this.hasArtWork,
  }) : super(key: key);
  final String songName;
  final String artistName;
  final String artURL;
  double ? size = 52;
  double ? imageSize = 37;
  double ? songNameFontSize = 14;
  double ? artistFontSize = 11;
  Color ? songNameColor = Colors.grey;
  bool ? hasArtWork = true;

  @override
  _PlayingSongCardState createState() => _PlayingSongCardState();
}

class _PlayingSongCardState extends State<PlayingSongCard> {

  @override
  Widget build(BuildContext context) {
    return
      Container(
            height: widget.size,
            child: Row(
                children: <Widget>[
                  _buildArtWork(),
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: PLAYING_PADDING),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.songName,
                                style: TextStyle(
                                    fontSize: widget.songNameFontSize,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white70,
                                )),
                            Text(widget.artistName,
                                style: TextStyle(
                                    fontSize: widget.artistFontSize,
                                    color: Colors.grey,
                                )),
                          ],
                        ),
                      )
                  ),
                  const Expanded(
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Icon(SFSymbols.ellipsis,
                                size:18,
                                color: Colors.grey,)
                          )
                      )
                  ),
                ]
            )
    );
  }

  Widget _buildArtWork(){
    if(widget.hasArtWork != null && widget.hasArtWork! == true){
      return
        Container(
            height:  widget.imageSize,
            width: widget.imageSize,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image.network(
                widget.artURL,
                fit: BoxFit.fill,
              ),
            )
        );
    } else{
      return SizedBox(
      );
    }
  }
}

