import 'dart:ui';

import 'package:apple_music/components/CustomBottomAppBar/CustomBottomAppBarConstant.dart';
import 'package:apple_music/pages/DiscoveryPage.dart';
import 'package:apple_music/pages/LibraryPage.dart';
import 'package:apple_music/pages/ListeningNow.dart';
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
  Widget build(BuildContext context) {
    // TODO: implement build
    Size screenSize = MediaQuery.of(context).size;
   
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
                title: "Nghe ngay", 
                icon: SFSymbols.play_circle,
                onTapHandler: () {
                  widget.pageController.animateToPage(0, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                },), 
              flex: 1
            ),
           Flexible(
              child: CustomAppBarButton(
                title: "Khám phá", 
                icon: SFSymbols.cube,
                onTapHandler: () {
                  widget.pageController.animateToPage(1, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                }
              ),
              flex: 1
            ),
             Flexible(
              child: CustomAppBarButton(
                title: "Thư viện", 
                icon: SFSymbols.music_note_list,
                onTapHandler: () {
                  widget.pageController.animateToPage(2, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                }),
              flex: 1
            ),
             Flexible(
              child: CustomAppBarButton(title: "Tìm kiếm", icon: SFSymbols.search,
              onTapHandler: () {
                  widget.pageController.animateToPage(3, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                }),
              flex: 1
            ),
          ], ),
        ),
      )
    );
  }
}