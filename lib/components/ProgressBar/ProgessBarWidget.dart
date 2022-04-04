import 'package:flutter/material.dart';
import 'ProgessBarObject.dart';
import 'ProgressBarConstant.dart';


class ProgessBarWidget extends StatefulWidget {
   ProgessBarWidget({
    Key? key,
    required this.currentTime,
    required this.totalTime,
  }) : super(key: key);

  Duration currentTime;
  Duration totalTime;
   @override
  State<ProgessBarWidget> createState() => _ProgessBarWidgetState();
}

class _ProgessBarWidgetState extends State<ProgessBarWidget> with TickerProviderStateMixin{
  Animation<double>? animation;
  AnimationController? controller;

  onChanged(newTime) {
    setState(() {
      widget.currentTime = newTime;
    });
  }

  _incrementCounter() async {
    for (var i = 0; i < 100; i++) { //Loop 100 times
      await Future.delayed(
          const Duration(seconds: 1), () { // Delay 500 milliseconds
        setState(() {
          widget.currentTime = widget.currentTime + Duration(seconds: 1); //Increment Counter
        });
      });
    }
  }

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
    print(widget.currentTime);
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
              onChanged: onChanged,
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