import 'package:apple_music/components/ContextMenu/ContextMenuManager.dart';
import 'package:apple_music/components/ContextMenu/UserSubscreenContextMenu.dart';
import 'package:apple_music/constant.dart';
import 'package:apple_music/models_refactor/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'PageTitle.dart';
import 'TitleComponentConstant.dart';

// ignore: must_be_immutable
class PageTitleBox extends StatelessWidget {
   PageTitleBox({
    Key? key,
    required this.title,
     this.hasAvt
  }) : super(key: key);

  final String title;
  bool ? hasAvt;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
    width: size.width,
    height: size.height * PAGE_TITLE_BOX_HEIGHT_RATIO,
    padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
              alignment: Alignment.centerLeft,
              child: PageTitle(title: title),
                ),
              if (hasAvt != null && hasAvt == true) const Align(
                alignment: Alignment.centerRight,
                child: PageTitleAvt(),
              ) else const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}

class PageTitleAvt extends StatelessWidget {
  const PageTitleAvt({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
          GetIt.I.get<ContextMenuManager>().insertSubscreen(UserSubscreenContextMenu());
      },
      child: ValueListenableBuilder<UserModel>(
        valueListenable: GetIt.I.get<UserModelNotifier>(),
        builder: (context, userModel, _) => 
        CircleAvatar(
            backgroundImage: NetworkImage(userModel.avatarURL),
          ),
      )
    );
  }
}