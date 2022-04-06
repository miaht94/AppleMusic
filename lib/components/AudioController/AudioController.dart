import 'package:apple_music/models/LyricModel.dart';
import 'package:flutter/material.dart';
import '../Lyrics/ListLyrics.dart';
import '../ProgressBar/ProgessBarWidget.dart';

class AudioController extends StatefulWidget {
  AudioController({
    Key? key,
  }) : super(key: key);
  Duration currentTime = Duration(minutes: 0);
  Duration totalTime = Duration(minutes: 10);
  Duration currentPosition = Duration(minutes: 0);
  List<Lyric> lyrics = Lyrics.getLyrics();

  @override
  State<AudioController> createState() => _AudioControllerState();
}

class _AudioControllerState extends State<AudioController> {

  onTimeChanged(newTime) {
    setState(() {
      widget.currentTime = newTime;
      widget.currentPosition = newTime;
    });
  }

  onPositionChanged(newPosition) {
    setState(() {
      widget.currentPosition = newPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        color: Color.fromRGBO(21, 45, 75, 0.8235294117647058),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 500,
              child: ListLyrics(
                  currentTime: widget.currentTime,
                  onTimeChanged: onTimeChanged,
                  currentPosition: widget.currentPosition,
                  onPositionChanged: onPositionChanged,
                  lyrics: widget.lyrics,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10.0),
              child: ProgessBarWidget(
                currentTime: widget.currentTime,
                totalTime: widget.totalTime,
                onTimeChanged: onTimeChanged,
                onPositionChanged: onPositionChanged,
              )
            ),
            ],
          ),
      );
  }
}
