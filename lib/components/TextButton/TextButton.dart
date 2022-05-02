import 'package:flutter/material.dart';

class TextButton extends StatefulWidget {
  TextButton({Key? key, required this.text, this.iconLeft, this.iconRight, required this.color, this.iconSize, required this.textSize, this.onTap}) : super(key: key);
  String text;
  IconData? iconLeft;
  IconData? iconRight;
  Color color;
  double textSize;
  double? iconSize;
  double opacity = 1;
  Function? onTap;
  @override
  State<TextButton> createState() => _TextButtonState();
}

class _TextButtonState extends State<TextButton> {
  bool onHold = false;
  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: () {
        print("tap");
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      onTapDown: (detail) {
        setState(() {
          widget.opacity = 0.4; 
        });
      },
      onTapUp: (detail) {
        setState(() {
          widget.opacity = 1;
        });
      },
      onTapCancel: () {
        setState(() {
          widget.opacity = 1;
        });
      },
      child: Row(children: [
        if (widget.iconLeft != null)
          Icon(widget.iconLeft!, color: widget.color.withOpacity(widget.opacity),),
        Text(widget.text, style: TextStyle(color: widget.color.withOpacity(widget.opacity))),
        if(widget.iconRight != null)
          Icon(widget.iconRight!, color: widget.color.withOpacity(widget.opacity)),
      ],)
    );
  }
}