import 'dart:ui';

import 'package:apple_music/components/HorizontalCard/HorizontalCardConstant.dart';
import 'package:apple_music/components/VerticalBigCard/VerticalBigCardConstant.dart';
import 'package:apple_music/models_refactor/PlaylistModel.dart';
import 'package:apple_music/pages/PlaylistPage.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class VerticalBigCard extends StatefulWidget {
  late String description;
  late String imagePath;
  Color footerColor;
  final PlaylistModel playlistModel;
  // ignore: sort_constructors_first
  VerticalBigCard({
    Key ? key,
    required this.playlistModel,
    required this.footerColor,
  }): super(key: key){
    description = playlistModel.playlist_description;
    imagePath = playlistModel.art_url;
  }

  @override
  State < VerticalBigCard > createState() => _VerticalBigCardState();
}

class _VerticalBigCardState extends State < VerticalBigCard > with SingleTickerProviderStateMixin {
  double colorFilterOpa = 0;
  late AnimationController anc;
  @override
  void initState() {
    anc = AnimationController(vsync: this, duration: const Duration(milliseconds: 50));
    super.initState();
    setState(() {
    });
  }
  void onTapDown() {
    setState(() {
      anc.forward();
    });
  }

  void onTapUp() {
    setState(() {
      // colorFilterOpa = 0;
      anc.reverse();
    });
    Navigator.push(
      context,
      // ignore: inference_failure_on_instance_creation
      MaterialPageRoute(
        builder: (context) => PlaylistView(playlistModel: Future.value(widget.playlistModel)),
      ),
    );
  }

  void onTapCancel() {
    setState(() {
      // colorFilterOpa = 0;
      anc.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double cardWidth = size.height * kVCardWidthRatio;
    final double cardHeight = size.height * kVCardHeightRatio;
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        onTapDown();
      },
      onTapUp: (TapUpDetails details) {
        onTapUp();
      },
      onTapCancel: onTapCancel,
      child: AnimatedBuilder(
        animation: anc,
        builder: (context, child) =>
        Container(
          height: cardHeight,
          width: cardWidth,
          margin: const EdgeInsets.only(right: kVCardMargin),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(kCardBorderRadius)),
            child: Stack(

              children: [
                Positioned(
                  width: cardWidth,
                  height: cardHeight,
                  top: 0,
                  left: 0,
                  child: Container(
                    width: cardWidth,
                    height: cardHeight,
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(kVCardBorderRadius),
                      image: DecorationImage(image: Image.network(widget.imagePath).image, fit: BoxFit.cover),

                    ),

                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  width: cardWidth,
                  child: ClipRRect(
                    // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(kVCardBorderRadius), bottomRight: Radius.circular(kVCardBorderRadius)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(height: 100,
                        decoration: BoxDecoration(
                          color: widget.footerColor.withOpacity(0.6),
                          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(kVCardBorderRadius), bottomRight: Radius.circular(kVCardBorderRadius))
                        ),
                        alignment: Alignment.center,
                        child: Text(widget.description, style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: kCardDesSize), textAlign: TextAlign.center,),
                      ),
                    ),
                  )

                ),
                Positioned(child: Container(width: double.infinity, height: double.infinity, color: const Color.fromARGB(255, 129, 129, 129).withOpacity(anc.value * 0.25), ))
              ]
            ),
          )
        ),
      ),
    );
  }
}