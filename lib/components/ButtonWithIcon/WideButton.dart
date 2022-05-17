
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

// ignore: must_be_immutable
class WideButton extends StatelessWidget {
  WideButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap
  }) : super(key: key);

  late String title;
  late IconData icon;
  // ignore: inference_failure_on_function_return_type
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
              primary: const Color.fromRGBO(242, 242, 242, 1),
              padding: const EdgeInsets.symmetric(vertical: 15),
          ),
          onPressed: onTap,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children : <Widget> [
                  Icon(icon
                      , color: Colors.red, size: 15),
                  const SizedBox(width: 5),
                  Text(title, style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold, color: Colors.red)),
                ]
            ),
        ),

      ),
    );
  }
}
