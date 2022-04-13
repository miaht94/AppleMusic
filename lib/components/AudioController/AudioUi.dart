import 'package:apple_music/components/ButtonLyric/LyricButton.dart';
import 'package:apple_music/components/ButtonPausePlay/PausePlayButton.dart';
import 'package:apple_music/components/ButtonPlaylist/PlaylistButton.dart';
import 'package:apple_music/components/Lyrics/ListLyrics.dart';
import 'package:apple_music/components/LyricsScrollView/LyricsFrame.dart';
import 'package:apple_music/components/PlayingSongCard/CurrentSongCard.dart';
import 'package:apple_music/components/ProgressBar/ProgessBarWidget.dart';
import 'package:apple_music/components/SongCardInPlaylist/SongCardInPlaylist.dart';
import 'package:apple_music/models/LyricModel.dart';
import 'package:flutter/material.dart';
import '../../services/service_locator.dart';
import 'AudioManager.dart';



class AudioUi extends StatefulWidget {
  AudioUi({
    Key? key,
  }) : super(key: key);

  @override
  State<AudioUi> createState() => _AudioUiState();
}

class _AudioUiState extends State<AudioUi> with WidgetsBindingObserver {
  bool isPlaying = false;
  String lyricUrl = "";
  final AudioManager _audioManager = getIt<AudioManager>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _audioManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return
      Container(
        color: Color.fromRGBO(21, 45, 75, 0.8235294117647058),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: _buildChildWindow()
            ),
            Positioned(
              bottom: 150.0,
              width: size.width * 0.99,
              child: _buildProgessBar()
            ),
            Positioned(
                top: 100.0,
                left: 0.0,
                right: 0.0,
                child: _buildCurrentSong(),
            ),
            Positioned(
              bottom: 75.0,
              left: 100.0,
              right: 100.0,
              height: 100.0,
              child: Center(child: _buildButtonPausePlay())
            ),
            Positioned(
              bottom: 0.0,
              left: 50.0,
              width: 64.0,
              height: 64.0,
              child: _buildLyricButton(),
            ),
            Positioned(
              bottom: 0.0,
              right: 50.0,
              width: 64.0,
              height: 64.0,
              child: _buildPlaylistButton(),
            ),
          ],
        ),
      );
  }

  Widget _buildChildWindow() {
    final size = MediaQuery.of(context).size;
    return
        LyricsFrame(
          width: size.width,
          height: size.height,
          blur: 0,
          backgroundImagePath: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/Taylor_Swift_2_-_2019_by_Glenn_Francis.jpg/800px-Taylor_Swift_2_-_2019_by_Glenn_Francis.jpg",
          child: Container(
            child: ValueListenableBuilder<ChildWindowState>(
                valueListenable: _audioManager.childWindowNotifier,
                builder: (_, value, __) {
                  switch (value) {
                    case ChildWindowState.lyrics:
                      return _buildLyrics();

                    case ChildWindowState.playlist:
                      return _buildPlaylist();

                    case ChildWindowState.song:
                      return _buildSongWindow();
                  }
                }
            ),
          ),
      );
  }

  Widget _buildPlaylist() {
    var size = MediaQuery.of(context).size;
    return
      Container(
        child: Text("Playlist",
          style: TextStyle(color: Colors.white),),
      );
  }

  Widget _buildSongWindow() {
    var size = MediaQuery.of(context).size;

    return
      Container(
        child: Text("Song Window",
        style: TextStyle(color: Colors.white),),
      );
  }

  Widget _buildLyrics() {
    var size = MediaQuery.of(context).size;

    return
      Container(
        // child: FutureBuilder<List<Lyric>>(
        //   future: Lyrics.fetchLyrics(lyricUrl),
        //   builder: (BuildContext context, AsyncSnapshot<List<Lyric>> listSnapshot) {
        //     Widget child;
        //     if (listSnapshot.hasData) {
        child:
        ValueListenableBuilder<ProgressBarState>(
          valueListenable: _audioManager.progressNotifier,
          builder: (_, value, __) {
            return ListLyrics(
              currentPosition: value.dragPosition,
              currentTime: value.current,
              onTimeChanged: _audioManager.seek,
              onPositionChanged: _audioManager.drag,
              // lyrics: listSnapshot.data!,
              lyrics: Lyrics.getLyrics(),
            );
          },
          // );
          //   } else {
          //     child = const SizedBox();
          //   }
          //   return Container(
          //     child: child,
          //   );
          // }
          // ),
        ),
      );
  }

  Widget _buildCurrentSong() {
    return
      CurrentSongCard();
  }

  Widget _buildProgessBar() {
    return
      Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: ValueListenableBuilder<ProgressBarState>(
          valueListenable: _audioManager.progressNotifier,
          builder: (_, value, __) {
            return ProgessBarWidget(
              totalTime: value.total,
              currentTime: value.current,
              onTimeChanged: _audioManager.seek,
              onPositionChanged: _audioManager.drag,
            );
          },
        ),
      );
  }

  Widget _buildButtonPausePlay() {
    return PausePlayButton();
  }

  Widget _buildLyricButton() {
    return LyricButton();
  }

  Widget _buildPlaylistButton() {
    return PlaylistButton();
  }
}