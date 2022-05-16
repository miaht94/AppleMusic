import 'package:apple_music/models/VerticalCardWithTitleModel.dart';
import 'package:flutter/cupertino.dart';

import 'VerticalBigCard.dart';
import 'VerticalBigCardConstant.dart';

class VerticalBigCardWithTitle extends StatelessWidget {

  VerticalCardWithTitleModel model;
  VerticalBigCardWithTitle({Key? key, required this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text(model.title, style: TextStyle(color: kVCardTitleColor, fontSize: kCardTitleSize)),
      SizedBox(height: 5,),
      VerticalBigCard(playlistModel: model.playlistModel, footerColor: model.footerColor,)
    ]);
  }
  

}