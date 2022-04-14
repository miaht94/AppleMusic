import 'dart:ui';

import 'package:apple_music/components/AudioController/AudioManager.dart';
import 'package:apple_music/components/PlayingSongCard/PlayingSongCard.dart';
import 'package:apple_music/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class CurrentPlaylist extends StatefulWidget {

  @override
  State<CurrentPlaylist> createState() => _CurrentPlaylistState();
}

class _CurrentPlaylistState extends State<CurrentPlaylist> {
  final _audioManager = getIt<AudioManager>();
  @override
  Widget build(BuildContext context) {
    return
      ValueListenableBuilder<List<IndexedAudioSource>>(
        valueListenable: _audioManager.playlistNotifier,
        builder: (_, playlist, __) {
          if (playlist != []) {

            List<Widget> children = [];

            for (int index = 0; index < playlist.length; index++) {
              IndexedAudioSource song = playlist[index];
              children.add(
                  Container(
                    key: ValueKey(index),
                    margin: EdgeInsets.only(top: 10.0),
                    child: PlayingSongCard(
                      songName: song.tag.title,
                      artistName: song.tag.artist,
                      artURL: song.tag.artwork,
                      size: 50,
                      imageSize: 50,
                      songNameFontSize: 16,
                      artistFontSize: 12,
                      songNameColor: Color.fromRGBO(255, 255, 255, 0.95),
                      hasArtWork: true,
                    ),
                  )
                );
              };
            return
              Container(
                margin: EdgeInsets.only(top: 50),
                child: ReorderableListView(
                    proxyDecorator: _proxyDecorator,
                    onReorder: ((oldIndex, newIndex){
                      if (oldIndex < newIndex) newIndex--;
                       _audioManager.move(oldIndex, newIndex);
                  }),
                  children: children
                ),
              );
            } else
            return
              SizedBox();
        },
      );
  }

  Widget _proxyDecorator(Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        final double animValue = Curves.easeInOut.transform(animation.value);
        final double elevation = lerpDouble(0, 0.1, animValue)!;
        return Material(
          color: Color.fromRGBO(255, 255, 255, 0.0),
          shadowColor: Color.fromRGBO(255, 255, 255, 0.01),
          child: child,

        );
      },
      child: child,
    );
  }
}