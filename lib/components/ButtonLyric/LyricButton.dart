import 'package:apple_music/components/AudioController/AudioManager.dart';
import 'package:apple_music/components/ButtonLyric/LyricButtonConstant.dart';
import 'package:apple_music/components/ButtonLyric/LyricButtonIcon.dart';
import 'package:apple_music/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:apple_music/components/AudioController/AudioStates.dart';

class LyricButton extends StatefulWidget{
  @override
  State<LyricButton> createState() => _LyricButtonState();
}

class _LyricButtonState extends State<LyricButton> {
  final _audioManager = getIt<AudioManager>();
  final lyricButton = iconNames["LyricButton"];
  final onClickLyricButton = iconNames["OnClickLyricButton"];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return
      ValueListenableBuilder<ChildWindowState>(
        valueListenable: _audioManager.childWindowNotifier,
        builder: (_,value,__) {
          if(value != ChildWindowState.lyrics){
            return IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: SvgPicture.asset(lyricButton),
              iconSize: LYRIC_BUTTON_SIZE,
              onPressed: _audioManager.lyricWindow,
            );
          }
          else {
            return IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: SvgPicture.asset(onClickLyricButton),
                iconSize: LYRIC_BUTTON_SIZE,
                onPressed: _audioManager.songWindow,
            );
          }
        }
      );
  }
}