import 'package:apple_music/constant.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import '../../models/VerticalCardWithTitleModel.dart';
import 'VerticalBigCardWithTitle.dart';

// ignore: must_be_immutable
class VerticalBigCardsWithTitle extends StatelessWidget {
  VerticalBigCardsWithTitle({Key? key, required this.cards}) : super(key: key);
  List<VerticalCardWithTitleModel> cards;
  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = [];
    for (int i = 0; i < cards.length; i++) {
      widgets.add(VerticalBigCardWithTitle(model: cards[i]));
    }
    return SingleChildScrollView(
        // ignore: unnecessary_const
        padding: const EdgeInsets.only(left: kDefaultPadding*1.5),
        scrollDirection: Axis.horizontal,
        child: Row(children:
          widgets
        ),
      );
  }
  
}