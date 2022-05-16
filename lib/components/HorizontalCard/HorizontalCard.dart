import 'package:apple_music/components/HorizontalCard/HorizontalCardConstant.dart';
import 'package:apple_music/components/HorizontalCard/InnerShadow.dart';
import 'package:apple_music/constant.dart';
import 'package:flutter/material.dart';

class HorizontalCard extends StatelessWidget {
  HorizontalCard(
      {Key? key,
      required this.id,
      required this.primaryImagePath,
      required this.secondaryImagePath,
      required this.secondaryDes,
      this.onTapHandler})
      : super(key: key);
  String id;
  String primaryImagePath;
  String secondaryImagePath;
  String secondaryDes;
  Function()? onTapHandler;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // print(size);
    return GestureDetector(
      onTap: () {
        print(id);
        if (onTapHandler != null) {
          onTapHandler!();
        }
      },
      child: Container(
          width: kCardWidth,
          height: kCardHeight,
          margin: EdgeInsets.only(right: 15),
          // color: Colors.blue,
          // child: Text("Bach", style: TextStyle(fontWeight: FontWeight.w500, fontStyle: FontStyle.italic, fontSize: 50, ),),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kCardBorderRadius)
              // border: Border.all()
              ),
          child: Stack(children: [
            Positioned(
                top: 0,
                left: 0,
                width: kCardWidth,
                height: kCardHeight,
                child: InnerShadow(
                  offset: Offset(0, -50),
                  blur: 10,
                  color: kInnerShadowColor,
                  child: Container(
                    width: kCardWidth,
                    height: kCardHeight,
                    // child: Image.asset("assets/images/HCardSample.png", fit: BoxFit.fill,),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // border: Border.all(),
                      image: DecorationImage(
                          image: Image.network(primaryImagePath).image,
                          fit: BoxFit.cover),
                      // gradient: LinearGradient(colors: [Colors.black, Colors.white], begin: Alignment.bottomCenter, end: Alignment.topCenter, stops:[0, 0.7])
                    ),
                  ),
                )),
            Positioned(
              bottom: kCardHeight * 0.05,
              width: kCardWidth,
              left: 0,
              child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Container(
                    padding: EdgeInsets.only(left: kDefaultCardPadding),
                    margin: EdgeInsets.only(right: kDefaultCardPadding),
                    width: kCardWidth * 0.7,
                    child: Text(
                      secondaryDes,
                      style: TextStyle(fontSize: 12, color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    )),
                Expanded(
                  child: Container(),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: kCardWidth * 0.15,
                  height: kCardWidth * 0.15,
                  // color: Colors.black,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: Image.network(secondaryImagePath).image,
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(5)),
                  // padding: EdgeInsets.only(right: kDefaultCardPadding),
                ),
                SizedBox(width: kDefaultCardPadding)
              ]),
            )
          ])),
    );
  }
}
