import 'package:apple_music/components/HorizontalCard/HorizontalCardConstant.dart';
import 'package:flutter/material.dart';
import 'package:apple_music/constant.dart';
import 'CircleCard.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'HScrollCircleConstant.dart';



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
    final size = MediaQuery.of(context).size;
    final WIDTH = size.height * CIRCLE_IMAGE_RATIO;
    return
      ScrollSnapList(
        onItemFocus: _onItemFocus,
        shrinkWrap: true,
        selectedItemAnchor: SelectedItemAnchor.START,
        padding: const EdgeInsets.only(top: kDefaultPadding),
        scrollDirection: Axis.horizontal,
        key: sslKey,
        itemSize: WIDTH + kDefaultPadding,
        itemCount: widget.listItem.length + 1,
        itemBuilder: (context, index) {
          if (index == 0){
            return SizedBox(
              width: kDefaultCardPadding / 2,
            );
          }
          return CircleCard(
            imageUrl: widget.listItem[index - 1]['imageUrl']!,
            artist: widget.listItem[index - 1]['artist']!,
            id: index - 1,
          );
        },
    );
  }
}