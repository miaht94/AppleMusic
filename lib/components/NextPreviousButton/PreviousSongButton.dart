import 'package:apple_music/components/AudioController/AudioManager.dart';
import 'package:apple_music/components/NextPreviousButton/NextPreviousConstant.dart';
import 'package:apple_music/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

class PreviousSongButton extends StatefulWidget{

  @override
  State<PreviousSongButton> createState() => _PreviousSongButtonState();
}

class _PreviousSongButtonState extends State<PreviousSongButton> {
  final _audioManager = getIt<AudioManager>();


  Widget build(BuildContext context){
    var size = MediaQuery.of(context).size;

    return
      ValueListenableBuilder<bool>(
          valueListenable: _audioManager.isFirstSongNotifier,
          builder: (_,value,__) {
            return
              IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: Icon(SFSymbols.backward_fill,
                    color: (value)
                        ? UNAVAILABLE_NEXT_PREVIOUS_BUTTON_COLOR
                        : AVAILABLE_NEXT_PREVIOUS_BUTTON_COLOR) ,
                iconSize: BUTTON_SIZE,
                onPressed: (value) ? null : _audioManager.seekToPrevious,
              );
          }
      );
  }
}