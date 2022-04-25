import 'package:apple_music/models/HScrollSquareModel.dart';
import 'package:flutter/material.dart';
import 'package:apple_music/constant.dart';
import 'SquareCard.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'HScrollSquareConstant.dart';


class HScrollSquareCard extends StatefulWidget {
   HScrollSquareCard({
    Key? key,
    required this.listItem,
  }) : super(key: key);

  final  List<HScrollSquareCardModel> listItem;

  @override
  State<HScrollSquareCard> createState() => _HScrollSquareCardState();
}

class _HScrollSquareCardState extends State<HScrollSquareCard> {
  int _focusedIndex = 0;
  GlobalKey<ScrollSnapListState> sslKey = GlobalKey();

  void _onItemFocus(int index) {
    setState(() {
      _focusedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final WIDTH = size.height * SQUARE_IMAGE_RATIO;
    return ScrollSnapList(
        onItemFocus: _onItemFocus,
        shrinkWrap: true,
        selectedItemAnchor: SelectedItemAnchor.START,
        padding: const EdgeInsets.only(top: kDefaultPadding),
        scrollDirection: Axis.horizontal,
        key: sslKey,
        itemSize: WIDTH + kDefaultPadding,
        itemCount: widget.listItem.length + 2,
        itemBuilder: (context, index) {
          if (index == 0){
            return const SizedBox(
              width: kDefaultPadding / 2,
            );
          }
          if (index == widget.listItem.length + 1){
            return const SizedBox(
              width: kDefaultPadding,
            );
          }
          return SquareCard(
            imageUrl: widget.listItem[index - 1].artURL,
            name: widget.listItem[index - 1].albumName,
            artist: widget.listItem[index - 1].albumArtist,
            id: index - 1,
            width: WIDTH,
          );
        },
    );
  }
}