import 'package:apple_music/models_refactor/PlaylistModel.dart';
import 'package:flutter/material.dart';
import 'package:apple_music/constant.dart';
import 'SquareCard.dart';
import 'HScrollSquareConstant.dart';

class RecentlyViewed extends StatefulWidget{
  const RecentlyViewed({
    Key? key,
    required this.playlistlist,
  }) : super(key: key);

  final Future<List<PlaylistModel>?> playlistlist;
  @override
  State<RecentlyViewed> createState() => _RecentlyViewedState();
}

class _RecentlyViewedState extends State<RecentlyViewed> {
  @override
  Widget build(BuildContext context){
    final size = MediaQuery.of(context).size;
    final WIDTH = size.width * RENCENTLY_VIEWED_WIDTH_RATIO;
    return
      FutureBuilder(
        future: widget.playlistlist,
        builder: (BuildContext context, AsyncSnapshot<List<PlaylistModel>?> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator(color: Colors.red));
          }
          else {
            if (snapshot.data!.length == 0){
              return ListView(
                padding: EdgeInsets.only(right:kDefaultPadding),
                shrinkWrap: true,
                children: <Widget>[
                  SizedBox(height:100),
                  Text("Để thêm playlist, hãy chọn một bài hát rồi nhấn Thêm vào playlist", textAlign: TextAlign.center, style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Roboto',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    ))]
              );
            }
            else {
              return GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: kDefaultPadding * 2,
                children: snapshot.data!.map((item) =>
                    SquareCard(
                      imageUrl: item.art_url,
                      name: item.playlist_name,
                      artist: "",
                      id: snapshot.data!.indexOf(item),
                      width: WIDTH,
                      isPlaylist: true,
                      playlistModel: Future.value(item),
                    )
                ).toList(),
              );
            }
          }
        }
        );
  }
}