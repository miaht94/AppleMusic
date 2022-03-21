import 'package:flutter/material.dart';
import 'package:apple_music/constant.dart';
import 'squareCard.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'HScrollSquareConstant.dart';


class HScrollSquareCard extends StatefulWidget {
  const HScrollSquareCard({
    Key? key,
    required this.listItem,
  }) : super(key: key);

  final List<Map<String, String>> listItem;

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
    return Container(
      child: ScrollSnapList(
        onItemFocus: _onItemFocus,
        shrinkWrap: true,
        selectedItemAnchor: SelectedItemAnchor.START,
        padding: const EdgeInsets.only(top: kDefaultPadding),
        scrollDirection: Axis.horizontal,
        key: sslKey,
        itemSize: MediaQuery.of(context).size.width * SQUARE_CARD_WIDTH_RATIO,
        itemCount: widget.listItem.length + 1,
        itemBuilder: (context, index) {
          if (index == 0){
            return SizedBox(
              width: kDefaultPadding / 2,
            );
          }
          return SquareCard(
            imageUrl: widget.listItem[index - 1]['imageUrl']!,
            name: widget.listItem[index - 1]['name']!,
            artist: widget.listItem[index - 1]['author']!,
            id: index - 1,
          );
        },
        )
    );
  }
}