import 'package:apple_music/components/AudioController/AudioManager.dart';
import 'package:apple_music/components/AudioController/AudioStates.dart';
import 'package:apple_music/components/ButtonPausePlay/PausePlayButtonConstant.dart';
import 'package:apple_music/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

// ignore: must_be_immutable
class PausePlayButton extends StatefulWidget{
  PausePlayButton({Key? key, this.buttonSize, this.buttonColor}) : super(key: key);

  double? buttonSize = BUTTON_SIZE;
  Color? buttonColor = PLAY_PAUSE_BUTTON_COLOR;
  @override
  State<PausePlayButton> createState() => _PausePlayButtonState();
}

class _PausePlayButtonState extends State<PausePlayButton> with TickerProviderStateMixin{
  final _audioManager = getIt<AudioManager>();
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return
       ValueListenableBuilder<PausePlayButtonState>(
            valueListenable: _audioManager.pausePlayButtonNotifier,
            builder: (_,value,__) {
              switch (value){
                case PausePlayButtonState.paused:
                  return IconButton(
                    padding: EdgeInsets.zero,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: Icon(
                      SFSymbols.play_fill,
                      color: widget.buttonColor ?? PLAY_PAUSE_BUTTON_COLOR
                    ),
                    iconSize: widget.buttonSize ?? BUTTON_SIZE,
                    onPressed: _audioManager.play,
                  );

                case PausePlayButtonState.playing:
                  return IconButton(
                    padding: EdgeInsets.zero,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: Icon(
                      SFSymbols.pause_fill,
                      color: widget.buttonColor ?? PLAY_PAUSE_BUTTON_COLOR
                    ),
                    iconSize:  widget.buttonSize ?? BUTTON_SIZE,
                    onPressed: _audioManager.pause,
                  );

                case PausePlayButtonState.loading:
                  return  Container(
                    width: (widget.buttonSize?? BUTTON_SIZE) / 1.5,
                    height: (widget.buttonSize?? BUTTON_SIZE) / 1.5,
                    child: CircularProgressIndicator(
                  valueColor: animationController
                      .drive(ColorTween(begin: Colors.black, end: Colors.white)),
                      ),
                  );
              }
            }
      );
  }
}