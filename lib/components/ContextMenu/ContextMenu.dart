import 'dart:math';

import 'package:apple_music/components/ContextMenu/ContextMenuItem.dart';
import 'package:apple_music/components/ContextMenu/ContextMenuManager.dart';
import 'package:apple_music/components/HorizontalCard/HorizontalCardConstant.dart';
import 'package:apple_music/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:get_it/get_it.dart';

class ContextMenu extends StatefulWidget {
  ContextMenu({
    Key ? key,
    required this.action,
    required this.name,
    this.header
  }): super(key: key);
  List < Widget > action;
  late AnimationController anim;
  String name;
  Widget? header;
  bool invisible = true;
  void closeContextMenu(Function? callback) {
    anim.animateTo(-1, duration: const Duration(milliseconds: 300), curve: Curves.easeOutExpo);
    anim.addStatusListener((status) {
      if (status.name == 'completed') {
        GetIt.I.get < ContextMenuManager > ().removeOverlay(name);
        if (callback != null) callback();
      }
    });
  }
  @override
  State < ContextMenu > createState() => _ContextMenuState();
}
class _ContextMenuState extends State < ContextMenu > with SingleTickerProviderStateMixin {
  double ? childHeight;
  
  late List<Widget> renderWidget = []; 
  @override
  void initState() {
    super.initState();
    if (widget.header != null) {
      renderWidget.add(
        Container(
          padding: const EdgeInsets.only(left: kDefaultPadding * 2, top: kDefaultPadding * 2, right: kDefaultPadding * 2, bottom: kDefaultPadding),
          child: Column(
            children: [
              widget.header!
            ]
          )
        )
      );
      renderWidget.add(
        Row(
          children: 
            const [
              Expanded(
                child: Divider(
                  height: 4,
                  thickness: 0.6,
                  indent: 10,
                  endIndent: 10,
                  color: Colors.grey,
                )
              )
            ]
        )
      );
    }
    renderWidget.add(
      Container(
        padding: const EdgeInsets.only(left: kDefaultPadding * 2, top: kDefaultPadding * 2, right: kDefaultPadding * 2, bottom: kDefaultPadding),
        child: Column(
          children: 
            widget.action
          
        )
      )
    );
    widget.anim = AnimationController(vsync: this, value: 0, lowerBound: -1, upperBound: 0);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      if (childHeight == null) {
        childHeight = posKey.currentContext!.size?.height;
      }
      widget.anim.value = -1;
      setState(() {
        widget.invisible = false;
      });
      widget.anim.animateTo(0, curve: Curves.easeOutExpo, duration: const Duration(milliseconds: 400));

    });
  }
  GlobalKey posKey = GlobalKey();
  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;
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
                bottom: childHeight != null ? widget.anim.value * childHeight! : 0,
                left: 0,
                width: size.width,
                child: GestureDetector(
                  onVerticalDragUpdate: (details) {
                    widget.anim.value = min(0, widget.anim.value - details.delta.dy / childHeight!);
                  },
                  onVerticalDragEnd: (details) {
                    if (details.velocity.pixelsPerSecond.dy > 100 && widget.anim.value / childHeight! <= 0.5) {
                      widget.anim.animateTo(-1, duration: const Duration(milliseconds: 300), curve: Curves.easeOutExpo);
                      widget.anim.addStatusListener((status) {
                        if (status.name == 'completed') {
                          GetIt.I.get < ContextMenuManager > ().removeOverlay(widget.name);
                        }
                      });
                    } else {
                      widget.anim.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeOutExpo);
                    }
                  },
                  child: Container(
                    width: size.width,
                    // height: widget.height,
                    // padding: EdgeInsets.only(left: kDefaultPadding * 2, top: kDefaultPadding * 2, right: kDefaultPadding * 2, bottom: kDefaultPadding),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(color: Colors.white, borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: const Radius.circular(20))),
                    child: SingleChildScrollView(
                      child: Column(
                      
                        children: renderWidget
                      )
                    )
                  ),
                ),
              ),
            ]),
        ),
      ),
    );
  }
}