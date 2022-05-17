import 'package:apple_music/components/ContextMenu/ArtistContextMenu.dart';
import 'package:apple_music/components/ContextMenu/ContextMenuManager.dart';
import 'package:apple_music/components/TitleComponent/PageTitleBoxCompact.dart';
import 'package:apple_music/models_refactor/ArtistModel.dart';
import 'package:apple_music/models_refactor/UserModel.dart';
import 'package:apple_music/services/http_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:get_it/get_it.dart';
import '../components/AudioController/AudioPageRouteManager.dart';
import '../components/Other/PageLoadError.dart';
import '../components/RectangleCardSearchPage/ArtistRectangleCard.dart';
// import '../models/ArtistViewModel.dart';
import '../constant.dart';
import 'ArtistPage.dart';

void onTapArtistCard(ArtistModel artistModel) {
  Navigator.push(
   GetIt.I.get<AudioPageRouteManager>().getMainContext(),
    // ignore: inference_failure_on_instance_creation
    MaterialPageRoute(
   builder: (context) =>
    ValueListenableBuilder(
      valueListenable: GetIt.I.get<UserModelNotifier>(),
      builder: (context, _, __) => ArtistView(
        artistViewModel: HttpUtil().fetchArtistModel(
          artist_name: artistModel.artist_name
        )
      )
    ),
  ));
}

const String PAGE_TITLE = 'Nghệ sĩ';

class ArtistSubPage extends StatefulWidget {
  void onTapArtistCardMoreButton(ArtistModel artistModel) {
    GetIt.I.get<ContextMenuManager>().insertOverlay(ArtistContextMenu(artistModel: artistModel));
  }
  const ArtistSubPage({
    Key? key,
    required this.artistlist,
  }) : super(key: key);

  final Future<List<ArtistModel>?> artistlist;
  @override
  State<ArtistSubPage> createState() => _ArtistSubPageState();
}

class _ArtistSubPageState extends State<ArtistSubPage> {


  late ScrollController _scrollController = ScrollController();
  bool lastStatus = true;

  void _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  bool get isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (50);
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
            leading:  IconButton(
                icon:  const Icon(SFSymbols.chevron_left, color:Colors.red),
                onPressed: () {
                  if (kDebugMode) {
                    print('Popped');
                  }
                  Navigator.pop(context);
                }),
            title: Visibility(
                // ignore: avoid_bool_literals_in_conditional_expressions
                visible: isShrink ? true : false,
                child: const Text(PAGE_TITLE,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ))
            ),
            centerTitle: true,
            backgroundColor: isShrink ? Colors.white : Colors.transparent,
            elevation: 0),
        body: FutureBuilder(
          future: widget.artistlist,
          builder: (BuildContext context, AsyncSnapshot<List<ArtistModel>?> snapshot) {
              if (!snapshot.hasData){
                return const Center(child: CircularProgressIndicator(color: Colors.red));
                // return PageLoadError(title: "Lỗi tải danh sách");
              }
              else {
                if (snapshot.data!.isEmpty){
                  return PageLoadError(title: 'Thư viện nghệ sĩ rỗng');
                }
                else {
                  return SingleChildScrollView(
                    controller: _scrollController,
                    child: Padding(
                      padding: const EdgeInsets.only(left: kDefaultPadding),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          const PageTitleBoxCompact(title: PAGE_TITLE),
                          Padding(
                            padding: const EdgeInsets.only(left: kDefaultPadding),
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, i) {
                                return ArtistRectangleCard(
                                  artistModel: snapshot.data![i],
                                  onTapArtistCard: onTapArtistCard,
                                  onTapArtistCardMoreButton: widget.onTapArtistCardMoreButton,
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 150)
                        ],
                      ),
                    ),
                  );
                }
              }
          }
        ),
      );
  }
}
