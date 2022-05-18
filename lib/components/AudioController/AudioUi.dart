import 'package:apple_music/components/AudioController/AudioPageRouteManager.dart';
import 'package:apple_music/components/AudioController/AudioStates.dart';
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
import 'package:apple_music/models_refactor/SongModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';

import '../../services/service_locator.dart';
import 'AudioManager.dart';

class AudioUi extends StatefulWidget {
  const AudioUi({
    Key? key,
  }) : super(key: key);

  @override
  State<AudioUi> createState() => _AudioUiState();
}

// ignore: prefer_mixin
class _AudioUiState extends State<AudioUi> with WidgetsBindingObserver {
  bool isPlaying = false;
  String lyricUrl = '';
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
    ValueListenableBuilder<bool>(
        valueListenable: _audioManager.isLoading,
        builder: (context, value,_) {

          if (!value) {
            EasyLoading.dismiss();
              return Material(
                type: MaterialType.transparency,
                child: Dismissible(
                  key :  const Key('AudioUi'),
                  direction: DismissDirection.down,
                  onDismissed: (_) => Navigator.pop(GetIt.I.get<AudioPageRouteManager>().getMainContext()),
                  child: Container(
                    color: const Color.fromRGBO(21, 45, 75, 0.8235294117647058),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          child: _buildChildWindow()
                        ),
                        Positioned(
                          bottom: 152,
                          width: size.width * 0.99,
                          child: _buildProgessBar()
                        ),
                        _buildCurrentSong(),
                        _buildCurrentArtWork(),
                        Positioned(
                          bottom: 60,
                          left: 100,
                          right: 100,
                          height: 100,
                          child: Center(child: _buildButtonPausePlay())
                        ),
                        Positioned(
                          bottom: 0,
                          left: 50,
                          width: 64,
                          height: 64,
                          child: _buildLyricButton(),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 50,
                          width: 64,
                          height: 64,
                          child: _buildPlaylistButton(),
                        ),
                        Positioned(
                          bottom: 80,
                          right: 30,
                          width: 64,
                          height: 64,
                          child: _buldNextSongButton(),
                        ),
                        Positioned(
                          bottom: 80,
                          left: 30,
                          width: 64,
                          height: 64,
                          child: _buldPreviousSongButton(),
                        ),
                        Positioned(
                          top: 130,
                          right: 10,
                          child: _buildManagePlaylist(),
                        ),
                        Positioned(
                          top: 45,
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
          } else {
            EasyLoading.show(status: 'Loading');
            return const SizedBox();
          }
        }
    );
  }

  Widget _buildChildWindow() {
    final size = MediaQuery.of(context).size;
    return
      ValueListenableBuilder<SongUrlModel?>(
          valueListenable: _audioManager.currentSongNotifier,
          builder: (_,currentSong,__){
            if (currentSong != null) {
              return LyricsFrame(
                width: size.width,
                height: size.height,
                blur: 5,
                backgroundImagePath: currentSong.song.album.art_url,
                child: Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: ValueListenableBuilder<ChildWindowState>(
                      valueListenable: _audioManager.childWindowNotifier,
                      builder: (_, value, __) {
                        return Stack(
                            children: [
                              AnimatedOpacity(
                                opacity: (value != ChildWindowState.lyrics)? 0.0: 1.0,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn,
                                child: IgnorePointer(
                                  // ignore: avoid_bool_literals_in_conditional_expressions
                                  ignoring: (value != ChildWindowState.lyrics) ? true : false,
                                  child: _buildLyrics(),
                                )
                              ),
                              AnimatedOpacity(
                                opacity: (value != ChildWindowState.playlist)? 0.0: 1.0,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn,
                                child: IgnorePointer(
                                  // ignore: avoid_bool_literals_in_conditional_expressions
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
              } else {
                return
                  const SizedBox();
            }
        }
      );
    }

  Widget _buildPlaylist() {
    return
      const CurrentPlaylist();
  }

  Widget _buildLyrics() {

    return
      ValueListenableBuilder<SongUrlModel?>(
        valueListenable: _audioManager.currentSongNotifier,
        builder: (_, currentSong, __) {
          return FutureBuilder<List<LyricModel>>(
            future: _audioManager.currentLyricNotifier,
            builder: (context, snapshot) {
              if(snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
              return ValueListenableBuilder<int>(
                valueListenable: _audioManager.lyricIndexNotifier,
                builder: (_, index, __) {
                    return ListLyrics(
                      currentPosition: _audioManager.progressNotifier.value.dragPosition,
                      currentTime: _audioManager.progressNotifier.value.current,
                      onTimeChanged: _audioManager.seek,
                      onPositionChanged: _audioManager.drag,
                      lyrics: snapshot.data!,
                    );
                  }
                );
              }
              else {
                    return
                        const SizedBox();
                  }
                },
              );
            }
          );
  }

  Widget _buildCurrentArtWork() {
    return const CurrentArtWork();
  }

  Widget _buildCurrentSong() {
    return const CurrentSongCard();
  }

  Widget _buildProgessBar() {
    return
      Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
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
    return const LyricButton();
  }

  Widget _buildPlaylistButton() {
    return const PlaylistButton();
  }

  Widget _buldNextSongButton() {
    return NextSongButton();
  }

  Widget _buildManagePlaylist() {
    return
    ValueListenableBuilder<ChildWindowState>(
        valueListenable: _audioManager.childWindowNotifier,
        builder: (_, value, __) {
          return AnimatedOpacity(
              opacity: (value != ChildWindowState.playlist)? 0.0: 1.0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
              child: AbsorbPointer(
                // ignore: avoid_bool_literals_in_conditional_expressions
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
    );
  }
  Widget _buildRepeatButton() {
    return const RepeatButton();
  }

  Widget _buldShuffleButton() {
    return const ShuffleButton();
  }

  Widget _buldPreviousSongButton() {
    return PreviousSongButton();
  }
}