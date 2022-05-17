import 'package:apple_music/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

import '../TitleComponent/BoldTitle.dart';

class TextListView extends StatelessWidget {
  const TextListView({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: kDefaultPadding * 2),
              child: BoldTitle(title: title),
            )
          ],
        ),
        Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 290,
              child: ListView(children: const <Widget>[
                TextListButton(title: 'Khám Phá Theo Danh Mục'),
                TextListButton(title: 'Bảng Xếp Hạng'),
                TextListButton(title: 'Thư Giãn'),
                TextListButton(title: 'Đặc Sắc Nhất'),
                TextListButton(title: 'Video Nhạc'),
                TextListButton(title: 'Trẻ Em'),
              ])),
        ),
      ],
    );
  }
}

class TextListButton extends StatelessWidget {
  const TextListButton({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(0),
        height: 45,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
          Expanded(
              child: Column(
            children: [
              const Divider(
                height: 20,
                thickness: 0.8,
                indent: kDefaultPadding * 2,
                endIndent: 0,
                color: Colors.grey,
              ),
              Row(
                children: <Widget>[
                  // ConstrainedBox(
                  // constraints: BoxConstraints(minWidth: 356),
                  // child:
                  Container(
                      padding: const EdgeInsets.only(left: kDefaultPadding * 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(title,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red))
                        ],
                      )),

                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                          padding: const EdgeInsets.only(right: 17),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              // mainAxisSize: MainAxisSize.min,
                              children: const <Widget>[
                                Icon(SFSymbols.chevron_right, size: 15),
                              ])),
                    ),
                  )
                ],
              ),
            ],
          ))
        ]));
  }
}
