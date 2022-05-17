import 'package:apple_music/components/HorizontalCard/HorizontalCardConstant.dart';
import 'package:apple_music/models/HorizontalCardWithTitleModel.dart';
import 'package:flutter/cupertino.dart';

import 'HorizontalCardWithTitle.dart';

// ignore: must_be_immutable
class HorizontalCardsWithTitle extends StatefulWidget {
    
    HorizontalCardsWithTitle({Key? key, required this.cards}) : super(key: key);
    List<HorizontalCardWithTitleModel> cards;

  

    @override
    State < StatefulWidget > createState() {
        // ignore: no_logic_in_create_state
        return _HorizontalCardsWithTitle(cards);
    }


}

class _HorizontalCardsWithTitle extends State < HorizontalCardsWithTitle > {
    _HorizontalCardsWithTitle(this.cards);
    List<HorizontalCardWithTitleModel> cards;
    @override
    Widget build(BuildContext context) {
        final Size size = MediaQuery.of(context).size;
        // print(size);
        final List<Widget> cardWidgets = [];
        for (int i = 0; i < cards.length; i++) {
            cardWidgets.add(HorizontalCardWithTitle(card: cards[i]));
        }
        return Container(
            width: size.width,
            child: SingleChildScrollView(
                padding: const EdgeInsets.only(left: kDefaultCardPadding),
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: cardWidgets
                ),
            )
        );
    }

}