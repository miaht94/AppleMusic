import 'package:flutter/material.dart';

class HorizontalCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.blue,
      child: Text("Bach", style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: 50),),
    );
  }


  
}