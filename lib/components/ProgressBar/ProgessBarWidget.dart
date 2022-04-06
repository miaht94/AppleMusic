import 'package:flutter/material.dart';
import 'ProgessBarObject.dart';
import 'ProgressBarConstant.dart';


class ProgessBarWidget extends StatefulWidget {
   ProgessBarWidget({
    Key? key,
    required this.currentTime,
    required this.totalTime,
    required this.onTimeChanged,
    required this.onPositionChanged,

  }) : super(key: key);

  Duration currentTime;
  Duration totalTime;

  var onTimeChanged;
  var onPositionChanged;

   @override
  State<ProgessBarWidget> createState() => _ProgessBarWidgetState();
}

class _ProgessBarWidgetState extends State<ProgessBarWidget> with TickerProviderStateMixin{
  Animation<double>? animation;
  AnimationController? controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(milliseconds: 100), vsync: this);
    animation = Tween<double>(begin: 10, end: 25).animate(controller!)
      ..addListener(() {
        setState(() {
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ProgressBarObject(
              barColor: BAR_COLOR,
              thumbColor: THUMB_COLOR,
              thumbSize: animation!.value,
              controller: controller,
              currentTime: widget.currentTime,
              totalTime: widget.totalTime,
              onTimeChanged: widget.onTimeChanged,
              onPositionChanged: widget.onPositionChanged,
            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }
}