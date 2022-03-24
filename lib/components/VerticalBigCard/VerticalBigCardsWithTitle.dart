import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import '../../models/VerticalCardWithTitleModel.dart';
import 'VerticalBigCardWithTitle.dart';

class VerticalBigCardsWithTitle extends StatelessWidget {
  VerticalBigCardsWithTitle({Key? key, required this.cards}) : super(key: key);
  List<VerticalCardWithTitleModel> cards;
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    for (int i = 0; i < cards.length; i++) {
      widgets.add(VerticalBigCardWithTitle(model: cards[i]));
    }
    return SingleChildScrollView(
        child: Row(children: 
          widgets
        ),
        scrollDirection: Axis.horizontal,
      );
  }
  
}