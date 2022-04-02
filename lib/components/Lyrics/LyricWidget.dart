import 'package:flutter/material.dart';
import 'dart:ui';

import '../../models/LyricModel.dart';

class LyricWidget extends StatefulWidget{
  LyricWidget(Key? key, this.lyric, this.onTap,
      this._controller,this._blur, this.id)
      : super(key:key);
  final Lyric lyric;
  final void Function(int) onTap;
  final AnimationController? _controller;
  final AnimationController? _blur;
  final int id;
  @override
  State<LyricWidget> createState() => _LyricWidgetState();
}

class _LyricWidgetState extends State<LyricWidget> with TickerProviderStateMixin{

  @override
  void initState() {
    super.initState();
    widget._controller!..addListener(() {setState(() {
    });});
    widget._blur!..addListener(() {setState(() {
    });});
  }

  @override
  dispose() {
    widget._controller!.dispose();
    super.dispose();
  }

  _onTapUp() {
    widget.onTap(widget.id);
    widget._controller?.animateTo(1.05,duration: Duration(milliseconds: 300));
    widget._blur?.animateTo(0.01,duration: Duration(milliseconds: 300));
  }
  _onTapDown() {
    widget._controller?.animateTo(0.95,duration: Duration(milliseconds: 100));
  }

  _onTapCancel() {
    widget._controller?.animateTo(1.0,duration: Duration(milliseconds: 500));
    widget._blur?.animateTo(1.0,duration: Duration(milliseconds: 500));

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (_) => _onTapUp(),
      onTapDown: (_) => _onTapDown(),
      onTapCancel: () => _onTapCancel(),
      child: ScaleTransition(
        scale: widget._controller!,
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(
            sigmaY: widget._blur!.value,
            sigmaX: widget._blur!.value,
          ),
          child: Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(10),
            decoration:  BoxDecoration(
              color: Colors.white.withOpacity(
                  (widget._controller!.value >= 1.0) ? 0.0
                      : (1.0 - widget._controller!.value) * 1.5),
              borderRadius: BorderRadius.circular(12),
            ),

            width: 500,
            child: Align(
              alignment: Alignment.centerLeft,
              child: AnimatedDefaultTextStyle(
                duration: Duration(milliseconds: 700),
                style: TextStyle(fontSize: 25, color: Colors.white ),
                child: Text(widget.lyric.lyric),
                curve: Curves.fastOutSlowIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
