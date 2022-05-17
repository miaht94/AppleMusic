import 'package:apple_music/components/AudioController/AudioManager.dart';
import 'package:apple_music/components/AudioController/AudioStates.dart';
import 'package:apple_music/components/RepeatButton/RepeatButtonConstant.dart';
import 'package:apple_music/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

class RepeatButton extends StatefulWidget{
  const RepeatButton({Key? key}) : super(key: key);


  @override
  State<RepeatButton> createState() => _RepeatButtonState();
}

class _RepeatButtonState extends State<RepeatButton> {
  final _audioManager = getIt<AudioManager>();


  @override
  Widget build(BuildContext context){

    return
      ValueListenableBuilder<RepeatState>(
          valueListenable: _audioManager.repeatNotifier,
          builder: (_,value,__) {
            return
            Container(
              height: BUTTON_SIZE * 1.1,
              width: BUTTON_SIZE * 1.2,
              margin: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                color: (value != RepeatState.noRepeat) ? ON_CLICK_BACKGROUND_COLOR : BACKGROUND_COLOR,
                borderRadius: const BorderRadius.all(Radius.circular(BUTTON_BORDER_RADIUS)),
              ),
              child: IconButton(
                padding: const EdgeInsets.all(0),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: Icon(
                    (value == RepeatState.repeatCurrentItem) ? SFSymbols.repeat_1: SFSymbols.repeat,
                    color: (value != RepeatState.noRepeat)
                        ? ON_CLICK_REPEAT_BUTTON_COLOR
                        : REPEAT_BUTTON_COLOR ),
                iconSize: BUTTON_SIZE,
                onPressed: _audioManager.repeat,
              ),
            );
          }
      );
  }
}