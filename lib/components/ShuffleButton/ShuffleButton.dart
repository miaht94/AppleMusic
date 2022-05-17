import 'package:apple_music/components/AudioController/AudioManager.dart';
import 'package:apple_music/components/ShuffleButton/ShuffleButtonConstant.dart';
import 'package:apple_music/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

class ShuffleButton extends StatefulWidget{
  const ShuffleButton({Key? key}) : super(key: key);


  @override
  State<ShuffleButton> createState() => _ShuffleButtonState();
}

class _ShuffleButtonState extends State<ShuffleButton> {
  final _audioManager = getIt<AudioManager>();


  @override
  Widget build(BuildContext context){

    return
      ValueListenableBuilder<bool>(
          valueListenable: _audioManager.isShuffleNotifier,
          builder: (_,value,__) {
            return
            Container(
              height: BUTTON_SIZE * 1.1,
              width: BUTTON_SIZE * 1.2,
              decoration: BoxDecoration(
                color: value ? ON_CLICK_BACKGROUND_COLOR : BACKGROUND_COLOR,
                borderRadius: const BorderRadius.all(Radius.circular(BUTTON_BORDER_RADIUS)),
              ),
              child: IconButton(
                padding: const EdgeInsets.all(0),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: Icon(SFSymbols.shuffle,
                    color: value
                        ? ON_CLICK_SHUFFLE_BUTTON_COLOR
                        : SHUFFLE_BUTTON_COLOR ),
                iconSize: BUTTON_SIZE,
                onPressed: _audioManager.shuffle,
              ),
            );
          }
      );
  }
}