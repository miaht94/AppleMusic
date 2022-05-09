import 'dart:math';

import 'package:apple_music/models_refactor/SongModel.dart';
import 'package:apple_music/pages/AlbumPage.dart';
import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:apple_music/components/SongCardInPlaylist/SongCardInPlaylist.dart';
import 'package:apple_music/components/SongCardInPlaylist/HScrollCardListConstants.dart';

import '../../models/SongCardInPlaylistModel.dart';



class HScrollCardList extends StatefulWidget {
  HScrollCardList({Key? key,
    required this.cards
  }): super(key: key);

  final List<SongModel> cards;

  @override
  _HScrollCardListState createState() => _HScrollCardListState();

}

class _HScrollCardListState extends State<HScrollCardList> {
  int _focusedIndex = 0;
  GlobalKey<ScrollSnapListState> sslKey = GlobalKey();

  void _onItemFocus(int index) {
    setState(() {
      _focusedIndex = index;
    });
  }

  Widget _buildListItem(BuildContext context, int index) {

    final size = MediaQuery.of(context).size;
    final WIDTH = size.width;

    // var i = 0;
    List<SongModel> seperatedCards = [];

    _buildListItem(context, index){
      // print("index:" +index.toString());
      // print(widget.cards.length);

      for (int j = 0; j<widget.cards.length; j++){
        if(j>=index*4 && j<=index*4+3) {
          // print(widget.cards[j].songName + " is added to page " +
          //     index.toString());
          seperatedCards.add(widget.cards[j]);
        }
      }
    }

    _buildListItem(context, index);

    return Container(
      margin: EdgeInsets.symmetric(horizontal:20),
      width: size.width - 40,
      child: Material(
        child: InkWell(
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(0),
                itemBuilder: (context, index) {
                  return SongCardInPlaylist(
                      songModel: seperatedCards[index]);
                },
                itemCount: seperatedCards.length)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final WIDTH = size.width;

    return Container(
      height: 220,
      child: Column(
        children: <Widget>[
          Expanded(
            child: ScrollSnapList(
              // margin: EdgeInsets.symmetric(horizontal: 10),
              selectedItemAnchor: SelectedItemAnchor.START,
              shrinkWrap: true,
              onItemFocus: _onItemFocus,
              itemSize: size.width,
              itemBuilder: _buildListItem,
              itemCount: ((widget.cards.length-1)/4+1).floor(),
              key: sslKey,
            ),
          ),
        ],
      ),
    );
  }
}
