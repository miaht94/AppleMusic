import 'package:apple_music/components/AudioController/AudioManager.dart';
import 'package:apple_music/components/ButtonPausePlay/PausePlayButtonConstant.dart';
import 'package:apple_music/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

class PausePlayButton extends StatefulWidget{

  @override
  State<PausePlayButton> createState() => _PausePlayButtonState();
}

class _PausePlayButtonState extends State<PausePlayButton> {
  final _audioManager = getIt<AudioManager>();


  Widget build(BuildContext context){
    var size = MediaQuery.of(context).size;

    return
       ValueListenableBuilder<PausePlayButtonState>(
            valueListenable: _audioManager.pausePlayButtonNotifier,
            builder: (_,value,__) {
              switch (value){
                case PausePlayButtonState.paused:
                  return IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: const Icon(SFSymbols.play_fill,
                    color: PLAY_PAUSE_BUTTON_COLOR),
                    iconSize: BUTTON_SIZE,
                    onPressed: _audioManager.play,
                  );

                case PausePlayButtonState.playing:
                  return IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: const Icon(SFSymbols.pause_fill,
                    color: PLAY_PAUSE_BUTTON_COLOR),
                    iconSize: BUTTON_SIZE,
                    onPressed: _audioManager.pause,
                  );

                case PausePlayButtonState.loading:
                  return  Container(
                    width: BUTTON_SIZE / 1.5,
                    height: BUTTON_SIZE / 1.5,
                    child: CircularProgressIndicator(),
                  );
              }
            }
      );
  }
}