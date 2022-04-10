import 'package:apple_music/components/ButtonPausePlay/PausePlayButton.dart';
import 'package:apple_music/components/Lyrics/ListLyrics.dart';
import 'package:apple_music/components/LyricsScrollView/LyricsFrame.dart';
import 'package:apple_music/components/ProgressBar/ProgessBarWidget.dart';
import 'package:apple_music/models/LyricModel.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../../services/service_locator.dart';
import 'AudioManager.dart';



class AudioUi extends StatefulWidget {
  AudioUi({
    Key? key,
  }) : super(key: key);

  @override
  State<AudioUi> createState() => _AudioUiState();
}

class _AudioUiState extends State<AudioUi> with WidgetsBindingObserver{
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
    return
      Container(
        color: Color.fromRGBO(21, 45, 75, 0.8235294117647058),
        child: Stack(
          alignment: Alignment.center,
          children:[
            _buildLyrics(),
            _buildProgessBar(),
            _buildButtonPausePlay(),
          ],
        ),
      );
  }

  Widget _buildLyrics(){
    var size = MediaQuery.of(context).size;

    return
      Positioned(
        top: 100.0,
        left: 0,
        // child: LyricsFrame(
        width: size.width,
        height: size.height * 0.65,
        //   blur: 15,
        //   backgroundImagePath: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/Taylor_Swift_2_-_2019_by_Glenn_Francis.jpg/800px-Taylor_Swift_2_-_2019_by_Glenn_Francis.jpg",
        child: Container(
          // child: FutureBuilder<List<Lyric>>(
          //   future: Lyrics.fetchLyrics(lyricUrl),
          //   builder: (BuildContext context, AsyncSnapshot<List<Lyric>> listSnapshot) {
          //     Widget child;
          //     if (listSnapshot.hasData) {
          child :
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
        ),
      );
  }

  Widget _buildProgessBar(){
    return
      Positioned(
        left: 0,
        right: 0,
        bottom: 120.0,
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

  Widget _buildButtonPausePlay(){
    return PausePlayButton();
  }
}