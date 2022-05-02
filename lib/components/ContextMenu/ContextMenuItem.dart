import 'package:apple_music/constant.dart';
import 'package:flutter/material.dart';


class ContextMenuItem extends StatefulWidget {
  ContextMenuItem({Key? key, required this.title, required this.iconData, this.onTapItem}) : super(key: key);
  String title;
  IconData iconData;
  Function? onTapItem;
  @override
  State<ContextMenuItem> createState() => _ContextMenuItemState();
}

class _ContextMenuItemState extends State<ContextMenuItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () {
          if (widget.onTapItem != null) {
            widget.onTapItem!();
          }
        },
        child: Container(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Row(children: [
            Align(alignment: Alignment.centerRight, child: Icon(widget.iconData, color: Colors.red,)),
            const SizedBox(width: kDefaultPadding*2,),
            Expanded(child: Text(widget.title, style: const TextStyle(fontSize: 16),)),
          ],),
        ),
      ),
    );
  }
}
