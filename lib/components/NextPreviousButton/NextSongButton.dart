import 'package:apple_music/components/AudioController/AudioManager.dart';
import 'package:apple_music/components/NextPreviousButton/NextPreviousConstant.dart';
import 'package:apple_music/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

class NextSongButton extends StatefulWidget{
  NextSongButton({Key? key, this.buttonSize, this.buttonColor}) : super(key: key);
  Color? buttonColor;
  double? buttonSize = BUTTON_SIZE;
  @override
  State<NextSongButton> createState() => _NextSongButtonState();
}

class _NextSongButtonState extends State<NextSongButton> {
  final _audioManager = getIt<AudioManager>();


  Widget build(BuildContext context){
    var size = MediaQuery.of(context).size;

    return
      ValueListenableBuilder<bool>(
          valueListenable: _audioManager.isLastSongNotifier,
          builder: (_,value,__) {
            return
              IconButton(
                padding: EdgeInsets.zero,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: Icon(SFSymbols.forward_fill,
                    color: (value)
                        ? (widget.buttonColor != null ? widget.buttonColor!.withOpacity(widget.buttonColor!.opacity * 0.2) : UNAVAILABLE_NEXT_PREVIOUS_BUTTON_COLOR)
                        : (widget.buttonColor != null ? widget.buttonColor : AVAILABLE_NEXT_PREVIOUS_BUTTON_COLOR)) ,
                iconSize: widget.buttonSize ?? BUTTON_SIZE,
                onPressed: (value) ? null : _audioManager.seekToNext,
              );
          }
      );
  }
}