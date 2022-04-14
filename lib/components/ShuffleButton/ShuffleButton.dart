import 'package:apple_music/components/AudioController/AudioManager.dart';
import 'package:apple_music/components/ShuffleButton/ShuffleButtonConstant.dart';
import 'package:apple_music/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

class ShuffleButton extends StatefulWidget{

  @override
  State<ShuffleButton> createState() => _ShuffleButtonState();
}

class _ShuffleButtonState extends State<ShuffleButton> {
  final _audioManager = getIt<AudioManager>();


  Widget build(BuildContext context){
    var size = MediaQuery.of(context).size;

    return
      ValueListenableBuilder<bool>(
          valueListenable: _audioManager.isShuffleNotifier,
          builder: (_,value,__) {
            return
            Container(
              height: BUTTON_SIZE * 1.1,
              width: BUTTON_SIZE * 1.2,
              child: IconButton(
                padding: EdgeInsets.all(0.0),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: Icon(SFSymbols.shuffle,
                    color: (value)
                        ? ON_CLICK_SHUFFLE_BUTTON_COLOR
                        : SHUFFLE_BUTTON_COLOR ),
                iconSize: BUTTON_SIZE,
                onPressed: _audioManager.shuffle,
              ),
              decoration: BoxDecoration(
                color: (value) ? ON_CLICK_BACKGROUND_COLOR : BACKGROUND_COLOR,
                borderRadius: BorderRadius.all(Radius.circular(BUTTON_BORDER_RADIUS)),
              ),
            );
          }
      );
  }
}