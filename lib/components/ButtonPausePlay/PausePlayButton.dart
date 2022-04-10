import 'package:apple_music/components/AudioController/AudioManager.dart';
import 'package:apple_music/components/ButtonPausePlay/PausePlayButtonConstant.dart';
import 'package:apple_music/services/service_locator.dart';
import 'package:flutter/material.dart';

class PausePlayButton extends StatefulWidget{

  @override
  State<PausePlayButton> createState() => _PausePlayButtonState();
}

class _PausePlayButtonState extends State<PausePlayButton> {
  final _audioManager = getIt<AudioManager>();

  @override
  void dispose() {
    _audioManager.dispose();
    super.dispose();
  }

  Widget build(BuildContext context){
    var size = MediaQuery.of(context).size;

    return
      Positioned(
        bottom: 10.0,
        child: ValueListenableBuilder<PausePlayButtonState>(
            valueListenable: _audioManager.pausePlayButtonNotifier,
            builder: (_,value,__) {
              switch (value){
                case PausePlayButtonState.paused:
                  return IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: const Icon(Icons.play_arrow,
                      color: PLAY_PAUSE_BUTTON_COLOR),
                    iconSize: BUTTON_SIZE,
                    onPressed: _audioManager.play,
                  );

                case PausePlayButtonState.playing:
                  return IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: const Icon(Icons.pause,
                      color: PLAY_PAUSE_BUTTON_COLOR),
                    iconSize: BUTTON_SIZE,
                    onPressed: _audioManager.pause,
                  );

                case PausePlayButtonState.loading:
                  return  Container(
                    margin: EdgeInsets.only(bottom: BUTTON_SIZE / 4),
                    width: BUTTON_SIZE / 1.5,
                    height: BUTTON_SIZE / 1.5,
                    child: CircularProgressIndicator(),
                  );
              }
            }
        ),
      );
  }
}