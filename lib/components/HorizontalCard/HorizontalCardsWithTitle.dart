import 'package:apple_music/components/HorizontalCard/HorizontalCardConstant.dart';
import 'package:apple_music/model/HorizontalCardWithTitleModel.dart';
import 'package:flutter/cupertino.dart';

import 'HorizontalCard.dart';
import 'HorizontalCardWithTitle.dart';

class HorizontalCardsWithTitle extends StatefulWidget {
    
    HorizontalCardsWithTitle({Key? key, required this.cards}) : super(key: key);
    List<HorizontalCardWithTitleModel> cards;

  

    @override
    State < StatefulWidget > createState() {
        return new _HorizontalCardsWithTitle(cards);
    }


}

class _HorizontalCardsWithTitle extends State < HorizontalCardsWithTitle > {
    _HorizontalCardsWithTitle(this.cards);
    List<HorizontalCardWithTitleModel> cards;
    @override
    Widget build(BuildContext context) {
        Size size = MediaQuery.of(context).size;
        // print(size);
        List<Widget> cardWidgets = [];
        for (int i = 0; i < cards.length; i++) {
            cardWidgets.add(HorizontalCardWithTitle(card: cards[i]));
        }
        return Container(
            width: size.width,
            child: SingleChildScrollView(
                padding: EdgeInsets.only(left: kDefaultCardPadding),
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: cardWidgets
                ),
            )
        );
    }

}