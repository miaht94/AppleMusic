import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

class PageLoadError extends StatelessWidget {
  PageLoadError({
    Key? key,
    required this.title
  }) : super(key: key);

  late String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(SFSymbols.exclamationmark_circle, color: Colors.red, size: 45),
                Text(this.title, textAlign: TextAlign.center, style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    height: 3
                ))
              ]
          ),
    );
  }
}
