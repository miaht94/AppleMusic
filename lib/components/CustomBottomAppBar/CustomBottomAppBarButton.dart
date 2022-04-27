import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

import 'CustomBottomAppBarConstant.dart';

class CustomAppBarButton extends StatefulWidget {
  CustomAppBarButton({Key? key, required this.icon, required this.title, this.onTapHandler, required this.isActivated}) : super(key: key);
  IconData icon;
  bool isActivated;
  String title;
  Function()? onTapHandler;
  @override
  State<CustomAppBarButton> createState() => _CustomAppBarButtonState();
}

class _CustomAppBarButtonState extends State<CustomAppBarButton> {
  Color iconColor = Colors.black;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }
  void onTap() {
    setState(() {
      print("Tap");
      
      // iconColor = kActiveButtonBackgroundColor;
    });
    if (widget.onTapHandler != null) {
      widget.onTapHandler!();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Material(
                // borderRadius: BorderRadius.circular(100),
                // type: MaterialType.transparency,
                color: kButtonBackgroundColor,
        
                child: InkWell(
                  
                  // radius: 20,
                //  borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
                  onTap: () {
                    onTap();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.transparent,
                    //  padding: EdgeInsets.all(12),
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(widget.icon, size: kBottomAppBarButtonIconSize, color: widget.isActivated ? kActiveButtonBackgroundColor : iconColor, ),
                        Text(widget.title, style: TextStyle(fontSize: kTitleButtonBottomAppBarSize, color: widget.isActivated ? kActiveButtonBackgroundColor : iconColor, fontWeight: FontWeight.w400),)
                      ]),
                  ),
                ),
              );
  }
}