import 'dart:math';

import 'package:apple_music/components/ContextMenu/ContextMenuItem.dart';
import 'package:apple_music/components/ContextMenu/ContextMenuManager.dart';
import 'package:apple_music/components/HorizontalCard/HorizontalCardConstant.dart';
import 'package:apple_music/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:get_it/get_it.dart';

class SubscreenContextMenu extends StatefulWidget {
  SubscreenContextMenu({
    Key ? key,
    required this.body,
    required this.name,
    this.onDispose,
    this.init,
  }): super(key: key);
  Widget Function(BuildContext) body;
  Function? init;
  late AnimationController anim;
  String name;
  bool invisible = true;
  Function? onDispose;
  void closeSubscreen(Function callback) {
    anim.animateTo(-1, duration: const Duration(milliseconds: 300), curve: Curves.easeOutExpo);
    anim.addStatusListener((status) {
      if (status.name == 'completed') {
        GetIt.I.get < ContextMenuManager > ().removeOverlay(name);
        if (callback != null)
          callback();
      }
    });
  }

  @override
  State < SubscreenContextMenu > createState() => _SubscreenContextMenu();
}
class _SubscreenContextMenu extends State < SubscreenContextMenu > with SingleTickerProviderStateMixin {
  double ? childHeight;
  double ? _minBottomPos;
  double ? _maxBottomPos;
  @override
  void initState() {
    super.initState();
    if (widget.init != null) widget.init!();
    widget.anim = AnimationController(vsync: this, value: 0, lowerBound: -10000, upperBound: 10000);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      childHeight ??= posKey.currentContext!.size?.height;
      _minBottomPos = -childHeight!;
      widget.anim.value = -1;
      setState(() {
        widget.invisible = false;
      });
      widget.anim.animateTo(0, curve: Curves.easeOutExpo, duration: const Duration(milliseconds: 400));

    });
  }
  @override
  void dispose() {
    super.dispose();
    widget.onDispose != null ? widget.onDispose!() : '';
  }
  GlobalKey posKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    
    final Size size = MediaQuery.of(context).size;
    _maxBottomPos = (size.height/2 - (childHeight ?? 0)/2);
    return
    Offstage(
      offstage: widget.invisible,
      child: Material(
        // style: TextStyle(),
        type: MaterialType.transparency,
        elevation: 5,
        child: AnimatedBuilder(
          animation: widget.anim,
          builder: (context, child) =>
          Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                width: size.width,
                height: size.height,
                child: GestureDetector(
                  onTap: () {
                    widget.anim.animateTo(-1, duration: const Duration(milliseconds: 300), curve: Curves.easeOutExpo);
                    widget.anim.addStatusListener((status) {

                      if (status.name == 'completed') {
                        GetIt.I.get < ContextMenuManager > ().removeOverlay(widget.name);
                      }
                    });
                  },
                  child: Container(
                    color: Colors.black.withOpacity(0.2),
                    width: size.width,
                    height: size.height,
                  ),
                )
              ),
              Positioned(
                key: posKey,
                bottom: childHeight != null ? (_minBottomPos ?? 0) + (1 + widget.anim.value) * (_maxBottomPos! - (_minBottomPos ?? 0)) : 0,
                width: size.width,
                child: widget.body(context),
              ),
            ]),
        ),
      ),
    );
  }
}