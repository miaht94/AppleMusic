import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:apple_music/components/SongCardInPlaylist/SongCardInPlaylist.dart';
import 'package:apple_music/components/SongCardInPlaylist/HScrollCardListConstants.dart';

var sampleData = [
  {
    "artist_name": "Taylor Swift",
    "song_name": "Lover",
    "art_url":
        "https://upload.wikimedia.org/wikipedia/vi/c/cd/Taylor_Swift_-_Lover.png"
  },
  {
    "artist_name": "Taylor Swift",
    "song_name": "Red",
    "art_url":
        "https://nld.mediacdn.vn/291774122806476800/2021/6/19/t03-16240818944771485276009.jpg"
  },
  {
    "artist_name": "Taylor Swift, Ed Sheeran",
    "song_name": "Everything Has Changed",
    "art_url":
        "https://nld.mediacdn.vn/291774122806476800/2021/6/19/t03-16240818944771485276009.jpg"
  },
  {
    "artist_name": "Taylor Swift",
    "song_name": "cardigan",
    "art_url":
        "https://upload.wikimedia.org/wikipedia/vi/f/f8/Taylor_Swift_-_Folklore.png"
  }
];

class HScrollCardList extends StatefulWidget {
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
    return Container(
      margin: EdgeInsets.symmetric(horizontal:20),
      width: size.width - 40,
      child: Material(
        child: InkWell(
            child: ListView.builder(
                padding: const EdgeInsets.all(0),
                itemBuilder: (context, index) {
                  return SongCardInPlaylist(
                      songName: sampleData[index]['song_name']!,
                      artistName: sampleData[index]['artist_name']!,
                      artURL: sampleData[index]['art_url']!);
                },
                itemCount: sampleData.length)),
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
              itemSize: size.width-40,
              itemBuilder: _buildListItem,
              itemCount: 3,
              key: sslKey,
            ),
          ),
        ],
      ),
    );
  }
}
