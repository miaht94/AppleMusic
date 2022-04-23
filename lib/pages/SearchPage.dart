import 'package:apple_music/components/HorizontalCard/HorizontalCardConstant.dart';
import 'package:apple_music/components/HorizontalScrollCategory/HorizontalScrollCategory.dart';
import 'package:apple_music/components/RectangleCardSearchPage/AlbumRectangleCard.dart';
import 'package:apple_music/components/RectangleCardSearchPage/ArtistRectangleCard.dart';
import 'package:apple_music/components/RectangleCardSearchPage/PlaylistRectangleCard.dart';
import 'package:apple_music/components/RectangleCardSearchPage/PlaylistRectangleCard.dart';
import 'package:apple_music/components/SearchBar/SearchBar.dart';
import 'package:apple_music/components/SongCardInPlaylist/SongCardInPlaylist.dart';
import 'package:apple_music/components/SongCardInPlaylist/SongCardInPlaylistBigger.dart';
import 'package:apple_music/constant.dart';
import 'package:apple_music/models/AlbumRectangleCardModel.dart';
import 'package:apple_music/models/ArtistRectangleCardModel.dart';
import 'package:apple_music/models/HorizontalScrollCategoryModel.dart';
import 'package:apple_music/models/PlaylistRectangleCardModel.dart';
import 'package:apple_music/models/SearchPageModel.dart';
import 'package:apple_music/models/SongCardInPlaylistModel.dart';
import 'package:apple_music/services/service_locator.dart';
import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:get_it/get_it.dart';
import 'package:loader_overlay/loader_overlay.dart';

class SearchPage extends StatefulWidget {
  SearchPage({
    Key ? key
  }): super(key: key);
  @override
  State < SearchPage > createState() => _SearchPageState();
}

class _SearchPageState extends State < SearchPage > {
  void _initModelForHorizontalScrollCategory() {
    GetIt.I.registerLazySingleton<SearchPageModelNotifier>(() => SearchPageModelNotifier(SearchPageModel()));
  }

  void onTapElementOnHorizontalCate(CategoryModel model) {
    GetIt.I.get<SearchPageModelNotifier>().changeSearchMode(model.id);
  }

  @override
  void initState() {
    // TODO: implement initState
    _initModelForHorizontalScrollCategory();
  }



  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ValueListenableBuilder<SearchPageModel>(
      valueListenable: GetIt.I.get<SearchPageModelNotifier>(),
      builder: (context, searchPageModel, _) =>
      LoaderOverlay(
        child: Container(
          width: screenSize.width,
          height: screenSize.height,
          child: Stack(
            children: [
              Positioned(
                top: 100,
                width: screenSize.width,
                child: 
                LayoutBuilder(
                  builder: ((context, constraints) {
                    if (searchPageModel.searchString != "" && GetIt.I.get<SearchPageModelNotifier>().value.inSearchedMode)
                    return SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                      child: Column(children: [
                        FutureBuilder<List<dynamic>>(
                          builder: (context, snapshot) {
                            
                            if (!snapshot.hasData || snapshot.connectionState != ConnectionState.done) {
                              
                              context.loaderOverlay.show();
                              return Container();
                            } else {
                              String searchMode = GetIt.I.get<SearchPageModelNotifier>().value.searchMode;
                              List<Widget> renderList = [];
                              List<dynamic> data = snapshot.data!;
                              switch(searchMode) {
                                case "song_name":
                                  for (SongCardInPlaylistModel model in data) {
                                    renderList.add(SongCardInPlaylistBigger(songCardInPlaylistModel: model,));
                                  }
                                  break;
                                case "artist_name":
                                  for (ArtistRectangleCardModel model in data) {
                                    renderList.add(ArtistRectangleCard(artistRectangleCardModel: model,));
                                  }
                                  break;
                                case "album_name":
                                  for (AlbumRectangleCardModel model in data) {
                                    renderList.add(AlbumRectangleCard(albumRectangleCardModel: model,));
                                  }
                                  break;

                                case "playlist_name":
                                  for (PlaylistRectangleCardModel model in data) {
                                    renderList.add(PlaylistRectangleCard(playlistRectangleCardModel: model,));
                                  }
                                  break;
                              }
                              
                              
                              context.loaderOverlay.hide();
                              return Center(child: Column(children: renderList));
                            }
                              
                          },
                          future: GetIt.I.get<SearchPageModelNotifier>().value.queryResult!,
                        )
                      ]),
                    ); else return Center(child: Text("ADADAD"),);
                  })
                )
              ),
              Positioned(
                // top: 0,
                // left: 0,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // SizedBox(height: kDefaultPadding * 6),
                    Container(
                      width: screenSize.width,
                      padding: EdgeInsets.symmetric(horizontal: kDefaultCardPadding),
                      height: 50,
                      child: SearchBar(onSubmitSearchBar: (String query) {
                        print("Submited ${query}");
                        GetIt.I.get<SearchPageModelNotifier>().changeSearchString(query);
                      }),
                      decoration: BoxDecoration(
                        color: Colors.white
                      ),
                    ),
                    ValueListenableBuilder<HorizontalScrollCategoryModel>(
                      valueListenable: searchPageModel.horizontalScrollCategoryModelNotifier,
                      builder:(context, horizontalScrollCategoryModel, child) => HorizontalScrollCategory(horizontalScrollCategoryModel: horizontalScrollCategoryModel, onTapElement: onTapElementOnHorizontalCate,)
                    )  
                  ], ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}