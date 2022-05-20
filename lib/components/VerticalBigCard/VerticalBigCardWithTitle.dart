import 'package:apple_music/models/VerticalCardWithTitleModel.dart';
import 'package:flutter/cupertino.dart';

import 'VerticalBigCard.dart';
import 'VerticalBigCardConstant.dart';

// ignore: must_be_immutable
class VerticalBigCardWithTitle extends StatelessWidget {

  VerticalCardWithTitleModel model;
  // ignore: sort_constructors_first
  VerticalBigCardWithTitle({Key? key, required this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text(model.title, style: const TextStyle(color: kVCardTitleColor, fontSize: kCardTitleSize)),
      const SizedBox(height: 5),
      VerticalBigCard(playlistModel: model.playlistModel, footerColor: model.footerColor,)
    ]);
  }
  

}