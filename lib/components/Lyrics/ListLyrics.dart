import 'package:flutter/material.dart';

import '../../models/LyricModel.dart';
import 'LyricWidget.dart';

class ListLyrics extends StatefulWidget{
  const ListLyrics({Key? key}) : super(key: key);

  @override
  State<ListLyrics> createState() => _ListLyricsState();
}

class _ListLyricsState extends State<ListLyrics> with TickerProviderStateMixin{

  final lyrics = Lyrics.getLyrics();
  var _PlayingLyric = GlobalKey().currentContext;
  var _PlayingId;

  late List<AnimationController?> animationControllers;
  late List<AnimationController?> animationBlurs;

  initState() {
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

  BuildContext get PlayingLyric => _PlayingLyric!;

  set PlayingLyric(BuildContext newContext){
    _PlayingLyric = newContext;
  }

  _onItemTapUp(id) {
    if(_PlayingId != null){
      animationControllers[_PlayingId]!.animateTo(1.0, duration: Duration(milliseconds: 500));
      animationBlurs[_PlayingId]!.animateTo(1.0, duration: Duration(milliseconds: 500));
    }
    setState(() {
      if (_PlayingLyric != lyrics[id].key.currentContext){
        _PlayingLyric = lyrics[id].key.currentContext;
        _PlayingId = id;
        }});
    Scrollable.ensureVisible(
        _PlayingLyric!,
        alignment: 0.1,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut
    );
  }


  @override
  Widget build(BuildContext context){
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

