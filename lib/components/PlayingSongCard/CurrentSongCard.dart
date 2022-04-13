import 'package:apple_music/components/AudioController/AudioManager.dart';
import 'package:apple_music/components/PlayingSongCard/PlayingSongCard.dart';
import 'package:apple_music/services/service_locator.dart';
import 'package:flutter/material.dart';

class CurrentSongCard extends StatefulWidget{

  @override
  State<CurrentSongCard> createState() => _CurrentSongCardState();
}

class _CurrentSongCardState extends State<CurrentSongCard> {

  final _audioManager = getIt<AudioManager>();

  @override
  Widget build(BuildContext context) {
    return
        ValueListenableBuilder<AudioMetadata>(
          valueListenable: _audioManager.currentSongNotifier,
          builder: (_,currentSong,__){
            if(currentSong.artwork != ""){
              return PlayingSongCard(
                songName: currentSong.title,
                artistName: currentSong.artist,
                artURL: currentSong.artwork,
                size: 60,
                imageSize: 60,
                songNameFontSize: 20,
                artistFontSize: 15,
                songNameColor: Color.fromRGBO(255, 255, 255, 0.95),
              );
            } else
              return
                SizedBox();
          },
      );
  }
}