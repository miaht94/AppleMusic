import 'package:apple_music/components/TitleComponent/PageTitleBoxCompact.dart';
import 'package:apple_music/models_refactor/ArtistModel.dart';
import 'package:apple_music/services/http_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:get_it/get_it.dart';
import '../components/AudioController/AudioPageRouteManager.dart';
import '../components/RectangleCardSearchPage/ArtistRectangleCard.dart';
import '../models/ArtistRectangleCardModel.dart';
// import '../models/ArtistViewModel.dart';
import '../constant.dart';
import 'ArtistPage.dart';

void onTapArtistCard(ArtistModel artistModel) {
  Navigator.push(
   GetIt.I.get<AudioPageRouteManager>().getMainContext(),
    MaterialPageRoute(
   builder: (context) => ArtistView(artistViewModel: HttpUtil().fetchArtistModel(artist_name: artistModel.artist_name)),
  ));
}

const String PAGE_TITLE = "Nghệ sĩ";

class ArtistSubPage extends StatefulWidget {
  const ArtistSubPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ArtistSubPage> createState() => _ArtistSubPageState();
}

class _ArtistSubPageState extends State<ArtistSubPage> {


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
            elevation: 0),
        body: SingleChildScrollView(
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
                      itemCount: ArtistModel.getSampleArtist().length,
                      itemBuilder: (context, i){
                        return  ArtistRectangleCard(artistModel: ArtistModel.getSampleArtist()[i], onTapArtistCard: onTapArtistCard);
                      },
                    ),
                  ),
                ],
              ),
            ),
        ),
      );
  }
}
