import 'package:flutter/material.dart';
import 'dart:ui';

import '../../models/LyricModel.dart';
import 'LyricConstant.dart';

class LyricWidget extends StatefulWidget{
  LyricWidget(Key? key, this.lyric, this.onTap,
      this._controller, this.id)
      : super(key:key);
  final LyricModel lyric;
  final void Function(int) onTap;
  final AnimationController? _controller;
  final int id;
  @override
  State<LyricWidget> createState() => _LyricWidgetState();
}

class _LyricWidgetState extends State<LyricWidget> with TickerProviderStateMixin{

  @override
  void initState() {
    super.initState();
    widget._controller!.addListener(() { if (mounted) {
      setState(() {
    });
    }});
  }

  @override
  dispose() {
    widget._controller?.dispose();
    super.dispose();
  }

  _onTapUp() {
    widget.onTap(widget.id);
  }
  _onTapDown() {
    widget._controller?.animateTo(MIN_SCALE,duration: Duration(milliseconds: TAP_DOWN_ANIMATION_DURATION));
  }

  _onTapCancel() {
    widget._controller?.animateTo(NORMAL_SCALE,duration: Duration(milliseconds: CANCEL_ANIMATION_DURATION));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (_) => _onTapUp(),
      onTapDown: (_) => _onTapDown(),
      onTapCancel: () => _onTapCancel(),
      child: ScaleTransition(
        scale: widget._controller!,
          child: Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(10),
            decoration:  BoxDecoration(
              color: Colors.white.withOpacity(
                  (widget._controller!.value >= 1.0) ? 0.0
                      : (1.0 - widget._controller!.value) * OPACITY_SCALE),
              borderRadius: BorderRadius.circular(LYRIC_BORDER),
            ),

            width: LYRIC_WIDTH,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                  widget.lyric.lyric,
                  style: TextStyle(fontSize: LYRIC_FONT_SIZE,
                      color:Colors.white.withOpacity(
                          (widget._controller!.value >= 1.03) ? 1.0
                          : 0.4),
              ),
          ),
        ),
      ),
      ),
    );
  }
}
