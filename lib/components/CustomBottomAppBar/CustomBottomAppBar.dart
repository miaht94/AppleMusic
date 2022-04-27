import 'dart:ui';

import 'package:apple_music/components/CustomBottomAppBar/CustomBottomAppBarConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

import 'CustomBottomAppBarButton.dart';

class CustomBottomAppBar extends StatefulWidget {
  CustomBottomAppBar({Key? key,required this.pageController}) : super(key: key);
  PageController pageController;
  
  @override
  State < CustomBottomAppBar > createState() => _CustomBottomAppBar();
}

class _CustomBottomAppBar extends State < CustomBottomAppBar > {
  
  @override
  void initState() {
    super.initState();
    widget.pageController.addListener(() {
      setState(() {
        
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final Size screenSize = MediaQuery.of(context).size;
    
    return Container(
      height: screenSize.height * kBottomAppBarHeightRatio,
      width: screenSize.width,
      child: 
      
      ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Row(children: [
            Flexible(
              child: CustomAppBarButton(
                title: 'Nghe ngay', 
                icon: SFSymbols.play_circle,
                isActivated: widget.pageController.page != null ? widget.pageController.page!.toInt() == 0 : widget.pageController.initialPage == 0,
                onTapHandler: () {
                  widget.pageController.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                },)
            ),
            Flexible(
              child: CustomAppBarButton(
                title: 'Khám phá', 
                icon: SFSymbols.cube,
                isActivated: widget.pageController.page != null ? widget.pageController.page!.toInt() == 1 : widget.pageController.initialPage == 1,
                onTapHandler: () {
                  widget.pageController.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                }
              )
            ),
            Flexible(
              child: CustomAppBarButton(
                title: 'Thư viện', 
                icon: SFSymbols.music_note_list,
                isActivated: widget.pageController.page != null ? widget.pageController.page!.toInt() == 2 : widget.pageController.initialPage == 2,
                onTapHandler: () {
                  widget.pageController.animateToPage(2, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                })
            ),
            Flexible(
              child: CustomAppBarButton(title: 'Tìm kiếm', icon: SFSymbols.search,
              isActivated: widget.pageController.page != null ? widget.pageController.page!.toInt() == 3 : widget.pageController.initialPage == 3,
              onTapHandler: () {
                  widget.pageController.animateToPage(3, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                })
            ),
          ], ),
        ),
      )
    );
  }
}