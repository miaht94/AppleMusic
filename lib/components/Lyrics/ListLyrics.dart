import 'package:flutter/material.dart';
import '../../models/LyricModel.dart';
import 'LyricConstant.dart';
import 'LyricWidget.dart';

class ListLyrics extends StatefulWidget{
  ListLyrics({Key? key,
    required this.currentTime,
    required this.onTimeChanged,
    required this.currentPosition,
    required this.onPositionChanged,
    required this.lyrics,
  })
      : super(key: key);

  Duration currentTime;
  Duration currentPosition;
  List<Lyric> lyrics;

  var onTimeChanged;
  var onPositionChanged;

  @override
  State<ListLyrics> createState() => _ListLyricsState();
}

class _ListLyricsState extends State<ListLyrics> with TickerProviderStateMixin{

  var _PlayingLyric;
  var _PlayingId;
  var lyrics;

  late List<AnimationController?> animationControllers;
  late List<AnimationController?> animationBlurs;

  initState() {
    lyrics = widget.lyrics;
    _PlayingLyric = lyrics[0].key.currentContext;
    super.initState();
    animationControllers = [];
    animationBlurs = [];
    for (var i = 0; i < lyrics.length; i++){
      animationControllers.add(AnimationController(
        duration: const Duration(
          milliseconds: 300,
        ),
        vsync: this,
        value: 1.0,
        upperBound: 1.5,
        lowerBound: 0.5,
      ));
      animationBlurs.add(AnimationController(
        duration: const Duration(
          milliseconds: 300,
        ),
        vsync: this,
        value: 1.0,
        upperBound: 5.0,
        lowerBound: 0.0,
      ));
    }
  }

  _onItemTapUp(id) {
    if(_PlayingLyric != null) {
      widget.onTimeChanged(lyrics[id].startTime);
    }
  }

  _handleAnimation(id) {
    if(_PlayingId != null){
      animationControllers[_PlayingId]!.animateTo(NORMAL_SCALE, duration: Duration(milliseconds: RESIZE_ANIMATION_DURATION));
      animationBlurs[_PlayingId]!.animateTo(NORMAL_SCALE, duration: Duration(milliseconds: RESIZE_ANIMATION_DURATION));
    }

    setState(() {
      if (_PlayingLyric != lyrics[id].key.currentContext){
        _PlayingLyric = lyrics[id].key.currentContext;
        _PlayingId = id;
      }});

    animationControllers[id]!.animateTo(MAX_SCALE,duration: Duration(milliseconds: 200));
    animationBlurs[id]!.animateTo(MIN_BLUR,duration: Duration(milliseconds: 200));

    if(_PlayingLyric != null) {
      Scrollable.ensureVisible(
          _PlayingLyric!,
          alignment: 0.1,
          duration: Duration(milliseconds: SCROLL_ANIMATION_DURATION),
          curve: Curves.easeOutCubic
      );
    }
  }

  _checkCurrentlyric() {

    for(var i = 1; i < lyrics.length; i ++){
      if (widget.currentPosition < lyrics[i].startTime){
        var id = i - 1;
        _handleAnimation(id);
        break;
      }
    }
    if (widget.currentPosition >= lyrics[lyrics.length - 1].startTime){
      _handleAnimation(lyrics.length - 1);
    }
  }

  @override
  Widget build(BuildContext context){
    _checkCurrentlyric();

    return
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(lyrics.length + 1, (index) {
              return (index < lyrics.length) ?
                LyricWidget(
                    lyrics[index].key,
                    lyrics[index],
                    _onItemTapUp,
                  animationControllers[index],
                    animationBlurs[index],
                    index
                )
                  : SizedBox(
                    width: double.infinity,
                    height: 1000,
                  );
            }
            ),
          ),
      );
  }
}

