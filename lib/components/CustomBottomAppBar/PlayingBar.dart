import 'package:apple_music/components/AudioController/AudioManager.dart';
import 'package:apple_music/components/AudioController/AudioPageRouteManager.dart';
import 'package:apple_music/components/AudioController/AudioStates.dart';
import 'package:apple_music/components/AudioController/AudioUi.dart';
import 'package:apple_music/components/NextPreviousButton/NextSongButton.dart';
import 'package:apple_music/components/NextPreviousButton/PreviousSongButton.dart';
import 'package:apple_music/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:get_it/get_it.dart';
import 'package:skeletons/skeletons.dart';

import '../ButtonPausePlay/PausePlayButton.dart';

class PlayingBar extends StatefulWidget {
  AudioManager audioManager = GetIt.I.get < AudioManager > ();
  PlayingBar({
    Key ? key
  }): super(key: key);

  @override
  State < PlayingBar > createState() => _PlayingBarState();
}

class _PlayingBarState extends State < PlayingBar > {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return
    ValueListenableBuilder < AudioMetadata > (
      valueListenable: widget.audioManager.currentSongNotifier,
      builder: (context, currentSong, _) {
        if (currentSong.artwork == "") return Container();
        return GestureDetector(
          onTap:  () {
            Navigator.push(GetIt.I.get<AudioPageRouteManager>().getMainContext(), PageRouteBuilder(opaque: false, pageBuilder: (_, __, ___) => AudioUi()));
          },
          child: Material(
            type: MaterialType.transparency,
            elevation: 6,
            child: Container(
              padding: EdgeInsets.only(top: kDefaultPadding / 2, left: kDefaultPadding, bottom: kDefaultPadding / 2),
              width: screenSize.width,
              color: Color.fromARGB(239, 249, 249, 249),
              child: Container(
                width: screenSize.width,
                child: Row(children: [
                  Container(
                    width: 60,
                    height: 60,
                    margin: const EdgeInsets.only(right: kDefaultPadding),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8))
                        ),
                        child: CachedNetworkImage(
                          imageUrl: '${currentSong.artwork}',
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
                
                        children: [
                          Expanded(
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                
                                Flexible(
                                  flex: 4,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(currentSong.title, style: const TextStyle(fontSize: 16, color: Colors.black, overflow: TextOverflow.ellipsis), maxLines: 1),
                                      Text(currentSong.artist, style: const TextStyle(fontSize: 13, color: Colors.grey, overflow: TextOverflow.ellipsis), maxLines: 1)
                                    ], ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Container(),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                      child: PreviousSongButton(buttonSize: 35, buttonColor: Colors.black.withOpacity(0.7),)
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                      child: PausePlayButton(buttonSize: 35, buttonColor: Colors.black.withOpacity(0.7))
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                      child: NextSongButton(buttonSize: 35, buttonColor: Colors.black.withOpacity(0.7))
                                  ),
                                ),
                  
                              ],
                            ),
                          )
                  
                        ]),
                    ),
                  ),
                  
                ], ),
              ),
            ),
          ),
        );
      }
    );
  }
}