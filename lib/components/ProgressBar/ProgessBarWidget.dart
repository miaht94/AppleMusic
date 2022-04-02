import 'package:flutter/material.dart';
import 'audioWidget.dart';


class ProgessBarWidget extends StatefulWidget {
  const ProgessBarWidget({
    Key? key,
  }) : super(key: key);


  @override
  State<ProgessBarWidget> createState() => _ProgessBarWidgetState();
}

class _ProgessBarWidgetState extends State<ProgessBarWidget> with TickerProviderStateMixin{
  final Color cardPaiterColor = Colors.redAccent;
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
            AudioWidget(
              barColor: Color.fromRGBO(211,195 , 195, 1.0),
              thumbColor: Color.fromRGBO(211, 195, 195, 1.0),
              thumbSize: animation!.value,
              controller: controller,
              totalTime: Duration(hours: 1,minutes: 2, seconds: 30),
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