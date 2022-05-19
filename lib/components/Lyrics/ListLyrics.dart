import 'package:flutter/material.dart';

import '../../models/LyricModel.dart';
import 'LyricConstant.dart';
import 'LyricWidget.dart';

// ignore: must_be_immutable
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
  List<LyricModel> lyrics;

  // ignore: prefer_typing_uninitialized_variables, inference_failure_on_uninitialized_variable
  var onTimeChanged;
  // ignore: prefer_typing_uninitialized_variables, inference_failure_on_uninitialized_variable
  var onPositionChanged;

  @override
  State<ListLyrics> createState() => _ListLyricsState();
}

class _ListLyricsState extends State<ListLyrics> with TickerProviderStateMixin{

  // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables, inference_failure_on_uninitialized_variable
  var _PlayingLyric;
  // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables, inference_failure_on_uninitialized_variable
  var _PlayingId;
  // ignore: prefer_typing_uninitialized_variables, inference_failure_on_uninitialized_variable
  var lyrics;
  late final List<Widget> children;
  late List<AnimationController?> animationControllers;

  @override
  // ignore: always_declare_return_types
  initState() {
    super.initState();
    _init();
  }

  void _init() {
    lyrics = widget.lyrics;
    _PlayingLyric = lyrics[0].key.currentContext;
    animationControllers = [];
    for (var i = 0; i < lyrics.length; i++){
      animationControllers.add(AnimationController(
        vsync: this,
        value: 1,
        upperBound: 1.5,
        lowerBound: 0.5,
      ));
    }
    children = List.generate(lyrics.length + 1, (index) {
      return (index < lyrics.length) ?
      LyricWidget(
          lyrics[index].key,
          lyrics[index],
          _onItemTapUp,
          animationControllers[index],
          index
      )
          : const SizedBox(
        width: double.infinity,
        height: 1000,
      );
    }
    );

    children.insert(0,
        const SizedBox(
          width: double.infinity,
          height: 200,
        )
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  // ignore: inference_failure_on_untyped_parameter
  void _onItemTapUp(id) {
    assert(id != null);
    if(_PlayingLyric != null) {
      widget.onPositionChanged(lyrics[id].startTime);
      widget.onTimeChanged(lyrics[id].startTime);
      _handleAnimation(id);
    }
  }

  // ignore: inference_failure_on_untyped_parameter
  void _handleAnimation(id) {
    if (_PlayingId != id) {
      if(_PlayingId != null){
        animationControllers[_PlayingId]!.animateTo(NORMAL_SCALE, duration: const Duration(milliseconds: RESIZE_ANIMATION_DURATION));
      }

      if(_PlayingId == null && id == 0){
        animationControllers[0]!.animateTo(NORMAL_SCALE, duration: const Duration(milliseconds: RESIZE_ANIMATION_DURATION));
      }


      setState(() {
        if (_PlayingLyric != lyrics[id].key.currentContext){
          _PlayingLyric = lyrics[id].key.currentContext;
          _PlayingId = id;
        }});

      animationControllers[id]!.animateTo(MAX_SCALE,duration: const Duration(milliseconds: TAP_UP_ANIMATION_DURATION));

      if(_PlayingLyric != null) {
        Scrollable.ensureVisible(
            _PlayingLyric!,
            alignment: LYRIC_SCROLL_ALIGHTMENT,
            duration: const Duration(milliseconds: SCROLL_ANIMATION_DURATION),
            curve: Curves.easeOutCubic
        );
      }
    }
    else{
      animationControllers[id]!.animateTo(MAX_SCALE,duration: const Duration(milliseconds: 200));
    }
  }

  void _checkCurrentlyric() {
    const int start =  1;

    for(int i = start; i < lyrics.length; i ++){
      if (widget.currentPosition <= lyrics[i].startTime){
        final int id = i - 1;
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
    if(lyrics != widget.lyrics){
      lyrics = widget.lyrics;
      _init();
    }
    _checkCurrentlyric();
    return
      SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: children
          ,
        ),
      );
  }
}
