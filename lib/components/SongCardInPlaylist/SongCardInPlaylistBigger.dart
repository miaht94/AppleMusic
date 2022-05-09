import 'package:apple_music/components/HorizontalCard/HorizontalCardConstant.dart';
import 'package:apple_music/constant.dart';
import 'package:apple_music/models/SongCardInPlaylistModel.dart';
import 'package:apple_music/models_refactor/SongModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:skeletons/skeletons.dart';

class SongCardInPlaylistBigger extends StatefulWidget {
  SongCardInPlaylistBigger({
    Key ? key,
    required this.songModel,
    this.onTapSongCardInPlaylist,
    this.onTapSongCardMoreButton,
  }): super(key: key);
  Function(SongModel) ? onTapSongCardMoreButton;
  Function(SongModel) ? onTapSongCardInPlaylist;
  final SongModel songModel;
  @override
  _SongCardInPlaylistStateBigger createState() => _SongCardInPlaylistStateBigger();
}

class _SongCardInPlaylistStateBigger extends State < SongCardInPlaylistBigger > {

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Material(
      child: Container(
        width: screenSize.width,
        margin: const EdgeInsets.only(bottom: kDefaultPadding),
        // padding: EdgeInsets.symmetric(vertical: kDefaultPadding/1.2),
        child: InkWell(
          onTap: () {
            if (widget.onTapSongCardInPlaylist != null) {
              widget.onTapSongCardInPlaylist!(widget.songModel);
            }
          },
          child: Row(children: [
            Container(
              width: 60,
              height: 60,
              margin: const EdgeInsets.only(right: kDefaultPadding),
              decoration: const BoxDecoration(
                // image: DecorationImage(
                //   image: Image.network(widget.songCardInPlaylistModel.artURL).image, 
                //   fit: BoxFit.cover
                // ),
                borderRadius: BorderRadius.all(Radius.circular(8))
              ),
              child: CachedNetworkImage(
                imageUrl: widget.songModel.album.art_url,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                const SkeletonAvatar(),
                imageBuilder: (context, imageProvider) =>
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(8))
                  ), ),
              ),
              // child: CircleAvatar(backgroundImage : Image.network(albumRectangleCardModel.artURL,).image)
            ),
            Expanded(
              child: Container(
                height: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(
                      height: 4,
                      thickness: 0.4,
                      indent: 10,
                      endIndent: 0,
                      color: Colors.grey,
                    ),
              
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(widget.songModel.song_name, style: const TextStyle(fontSize: 16, color: Colors.black, overflow: TextOverflow.ellipsis), maxLines: 1),
                                Text('${widget.songModel.artist.artist_name} - Bài hát', style: const TextStyle(fontSize: 13, color: Colors.grey, overflow: TextOverflow.ellipsis), maxLines: 1)
                              ], ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Material(
                                type: MaterialType.transparency,
                                child: Ink(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(100),
                                    child: const Icon(SFSymbols.ellipsis, size: 18),
                                    onTap: () {
                                      if (widget.onTapSongCardMoreButton != null) {
                                        widget.onTapSongCardMoreButton!(widget.songModel);
                                      }
                                    },
                                  ),
                                )
                              )
                            )
                          )
                        ],
                      ),
                    )
              
                  ]),
              ),
            ),
              
          ], ),
        ),
      ),
    );
  }
}