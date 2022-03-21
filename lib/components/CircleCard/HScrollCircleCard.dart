import 'package:flutter/material.dart';
import 'package:apple_music/constant.dart';
import 'CircleCard.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';



class HScrollCircleCard extends StatefulWidget {
  const HScrollCircleCard({
    Key? key,
    required this.listItem,
  }) : super(key: key);

  final List<Map<String, String>> listItem;

  @override
  State<HScrollCircleCard> createState() => _HScrollCircleCardState();
}

class _HScrollCircleCardState extends State<HScrollCircleCard> {
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
        itemSize: MediaQuery.of(context).size.width * CIRCLE_CARD_WIDTH_RATIO,
        itemCount: widget.listItem.length + 1,
        itemBuilder: (context, index) {
          if (index == 0){
            return SizedBox(
              width: 10,
            );
          }
          return CircleCard(
            imageUrl: widget.listItem[index - 1]['imageUrl']!,
            artist: widget.listItem[index - 1]['artist']!,
            id: index - 1,
          );
        },
        )
    );
  }
}