import 'package:apple_music/components/AudioController/AudioManager.dart';
import 'package:apple_music/components/ButtonPlaylist/PlaylistButtonConstant.dart';
import 'package:apple_music/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';


class PlaylistButton extends StatefulWidget{
  @override
  State<PlaylistButton> createState() => _PlaylistButtonState();
}

class _PlaylistButtonState extends State<PlaylistButton> {
  final _audioManager = getIt<AudioManager>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return
      ValueListenableBuilder<ChildWindowState>(
        valueListenable: _audioManager.childWindowNotifier,
        builder: (_,value,__) {
          if(value != ChildWindowState.playlist){
            return IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: const Icon(SFSymbols.list_bullet,color: PLAYLIST_BUTTON_COLOR,),
              iconSize: PLAYLIST_BUTTON_SIZE / 1.5,
              onPressed: _audioManager.playlistWindow,
            );
          }
          else {
            return IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: const Icon(SFSymbols.square_list_fill, color: PLAYLIST_BUTTON_COLOR,),
                iconSize: PLAYLIST_BUTTON_SIZE,
                onPressed: _audioManager.songWindow,
            );
          }
        }
      );
  }
}