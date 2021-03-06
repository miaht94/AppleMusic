import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

// ignore: must_be_immutable
class ContextMenuButton extends StatefulWidget {
  ContextMenuButton({Key? key, required this.child, required this.buttonName}) : super(key: key);
  Widget child;
  String buttonName;
  @override
  State<ContextMenuButton> createState() => _ContextMenuButtonState();
}

class _ContextMenuButtonState extends State<ContextMenuButton> {
  GlobalKey childKey = GlobalKey();
  @override
  // ignore: must_call_super
  void initState() {
    GetIt.I.get<Map<String, GlobalKey>>().putIfAbsent(widget.buttonName, () => childKey);
  }
  @override
  Widget build(BuildContext context) {
  
    return GestureDetector(
      // behavior: HitTestBehavior.opaque,
      onTap: () {
        if (kDebugMode) {
          print((childKey.currentContext!.findRenderObject() as RenderBox).localToGlobal(Offset.zero));
        }
      },
      child: Container(key: childKey, child: widget.child)
      );
  }
}
