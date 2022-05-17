import 'package:flutter/material.dart';

import '../../models/LyricModel.dart';
import 'LyricConstant.dart';

class LyricWidget extends StatefulWidget{
  const LyricWidget(Key? key, this.lyric, this.onTap,
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
  // ignore: always_declare_return_types
  dispose() {
    widget._controller?.dispose();
    super.dispose();
  }

  // ignore: always_declare_return_types, inference_failure_on_function_return_type
  _onTapUp() {
    widget.onTap(widget.id);
  }
  // ignore: always_declare_return_types, inference_failure_on_function_return_type
  _onTapDown() {
    widget._controller?.animateTo(MIN_SCALE,duration: const Duration(milliseconds: TAP_DOWN_ANIMATION_DURATION));
  }

  // ignore: always_declare_return_types, inference_failure_on_function_return_type
  _onTapCancel() {
    widget._controller?.animateTo(NORMAL_SCALE,duration: const Duration(milliseconds: CANCEL_ANIMATION_DURATION));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (_) => _onTapUp(),
      onTapDown: (_) => _onTapDown(),
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: widget._controller!,
          child: Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(10),
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
