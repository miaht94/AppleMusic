import 'package:apple_music/components/ContextMenu/ContextMenuManager.dart';
import 'package:apple_music/components/ContextMenu/SongContextMenu.dart';
import 'package:apple_music/models_refactor/SongModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:get_it/get_it.dart';

import '../AudioController/AudioManager.dart';

class SongCardInPlaylist extends StatefulWidget {
  const SongCardInPlaylist({Key? key, required this.songModel}) : super(key: key);

  final SongModel songModel;
  @override
  _SongCardInPlaylistState createState() => _SongCardInPlaylistState();
}

class _SongCardInPlaylistState extends State<SongCardInPlaylist> {

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(2),
        height: 52,
        child: InkWell(
            onTap: () => {
              GetIt.I.get<AudioManager>().addAndPlayASong(widget.songModel.id)
            },
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      widget.songModel.album.art_url,
                      height: 37,
                      width: 37,
                    ),
                  ),
                  Expanded(
                      child: Column(
                        children: [
                          const Divider(
                            height: 4,
                            thickness: 0.4,
                            indent: 10,
                            endIndent: 0,
                            color: Colors.grey,
                          ),
                          Row(
                            children: <Widget>[
                              GestureDetector(
                                child: Container(
                                    width: MediaQuery.of(context).size.width - 37-10-80,
                                    padding: const EdgeInsets.only(left:10, bottom:1),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        RichText(
                                            overflow: TextOverflow.ellipsis,
                                            text: TextSpan(text: widget.songModel.song_name,
                                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black))
                                        ),
                                        Text(widget.songModel.artist.artist_name, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                                      ],
                                    )
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: GestureDetector(
                                          onTap: () => {
                                            // print('ContextMenu')
                                            GetIt.I.get<ContextMenuManager>().insertOverlay(SongContextMenu(songModel: widget.songModel))
                                          }  ,
                                          child: const Icon(SFSymbols.ellipsis, size:18)
                                      )
                                  )
                                )
                              )
                            ],
                          ),
                        ],
                      )
                  )
                ]
            )
        )
    );
  }
}
