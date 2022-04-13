import 'package:apple_music/components/AudioController/AudioManager.dart';
import 'package:apple_music/components/PlayingSongCard/PlayingSongCard.dart';
import 'package:apple_music/components/PlayingSongCard/PlayingSongCardConstant.dart';
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
      ValueListenableBuilder<ChildWindowState>(
        valueListenable: _audioManager.childWindowNotifier,
        builder: (_, value, __) {
          return Stack(
            children: [
              Positioned(
                top: FIRST_CURRENT_SONG_CARD_TOP,
                left: 0.0,
                right: 0.0,
                child: AnimatedOpacity(
                  opacity: (value != ChildWindowState.song)? 1.0: 0.0,
                  duration: SONG_CARD_BLUR_ANIMATION_DURATION,
                  curve: CUBIC_ANIMATION,
                  child: Container(

                    padding: EdgeInsets.only(left: FIRST_CURRENT_SONG_CARD_PADDING),
                    child: _buildCard(),
                    ),
                  ),
                ),
              Positioned(
                top: SECOND_CURRENT_SONG_CARD_TOP,
                left: 0.0,
                right: 0.0,
                child: AnimatedOpacity(
                  opacity: (value != ChildWindowState.song)? 0.0: 1.0,
                  duration: SONG_CARD_BLUR_ANIMATION_DURATION,
                  curve: CUBIC_ANIMATION,
                  child: Container(
                    child: _buildCard(),
                  ),
                ),
              ),
            ],
          );
        }
      );
  }
  Widget _buildCard(){
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
              hasArtWork: false,
            );
          } else
            return
              SizedBox();
        },
      );
  }
}