import 'dart:convert';

import 'package:apple_music/components/HorizontalCard/HorizontalCardConstant.dart';
import 'package:apple_music/models/HorizontalCardWithTitleModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'HorizontalCard.dart';

class HorizontalCardWithTitle extends StatefulWidget {

    HorizontalCardWithTitle({
        Key ? key,
        required this.card
    }): super(key: key);
    HorizontalCardWithTitleModel card;



    @override
    State < StatefulWidget > createState() {
        return new _HorizontalCardWithTitle(card);
    }
}

class _HorizontalCardWithTitle extends State < HorizontalCardWithTitle > {
    _HorizontalCardWithTitle(this.card);
    HorizontalCardWithTitleModel card;
    @override
    Widget build(BuildContext context) {
        Size size = MediaQuery.of(context).size;
        // print(size);
        return Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Padding(
                        padding:EdgeInsets.only(bottom: 10),
                        child: Container(
                            height: 1.0,
                            width: kCardWidth,
                            color:kHeadlineColor
                        )
                    ),
                    Text(card.category, style: TextStyle(color: kCategoryTextColor, fontWeight: FontWeight.w400, fontSize: kCategoryFontSize), ),
                    Text(card.title, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18)),
                    Text(card.primaryDes, style: TextStyle(color: kPrimaryDesColor, fontSize: kPrimaryDesFontSize, fontWeight: kPrimaryDesFontWeight)),
                    Padding(padding: EdgeInsets.only(bottom: 6)),
                    HorizontalCard(id: card.id, primaryImagePath: card.primaryImagePath, secondaryImagePath: card.secondaryImagePath, secondaryDes: card.secondaryDes)
                ]),
        );
    }

}