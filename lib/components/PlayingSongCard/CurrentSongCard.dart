import 'package:apple_music/components/AudioController/AudioManager.dart';
import 'package:apple_music/components/ContextMenu/ContextMenuManager.dart';
import 'package:apple_music/components/ContextMenu/SongContextMenu.dart';
import 'package:apple_music/components/PlayingSongCard/PlayingSongCard.dart';
import 'package:apple_music/components/PlayingSongCard/PlayingSongCardConstant.dart';
import 'package:apple_music/models/SongCardInPlaylistModel.dart';
import 'package:apple_music/models_refactor/SongModel.dart';
import 'package:apple_music/services/service_locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:apple_music/components/AudioController/AudioStates.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:get_it/get_it.dart';

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

  void onContextMenuPress (SongUrlModel currentSong){
    GetIt.I.get<ContextMenuManager>().insertOverlay(
        SongContextMenu(
        songModel: currentSong.song
    )
    );
  }

  Widget _buildCard(){
    return
      ValueListenableBuilder<SongUrlModel?>(
        valueListenable: _audioManager.currentSongNotifier,
        builder: (_,currentSong,__){
          if(currentSong != null){
            return Stack(
              children: [
                PlayingSongCard(
                  songName: currentSong.song.song_name,
                  artistName: currentSong.song.artist.artist_name,
                  artURL: currentSong.song.album.art_url,
                  size: 60,
                  imageSize: 60,
                  songNameFontSize: 20,
                  artistFontSize: 15,
                  songNameColor: Color.fromRGBO(255, 255, 255, 0.95),
                  hasArtWork: false,
                ),
                Positioned(
                  right: 15,
                  height: 27,
                  top: 15,
                  child: 
                  Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      radius: 100,
                      onTap: (){
                        onContextMenuPress(currentSong);
                      },
                      child: Icon(
                          SFSymbols.ellipsis_vertical,
                          color: Colors.white,
                          size:22,
                        )
                      ),
                    )
                  
                  ,)
              ],
            );
          } else
            return
              SizedBox();
        },
      );
  }
}