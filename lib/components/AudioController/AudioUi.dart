import 'package:apple_music/components/AudioController/AudioPageRouteManager.dart';
import 'package:apple_music/components/ButtonLyric/LyricButton.dart';
import 'package:apple_music/components/ButtonPausePlay/PausePlayButton.dart';
import 'package:apple_music/components/ButtonPlaylist/PlaylistButton.dart';
import 'package:apple_music/components/Lyrics/ListLyrics.dart';
import 'package:apple_music/components/LyricsScrollView/LyricsFrame.dart';
import 'package:apple_music/components/NextPreviousButton/NextSongButton.dart';
import 'package:apple_music/components/NextPreviousButton/PreviousSongButton.dart';
import 'package:apple_music/components/PlayingSongCard/CurrentArtWork.dart';
import 'package:apple_music/components/PlayingSongCard/CurrentPlaylist.dart';
import 'package:apple_music/components/PlayingSongCard/CurrentSongCard.dart';
import 'package:apple_music/components/ProgressBar/ProgessBarWidget.dart';
import 'package:apple_music/components/RepeatButton/RepeatButton.dart';
import 'package:apple_music/components/ShuffleButton/ShuffleButton.dart';
import 'package:apple_music/models/LyricModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../services/service_locator.dart';
import 'AudioManager.dart';
import 'package:apple_music/components/AudioController/AudioStates.dart';

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return
        Material(
          type: MaterialType.transparency,
          child: Dismissible(
            key :  Key('AudioUi'),
            direction: DismissDirection.down,
            onDismissed: (_) => Navigator.pop(GetIt.I.get<AudioPageRouteManager>().getMainContext()),
            child: Container(
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
                    bottom: 190.0,
                    width: size.width * 0.99,
                    child: _buildProgessBar()
                  ),
                  _buildCurrentSong(),
                  _buildCurrentArtWork(),
                  Positioned(
                    bottom: 68.0,
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
                  Positioned(
                    bottom: 85.0,
                    right: 50.0,
                    width: 64.0,
                    height: 64.0,
                    child: _buldNextSongButton(),
                  ),
                  Positioned(
                    bottom: 85.0,
                    left: 30.0,
                    width: 64.0,
                    height: 64.0,
                    child: _buldPreviousSongButton(),
                  ),
                  Positioned(
                    top: 130.0,
                    right: 10.0,
                    child: _buildManagePlaylist(),
                  ),
                  Positioned(
                    top: 45.0,
                    child: Container(
                      height: 3,
                      width: MediaQuery.of(context).size.width * 0.25,
                      color: Colors.white70,
                    )
                  ),
                  Positioned(
                      top: 35,
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: InkWell(
                        onTap: () {},
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        child: SizedBox(
                          height: 5,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
        ),
      );
  }

  Widget _buildChildWindow() {
    final size = MediaQuery.of(context).size;
    return
      ValueListenableBuilder<AudioMetadata>(
          valueListenable: _audioManager.currentSongNotifier,
          builder: (_,currentSong,__){
            return LyricsFrame(
              width: size.width,
              height: size.height,
              blur: 10,
              backgroundImagePath: currentSong.artwork,
              child: Container(
                padding: EdgeInsets.only(left: 20.0),
                child: ValueListenableBuilder<ChildWindowState>(
                    valueListenable: _audioManager.childWindowNotifier,
                    builder: (_, value, __) {
                      var size = MediaQuery.of(context).size;
                      return Stack(
                          children: [
                            AnimatedOpacity(
                              opacity: (value != ChildWindowState.lyrics)? 0.0: 1.0,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                              child: IgnorePointer(
                                ignoring: (value != ChildWindowState.lyrics) ? true : false,
                                child: _buildLyrics(),
                              )
                            ),
                            AnimatedOpacity(
                              opacity: (value != ChildWindowState.playlist)? 0.0: 1.0,
                              duration: const Duration(milliseconds: 300),            
                              curve: Curves.easeIn,
                              child: IgnorePointer(
                                ignoring: (value != ChildWindowState.playlist) ? true : false,
                                child: _buildPlaylist(),
                              ),
                            ),
                          ],
                        );
                    }
                ),
              ),
      );
          }
        );
  }

  Widget _buildPlaylist() {
    return
      CurrentPlaylist();
  }

  Widget _buildLyrics() {
    var size = MediaQuery.of(context).size;

    return
      Container(
        child:
        ValueListenableBuilder<AudioMetadata>(
          valueListenable: _audioManager.currentSongNotifier,
          builder: (_, currentSong, __) {
            return FutureBuilder<List<LyricModel>>(
              future: _audioManager.currentLyricNotifier,
              builder: (context, snapshot) {
                if(snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                return ValueListenableBuilder<ProgressBarState>(
                  valueListenable: _audioManager.progressNotifier,
                  builder: (_, progressValue, __) {
                      return ListLyrics(
                        currentPosition: progressValue.dragPosition,
                        currentTime: progressValue.current,
                        onTimeChanged: _audioManager.seek,
                        onPositionChanged: _audioManager.drag,
                        lyrics: snapshot.data!,
                      );
                    }
                  );
                }
                else {
                      return
                          SizedBox();
                    }
                  },
                );
              }
            ),
      );
  }

  Widget _buildCurrentArtWork() {
    return CurrentArtWork();
  }

  Widget _buildCurrentSong() {
    return CurrentSongCard();
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

  Widget _buldNextSongButton() {
    return NextSongButton();
  }

  Widget _buildManagePlaylist() {
    return
    Container(
      child: ValueListenableBuilder<ChildWindowState>(
          valueListenable: _audioManager.childWindowNotifier,
          builder: (_, value, __) {
            var size = MediaQuery.of(context).size;
            return AnimatedOpacity(
                opacity: (value != ChildWindowState.playlist)? 0.0: 1.0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
                child: AbsorbPointer(
                  absorbing: (value != ChildWindowState.playlist) ? true : false,
                  child:  Row(
                    children: [
                      _buldShuffleButton(),
                      _buildRepeatButton(),
                    ],
                  ),
                )
            );
          }
      ),
    );
  }
  Widget _buildRepeatButton() {
    return RepeatButton();
  }

  Widget _buldShuffleButton() {
    return ShuffleButton();
  }

  Widget _buldPreviousSongButton() {
    return PreviousSongButton();
  }
}