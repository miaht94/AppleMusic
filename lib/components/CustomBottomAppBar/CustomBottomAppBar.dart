import 'dart:ui';

import 'package:apple_music/components/AudioController/AudioPageRouteManager.dart';
import 'package:apple_music/components/CustomBottomAppBar/CustomBottomAppBarConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:get_it/get_it.dart';

import 'CustomBottomAppBarButton.dart';
import 'PlayingBar.dart';

// ignore: must_be_immutable
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

    return 
    Column(
      children: [
        PlayingBar(),
        Container(
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
                    isActivated: widget.pageController.hasClients && widget.pageController.page != null ? widget.pageController.page!.toInt() == 0 : widget.pageController.initialPage == 0,
                    onTapHandler: () {
                      if (Navigator.of(GetIt.I.get<AudioPageRouteManager>().getSecondaryContext()!).canPop()) {
                        Navigator.of(GetIt.I.get<AudioPageRouteManager>().getSecondaryContext()!).popUntil((route) => route.isFirst);
                      }
                      widget.pageController.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                    },)
                ),
                Flexible(
                  child: CustomAppBarButton(
                    title: 'Kh??m ph??', 
                    icon: SFSymbols.cube,
                    isActivated: widget.pageController.hasClients && widget.pageController.page != null ? widget.pageController.page!.toInt() == 1 : widget.pageController.initialPage == 1,
                    onTapHandler: () {
                      if (Navigator.of(GetIt.I.get<AudioPageRouteManager>().getSecondaryContext()!).canPop()) {
                        Navigator.of(GetIt.I.get<AudioPageRouteManager>().getSecondaryContext()!).popUntil((route) => route.isFirst);
                      } 
                      widget.pageController.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                      
                    }
                  )
                ),
                Flexible(
                  child: CustomAppBarButton(
                    title: 'Th?? vi???n', 
                    icon: SFSymbols.music_note_list,
                    isActivated: widget.pageController.hasClients && widget.pageController.page != null ? widget.pageController.page!.toInt() == 2 : widget.pageController.initialPage == 2,
                    onTapHandler: () {
                      if (Navigator.of(GetIt.I.get<AudioPageRouteManager>().getSecondaryContext()!).canPop()) {
                        Navigator.of(GetIt.I.get<AudioPageRouteManager>().getSecondaryContext()!).popUntil((route) => route.isFirst);
                      }
                      // widget.pageController.jumpToPage(2);
                      // Navigator.of(GetIt.I.get<AudioPageRouteManager>().getMainContext()).pushReplacementNamed('/homePage');
                      widget.pageController.animateToPage(2, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                    })
                ),
                Flexible(
                  child: CustomAppBarButton(title: 'T??m ki???m', icon: SFSymbols.search,
                  isActivated: widget.pageController.hasClients && widget.pageController.page != null ? widget.pageController.page!.toInt() == 3 : widget.pageController.initialPage == 3,
                  onTapHandler: () {
                    if (Navigator.of(GetIt.I.get<AudioPageRouteManager>().getSecondaryContext()!).canPop()) {
                      Navigator.of(GetIt.I.get<AudioPageRouteManager>().getSecondaryContext()!).popUntil((route) => route.isFirst);
                    }
                    widget.pageController.animateToPage(3, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                  })
                ),
              ], ),
            ),
          )
        ),
      ],
    );
  }
}