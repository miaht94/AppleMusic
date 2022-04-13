import 'dart:ui';

import 'package:apple_music/components/SongCardInPlaylist/HScrollCardListWithText.dart';
import 'package:apple_music/components/SquareCard/HScrollSquareCardWithText.dart';
import 'package:apple_music/constant.dart';
import 'package:apple_music/models/HScrollSquareModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

class ArtistView extends StatefulWidget {
  @override
  State<ArtistView> createState() => _ArtistViewState();
}

class _ArtistViewState extends State<ArtistView> {

  late ScrollController _scrollController = ScrollController();

  bool lastStatus = true;

  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  bool get isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (300 - kToolbarHeight);
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
        SliverAppBar(
                    leading: Container(
                      padding: EdgeInsets.only(left:10),
                      child: Row(
                          children: <Widget>[
                            Icon(SFSymbols.chevron_left, color:Colors.red)
                          ]
                      ),
                    ),
                    pinned: true,
                    floating: false,
                    backgroundColor: Colors.white,
                    expandedHeight: 300.0,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Container(
                        alignment: Alignment.bottomLeft,
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Visibility(
                                visible: isShrink ? false : true,
                                child: Align(
                                    alignment: Alignment.bottomCenter, child: Text("Taylor Swift", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ))),
                              ),
                              Container(
                                padding: EdgeInsets.only(left:30),
                                child: Visibility(
                                  visible: isShrink ? true : false,
                                  child: Align(
                                      alignment: Alignment.bottomCenter, child: Text("Taylor Swift", style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                  ))),
                                ),
                              ),
                              Expanded(
                                  child:
                                  Visibility(
                                    visible: !isShrink,
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        width:40,
                                        height:30,
                                        padding: EdgeInsets.only(right: 10),
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: Icon(SFSymbols.play_fill, color: Colors.white, size:12),
                                          style: ElevatedButton.styleFrom(
                                            shape: CircleBorder(),
                                            padding: EdgeInsets.all(0),
                                            primary: Colors.red, // <-- Button color
                                            onPrimary: Colors.red, // <-- Splash color
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                              )
                            ]
                        ),
                      ),
                      background: Image.network(
                        'https://nld.mediacdn.vn/291774122806476800/2021/6/19/t03-16240818944771485276009.jpg',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  )
        ];
      },
      body: ListView(
          shrinkWrap: true,
          children:[
                      ArtistHighlightAlbum(),
                      HScrollCardListWithText(title: "Ca Khúc Mới Hay Nhất"),
                      Container(
                        padding: EdgeInsets.only(bottom: VerticalComponentPadding),
                        child: HScrollSquareCardWithText(title: "Album đã phát hành", cards: HScrollSquareCardModel.getSampleData()),
                      )
                    ]
                ),

    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       extendBodyBehindAppBar: true,
  //     body: NestedScrollView(
  //       controller: _scrollController,
  //       headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
  //         return <Widget>[
  //           SliverAppBar(
  //             leading: Icon(SFSymbols.chevron_left, color:Colors.red),
  //             pinned: true,
  //             snap: false,
  //             floating: false,
  //             backgroundColor: Colors.white,
  //             expandedHeight: 300.0,
  //             flexibleSpace: FlexibleSpaceBar(
  //               title: Container(
  //                 alignment: Alignment.bottomLeft,
  //                 padding: EdgeInsets.only(left: 10),
  //                 child: Row(
  //                     children: <Widget>[
  //                       Align(
  //                           alignment: Alignment.bottomLeft, child: Text("Taylor Swift", style: TextStyle(
  //                         color: isShrink ? Colors.black : Colors.white,
  //                         fontSize: 18.0,
  //                       ))),
  //                       Expanded(
  //                           child:
  //                           Align(
  //                             alignment: Alignment.bottomRight,
  //                             child: ElevatedButton(
  //                               onPressed: () {},
  //                               child: Icon(SFSymbols.play_fill, color: Colors.white, size:14),
  //                               style: ElevatedButton.styleFrom(
  //                                 shape: CircleBorder(),
  //                                 padding: EdgeInsets.all(0),
  //                                 primary: Colors.red, // <-- Button color
  //                                 onPrimary: Colors.red, // <-- Splash color
  //                               ),
  //                             ),
  //                           )
  //                       )
  //                     ]
  //                 ),
  //               ),
  //               background: Image.network(
  //                 'https://nld.mediacdn.vn/291774122806476800/2021/6/19/t03-16240818944771485276009.jpg',
  //                 fit: BoxFit.fitWidth,
  //               ),
  //             ),
  //           )
  //         ];
  //         },
  //         body:
  //         // SliverList(
  //         //     delegate: SliverChildListDelegate(
  //                 Row(children:[
  //                   ArtistHighlightAlbum(),
  //                   HScrollCardListWithText(title: "Ca Khúc Mới Hay Nhất"),
  //                   Container(
  //                     padding: EdgeInsets.only(bottom: VerticalComponentPadding),
  //                     child: HScrollSquareCardWithText(title: "Album đã phát hành",),
  //                   ),
  //                   Container(
  //                     padding: EdgeInsets.only(bottom: VerticalComponentPadding),
  //                     child: HScrollSquareCardWithText(title: "Album đã phát hành",),
  //                   ),
  //                   Container(
  //                     padding: EdgeInsets.only(bottom: VerticalComponentPadding),
  //                     child: HScrollSquareCardWithText(title: "Album đã phát hành",),
  //                   ),
  //                 ]
  //         //     )
  //         // )
  //
  //     ),
  //   );
  //
  // }
}

class ArtistHighlightAlbum extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left:20,top:20,bottom:20,right:10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image.network(
                    "https://i.scdn.co/image/ab67616d0000b273e53252ce47982a3d555a6b3b",
                    height: 100,
                    width: 100,
                  ),
                )
            ),
            Expanded(
                child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                                Text("21 thg 12, 2022".toUpperCase(), style: TextStyle(fontSize: 11, color: Colors.grey)),
                                SizedBox(height: 5),
                                Text("Message In A Bottle (Taylor's Version)", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                SizedBox(height: 5),
                                Text("Taylor Swift", style: TextStyle(fontSize: 11, color: Colors.grey)),
                                SizedBox(height: 5),
                                Container(
                                  height:19,
                                  width:19,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: Icon(SFSymbols.plus, color: Colors.red, size:16),
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      padding: EdgeInsets.all(0),
                                      primary: Color.fromRGBO(250, 250, 250, 100), // <-- Button color
                                      onPrimary: Color.fromRGBO(250, 250, 250, 100), // <-- Splash color
                                    ),
                                  ),
                                ),
                              ],
                            )
            )
      ])
    );
  }
}


