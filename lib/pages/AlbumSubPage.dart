import 'package:apple_music/components/RectangleCardSearchPage/AlbumRectangleCard.dart';
import 'package:apple_music/components/TitleComponent/PageTitleBoxCompact.dart';
import 'package:apple_music/models/AlbumRectangleCardModel.dart';
import 'package:apple_music/models_refactor/AlbumModel.dart';
import 'package:apple_music/services/http_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:get_it/get_it.dart';
import '../components/AudioController/AudioPageRouteManager.dart';
import '../components/Other/PageLoadError.dart';
import '../constant.dart';
import 'AlbumPage.dart';


void onTapAlbumCard(AlbumModel albumModel) {
  Navigator.push(
      GetIt.I.get<AudioPageRouteManager>().getMainContext(),
      MaterialPageRoute(
        builder: (context) => AlbumView(albumViewModel: HttpUtil().getAlbumModel(album_name: albumModel.album_name, artist_name: albumModel.artist.artist_name),
      )));
}

const String PAGE_TITLE = "Album";

class AlbumSubPage extends StatefulWidget {
  const AlbumSubPage({
    Key? key,
    required this.albumlist
  }) : super(key: key);

  final Future<List<AlbumModel>?> albumlist;
  @override
  State<AlbumSubPage> createState() => _AlbumSubPageState();
}

class _AlbumSubPageState extends State<AlbumSubPage> {


  late ScrollController _scrollController = ScrollController();
  bool lastStatus = true;

  _scrollListener() {
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
                icon:  Icon(SFSymbols.chevron_left, color:Colors.red),
                onPressed: () {
                  print("Popped");
                  Navigator.pop(context);
                }),
            title: Visibility(
                visible: isShrink ? true : false,
                child: Text(PAGE_TITLE,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ))
            ),
            centerTitle: true,
            backgroundColor: isShrink ? Colors.white : Colors.transparent,
            elevation: isShrink ? 1 : 0),
        body: FutureBuilder<List<AlbumModel>?>(
            future: widget.albumlist,
            builder: (BuildContext context, AsyncSnapshot<List<AlbumModel>?> snapshot) {
              if (!snapshot.hasData){
                return PageLoadError(title: "Lỗi tải danh sách");
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
                        PageTitleBoxCompact(title: PAGE_TITLE),
                        Padding(
                          padding: const EdgeInsets.only(left: kDefaultPadding),
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: AlbumModel.getSampleAlbum().length,
                            itemBuilder: (context, i){
                              return  AlbumRectangleCard(albumModel: snapshot.data![i], onTapAlbumCard: onTapAlbumCard);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
          }
        ),
      );
  }
}
