import 'package:apple_music/components/AudioController/AudioManager.dart';
import 'package:apple_music/components/AudioController/AudioStates.dart';
import 'package:apple_music/components/PlayingSongCard/PlayingSongCardConstant.dart';
import 'package:apple_music/models_refactor/SongModel.dart';
import 'package:apple_music/services/service_locator.dart';
import 'package:flutter/material.dart';

class CurrentArtWork extends StatefulWidget{
  const CurrentArtWork({Key? key}) : super(key: key);


  @override
  State<CurrentArtWork> createState() => _CurrentArtWorkState();
}

class _CurrentArtWorkState extends State<CurrentArtWork> {

  final _audioManager = getIt<AudioManager>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return
      ValueListenableBuilder<ChildWindowState>(
          valueListenable: _audioManager.childWindowNotifier,
          builder: (_, value, __) {
            return AnimatedPositioned(
              top: (value != ChildWindowState.song) ? FIRST_CURRENT_SONG_CARD_TOP : size.height / 8,
              left: (value != ChildWindowState.song) ? 0.0 : size.width / 30,
              height: (value != ChildWindowState.song) ? CURRENT_ARTWORK_SIZE : size.width / 1.2,
              duration: ARTWORK_TRANSITION_ANIMATION_DURATION,
              curve: CUBIC_ANIMATION,
              child: _buildWorkArt()
            );
          }
      );
  }
  Widget _buildWorkArt(){
    return ValueListenableBuilder<SongUrlModel?>(
      valueListenable: _audioManager.currentSongNotifier,
      builder: (_,currentSong,__){
        if(currentSong != null){
          return Container(
            padding: const EdgeInsets.only(left: PLAYING_PADDING),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  currentSong.song.album.art_url,
                  fit: BoxFit.fill,
                ),
              )
          );
        } else {
          return
            const SizedBox();
        }
      },
    );
  }
}