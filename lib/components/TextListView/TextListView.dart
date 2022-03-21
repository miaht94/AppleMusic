import 'package:flutter/material.dart';
import 'package:apple_music/constant.dart';
import '../TitleComponent/SeeAllButton.dart';
import '../TitleComponent/BoldTitle.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

class TextListView extends StatelessWidget{
  TextListView({Key? key,
    required this.title,
  }): super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: kDefaultPadding * 2),
                child: BoldTitle(title: title),
              )
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 290,
              child: ListView(
                children: <Widget>[
                  TextListButton(title: "Khám Phá Theo Danh Mục"),
                  TextListButton(title: "Bảng Xếp Hạng"),
                  TextListButton(title: "Thư Giãn"),
                  TextListButton(title: "Đặc Sắc Nhất"),
                  TextListButton(title: "Video Nhạc"),
                  TextListButton(title: "Trẻ Em"),
              ])
            ),
          ),
        ],
      );
  }
}

class TextListButton extends StatelessWidget{
  TextListButton({Key? key, required this.title,}): super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2),
        height: 45,
        child: Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                      child: Column(
                        children: [
                          Divider(
                            height: 20,
                            thickness: 0.8,
                            indent: 18,
                            endIndent: 0,
                            color: Colors.grey,
                          ),
                          Row(
                            children: <Widget>[
                              ConstrainedBox(
                                constraints: BoxConstraints(minWidth: 356),
                                child: Container(
                                    padding: EdgeInsets.only(left:17),
                                    child: Column(

                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      // mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red))
                                      ],
                                    )
                                ),
                              ),
                              Container(
                                    padding: EdgeInsets.only(right:17),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      // mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Icon(SFSymbols.chevron_right, size:15),
                                      ]
                                    )
                              )
                            ],
                          ),
                        ],
                      )
                  )
                ]
            )
        )
    );
  }
}