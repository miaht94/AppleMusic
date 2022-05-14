
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

class WideButtonWhite extends StatelessWidget {
  WideButtonWhite({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap
  }) : super(key: key);

  late String title;
  late IconData icon;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 45,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 15),
          ),
          onPressed: onTap,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children : <Widget> [
                  Icon(this.icon
                      , color: Colors.red, size: 15),
                  SizedBox(width: 5),
                  Text(this.title, style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold, color: Colors.red)),
                ]
            ),
        ),

      ),
    );
  }
}
