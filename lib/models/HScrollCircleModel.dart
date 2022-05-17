import 'package:uuid/uuid.dart';

class HScrollCircleCardModel {
  HScrollCircleCardModel(this._artistName, this._artURL) {
    id = const Uuid().v4();
  }
  final String _artistName;
  final String _artURL;

  late String id;

  String get artistName {
    return _artistName;
  }

  String get artURL {
    return _artURL;
  }

  static List<HScrollCircleCardModel> getSampleData() {
    return [
      HScrollCircleCardModel('Taylor Swift', 'https://is3-ssl.mzstatic.com/image/thumb/Music126/v4/94/95/85/94958532-4e64-f3b3-84b2-f4d207e31c85/21UM1IM25046.rgb.jpg/486x486bb-60.jpg'),
      HScrollCircleCardModel('The Weeknd', 'https://is2-ssl.mzstatic.com/image/thumb/Music126/v4/2f/22/a9/2f22a9a6-5af1-5846-a44e-ba016724ed69/21UM1IM58860.rgb.jpg/486x486bb.webp'),
      HScrollCircleCardModel('Olivia Rodrigo', 'https://is5-ssl.mzstatic.com/image/thumb/Features126/v4/5e/f8/5b/5ef85b6d-1edd-9a96-0a70-fd300b56c4a8/mza_10642029259611882840.png/110x110sr.webp'),
      HScrollCircleCardModel('Ed Sheeran', 'https://is4-ssl.mzstatic.com/image/thumb/Music115/v4/5a/60/84/5a60849d-4fcd-13a6-0715-4621186bab23/pr_source.png/220x220sr-60.jpg'),
      HScrollCircleCardModel('LISA', 'https://is4-ssl.mzstatic.com/image/thumb/Music125/v4/97/ef/7c/97ef7c7a-d8b9-d550-cab9-97b6cacaef33/pr_source.png/220x220sr-60.jpg')
    ];
  }
}
