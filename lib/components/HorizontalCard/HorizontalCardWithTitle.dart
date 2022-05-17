
import 'package:apple_music/components/HorizontalCard/HorizontalCardConstant.dart';
import 'package:apple_music/models/HorizontalCardWithTitleModel.dart';
import 'package:apple_music/pages/AlbumPage.dart';
import 'package:flutter/material.dart';

import 'HorizontalCard.dart';

// ignore: must_be_immutable
class HorizontalCardWithTitle extends StatefulWidget {

    HorizontalCardWithTitle({
        Key ? key,
        required this.card
    }): super(key: key);
    HorizontalCardWithTitleModel card;



    @override
    State < StatefulWidget > createState() {
        // ignore: no_logic_in_create_state
        return _HorizontalCardWithTitle(card);
    }
}

class _HorizontalCardWithTitle extends State < HorizontalCardWithTitle > {
    _HorizontalCardWithTitle(this.card);
    HorizontalCardWithTitleModel card;

    void onTap(){
      Navigator.push(
        context,
        // ignore: inference_failure_on_instance_creation
        MaterialPageRoute(
          builder: (context) => AlbumView(albumViewModel: Future.value(card.albumModel)),
        ),
      );
    }
    @override
    Widget build(BuildContext context) {
        // print(size);
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Padding(
                    padding:const EdgeInsets.only(bottom: 10),
                    child: Container(
                        height: 1,
                        width: kCardWidth,
                        color:kHeadlineColor
                    )
                ),
                Text(card.category, style: const TextStyle(color: kCategoryTextColor, fontWeight: FontWeight.w400, fontSize: kCategoryFontSize), ),
                Text(card.title, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18)),
                Text(card.primaryDes, style: const TextStyle(color: kPrimaryDesColor, fontSize: kPrimaryDesFontSize, fontWeight: kPrimaryDesFontWeight)),
                const Padding(padding: EdgeInsets.only(bottom: 6)),
                HorizontalCard(id: card.id, primaryImagePath: card.primaryImagePath, secondaryImagePath: card.secondaryImagePath, secondaryDes: card.secondaryDes, onTapHandler: onTap,)
            ]);
    }

}