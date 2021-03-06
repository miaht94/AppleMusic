import 'package:apple_music/components/AudioController/AudioManager.dart';
import 'package:apple_music/components/ContextMenu/AlbumContextMenu.dart';
import 'package:apple_music/components/ContextMenu/ArtistContextMenu.dart';
import 'package:apple_music/components/ContextMenu/ContextMenuManager.dart';
import 'package:apple_music/components/ContextMenu/PlaylistContextMenu.dart';
import 'package:apple_music/components/ContextMenu/SongContextMenu.dart';
import 'package:apple_music/components/HorizontalCard/HorizontalCardConstant.dart';
import 'package:apple_music/components/HorizontalScrollCategory/HorizontalScrollCategory.dart';
import 'package:apple_music/components/RectangleCardSearchPage/AlbumRectangleCard.dart';
import 'package:apple_music/components/RectangleCardSearchPage/ArtistRectangleCard.dart';
import 'package:apple_music/components/RectangleCardSearchPage/PlaylistRectangleCard.dart';
import 'package:apple_music/components/SearchBar/SearchBar.dart';
import 'package:apple_music/components/SongCardInPlaylist/SongCardInPlaylistBigger.dart';
import 'package:apple_music/constant.dart';
import 'package:apple_music/models/HorizontalScrollCategoryModel.dart';
import 'package:apple_music/models/SearchPageModel.dart';
import 'package:apple_music/models_refactor/AlbumModel.dart';
import 'package:apple_music/models_refactor/ArtistModel.dart';
import 'package:apple_music/models_refactor/PlaylistModel.dart';
import 'package:apple_music/models_refactor/SongModel.dart';
import 'package:apple_music/pages/AlbumPage.dart';
import 'package:apple_music/pages/ArtistPage.dart';
import 'package:apple_music/pages/PlaylistPage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:loader_overlay/loader_overlay.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    Key ? key
  }): super(key: key);
  @override
  State < SearchPage > createState() => _SearchPageState();
}

class _SearchPageState extends State < SearchPage > {
  BuildContext? _context;
  void _initModelForHorizontalScrollCategory() {
    if (!GetIt.I.isRegistered<SearchPageManager>()) {
      GetIt.I.registerLazySingleton<SearchPageManager>(() => SearchPageManager(SearchPageModel()));
    }
  }

  void onTapElementOnHorizontalCate(CategoryModel model) {
    GetIt.I.get<SearchPageManager>().changeSearchMode(model.id);
  }

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    _initModelForHorizontalScrollCategory();
  }

  void onTapSongCardMoreButton(SongModel songModel) {
    GetIt.I.get<ContextMenuManager>().insertOverlay(SongContextMenu(songModel: songModel));
    
  }

  void onTapSongCard(SongModel songCardInPlaylistModel) {
    GetIt.I.get<AudioManager>().addAndPlayASong(songCardInPlaylistModel.id);
  }

  void onTapArtistCard(ArtistModel artistModel) {
    // ignore: inference_failure_on_instance_creation
    Navigator.of(_context!).push(MaterialPageRoute(builder: (context) => ArtistView(artistViewModel: Future.value(artistModel))));
  }

  void onTapArtistCardMoreButton(ArtistModel artistModel) {
    GetIt.I.get<ContextMenuManager>().insertOverlay(ArtistContextMenu(artistModel: artistModel));
  }

  void onTapAlbumCard(AlbumModel albumModel) {
    // ignore: inference_failure_on_instance_creation
    Navigator.of(_context!).push(MaterialPageRoute(builder: (context) => AlbumView(albumViewModel: Future.value(albumModel))));
  }

  void onTapAlbumMoreButton(AlbumModel albumModel) {
    GetIt.I.get<ContextMenuManager>().insertOverlay(AlbumContextMenu(albumViewModel: albumModel));
  }

  void onTapPlaylistCard(PlaylistModel playlistModel) {
    // ignore: inference_failure_on_instance_creation
    Navigator.of(_context!).push(MaterialPageRoute(builder: (context) => PlaylistView(playlistModel: Future.value(playlistModel))));
  }

  void onTapPlaylistMoreButton(PlaylistModel playlistModel) {
     GetIt.I.get<ContextMenuManager>().insertOverlay(PlaylistContextMenu(playlistModel: playlistModel));
  }

  

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    _context = context;
    return ValueListenableBuilder<SearchPageModel>(
      valueListenable: GetIt.I.get<SearchPageManager>(),
      builder: (context, searchPageModel, _) =>
      LoaderOverlay(
        child: Container(
          width: screenSize.width,
          height: screenSize.height,
          child: Stack(
            children: [
              Positioned(
                top: 150,
                width: screenSize.width,
                height: screenSize.height - 150,
                child: 
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (searchPageModel.searchString != '' && GetIt.I.get<SearchPageManager>().value.inSearchedMode) {
                      return FutureBuilder<dynamic>(
                        builder: (context, snapshot) {
                          
                          if (!snapshot.hasData || snapshot.connectionState != ConnectionState.done) {
                            
                            context.loaderOverlay.show();
                            return Container();
                          } else {
                            final String searchMode = GetIt.I.get<SearchPageManager>().value.searchMode;
                            final List<Widget> renderList = [];
                            final List<dynamic> data = snapshot.data!;
                            switch(searchMode) {
                              case 'song_name':
                                for (final SongModel model in data) {
                                  renderList.add(SongCardInPlaylistBigger(songModel: model, onTapSongCardMoreButton: onTapSongCardMoreButton, onTapSongCardInPlaylist: onTapSongCard,));
                                }
                                renderList.add(const SizedBox(height: 120));
                                break;
                              case 'artist_name':
                                for (final ArtistModel model in data) {
                                  renderList.add(ArtistRectangleCard(artistModel: model, onTapArtistCard: onTapArtistCard, onTapArtistCardMoreButton: onTapArtistCardMoreButton));
                                }
                                renderList.add(const SizedBox(height: 120));
                                break;
                              case 'album_name':
                                for (final AlbumModel model in data) {
                                  renderList.add(AlbumRectangleCard(albumModel: model, onTapAlbumMoreButton: onTapAlbumMoreButton, onTapAlbumCard: onTapAlbumCard,));
                                }
                                renderList.add(const SizedBox(height: 120));
                                break;

                              case 'playlist_name':
                                for (final PlaylistModel model in data) {
                                  renderList.add(PlaylistRectangleCard(playlistModel: model, onTapPlaylistCard: onTapPlaylistCard, onTapPlaylistMoreButton: onTapPlaylistMoreButton));
                                  // ignore: cascade_invocations
                                  renderList.add(const SizedBox(height: kDefaultPadding));
                                }
                                renderList.add(const SizedBox(height: 120));
                                break;
                            }
                            
                            
                            context.loaderOverlay.hide();
                            return ListView(
                              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                              children: renderList
                            );
                          }
                            
                        },
                        future: GetIt.I.get<SearchPageManager>().value.queryResult!,
                      );
                    } else {
                      return const Center(child: Text('Hi???n ch??a c?? k???t qu??? n??o'),);
                    }
                  }
                )
              ),
              Positioned(
                // top: 0,
                // left: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    // const Padding(padding: EdgeInsets.only(left: kDefaultPadding),child: Text('T??m Ki???m', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold), textAlign: TextAlign.left,)),
                    // // SizedBox(height: kDefaultPadding * 6),
                    Container(
                      width: screenSize.width,
                      padding: const EdgeInsets.symmetric(horizontal: kDefaultCardPadding),
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white
                      ),
                      child: SearchBar(onSubmitSearchBar: (String query) {
                        if (kDebugMode) {
                          print('Submited $query');
                        }
                        GetIt.I.get<SearchPageManager>().changeSearchString(query);
                      }),
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