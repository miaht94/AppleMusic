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

            children.insert(0,
                const SizedBox(
                  width: double.infinity,
                  height: 50,
                )
            );

            for (IndexedAudioSource song in playlist) {
              children.add(
                  Container(
                    padding: EdgeInsets.only(top: 10.0),
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
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: children
                  ,
                ),
              );
            } else
            return
              SizedBox();
        },
      );
  }
}