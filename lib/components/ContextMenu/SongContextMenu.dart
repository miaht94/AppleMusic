import 'package:apple_music/components/ContextMenu/ContextMenu.dart';
import 'package:apple_music/components/ContextMenu/ContextMenuItem.dart';
import 'package:apple_music/constant.dart';
import 'package:apple_music/models/SongCardInPlaylistModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:skeletons/skeletons.dart';

class SongContextMenu extends ContextMenu{
  SongContextMenu({Key? key, required this.name, required this.songCardInPlaylistModel}): 
    super(key: key,
      name: "SongContextMenu",
      action: [
          ContextMenuItem(
            title: "Tải về", 
            iconData: Icons.cloud_download_outlined,
            onTapItem: () {
              throw UnimplementedError();
            },
          ),
          ContextMenuItem(
            title: "Phát tiếp theo", 
            iconData: SFSymbols.text_insert,
            onTapItem: () {
              throw UnimplementedError();
            },
          ),
          ContextMenuItem(
            title: "Phát cuối cùng", 
            iconData: SFSymbols.text_append,
            onTapItem: () {
              throw UnimplementedError();
            },
          ),
          ContextMenuItem(
            title: "Thêm vào playlist", 
            iconData: SFSymbols.text_badge_plus,
            onTapItem: () {
              throw UnimplementedError();
            },
          )
      ],
      header: Container(
        child: Row(
          
          children: [
            CachedNetworkImage(
              imageUrl: songCardInPlaylistModel.artURL, 
              placeholder: (_, __) => SkeletonAvatar(),
              imageBuilder: (context, imageProvider) => 
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(image: imageProvider, fit: BoxFit.cover)
                  ),
                ),
            ),
            SizedBox(width: kDefaultPadding * 2),
            Expanded(
              child: Column(
                children: [
                  Text(
                    songCardInPlaylistModel.songName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    songCardInPlaylistModel.artistName,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                  Text(
                    songCardInPlaylistModel.genre,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400
                    ),
                  )
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              )
            )
          ]
        )
      )
    );
  SongCardInPlaylistModel songCardInPlaylistModel;
  String name;
  // @override
  // Widget build(BuildContext context) {
  //   return ContextMenu(
  //       name: name,
  //       action: [
          
  //       ], 
  //       // header: ,
  //     );
  // }
  
}