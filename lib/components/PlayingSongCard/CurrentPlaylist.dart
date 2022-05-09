import 'dart:ui';

import 'package:apple_music/components/AudioController/AudioManager.dart';
import 'package:apple_music/components/PlayingSongCard/PlayingSongCard.dart';
import 'package:apple_music/models_refactor/SongModel.dart';
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
    final size = MediaQuery.of(context).size;
    return
      ValueListenableBuilder<int>(
        valueListenable: _audioManager.currentSongIndexNotifier,
        builder: (_, currentIndex, __){
          return ValueListenableBuilder<List<IndexedAudioSource>>(
            valueListenable: _audioManager.playlistNotifier,
            builder: (_, playlist, __) {
              if (playlist != []) {

                List<Widget> children = [];

                for (int index = 0; index < playlist.length; index++) {
                  IndexedAudioSource song = playlist[index];
                  SongUrlModel tag = song.tag;
                  children.add(
                      Dismissible(
                        key :  UniqueKey(),
                        direction: DismissDirection.horizontal,
                        onDismissed: (_)=>{_audioManager.removeSong(index)},
                        child: Container(
                          key: ValueKey(index),
                          margin: EdgeInsets.only(top: 10.0),
                          child: PlayingSongCard(
                            songName: tag.song.song_name,
                            artistName: tag.song.artist.artist_name,
                            artURL: tag.song.album.art_url,
                            size: 50,
                            imageSize: 50,
                            songNameFontSize: 16,
                            artistFontSize: 12,
                            songNameColor: (currentIndex == index)  ? Color.fromRGBO(255, 255, 255, 1) : Color.fromRGBO(255, 255, 255, 0.60),
                            hasArtWork: true,
                          ),
                        ),
                      )
                  );
                };
                children.add(
                    SizedBox(
                      key: ValueKey(-1),
                      height: 200,
                      width: size.width,
                    )
                );
                return
                  Container(
                    margin: EdgeInsets.only(top: 200),
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