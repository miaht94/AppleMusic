import 'dart:ui';

class VerticalCardWithTitleModel {
  VerticalCardWithTitleModel(String title, String description, String imagePath, Color footerColor) {
    _title = title;
    _description = description;
    _footerColor = footerColor;
    _imagePath = imagePath;
  }
  late String _title;
  late String _description;
  late Color _footerColor;
  late String _imagePath;
  String get title {
    return _title;
  }

  String get description {
    return _description;
  }

  Color get footerColor {
    return _footerColor;
  }

  String get imagePath {
    return _imagePath;
  }

  void set title(String title) {
    _title = title;
  }

  void set description(String description) {
    _description = description;
  }

  void set footerColor(Color footerColor) {
    _footerColor = footerColor;
  }

  void set imagePath(String imagePath) {
    _imagePath = imagePath;
  }

  static List<VerticalCardWithTitleModel> getSampleData() {
    return 
    [
      new VerticalCardWithTitleModel("Dành cho bạn", "Eve, mikitoP, Yuiko Ohara, fripSize, DAOKO, Hatsune Miku, Takaaki Natsushiro, ...", "https://is2-ssl.mzstatic.com/image/thumb/Features126/v4/28/8f/75/288f7530-80a6-9fa4-2e89-6fd5a1b030a2/U0MtTVMtV1ctVG9kYXlzSGl0cy1NZWdhbl9UaGVlX1N0YWxsaW9uXyZfRHVhX0xpcGEtQURBTV9JRD0xMDEwNDE3ODE2LnBuZw.png/257x257SC.DN01.webp?l=en-GB", Color.fromRGBO(164, 130, 69, 0.6)),
      new VerticalCardWithTitleModel("Dành cho bạn", "Eve, mikitoP, Yuiko Ohara, fripSize, DAOKO, Hatsune Miku, Takaaki Natsushiro, ...", "https://is2-ssl.mzstatic.com/image/thumb/Features126/v4/28/8f/75/288f7530-80a6-9fa4-2e89-6fd5a1b030a2/U0MtTVMtV1ctVG9kYXlzSGl0cy1NZWdhbl9UaGVlX1N0YWxsaW9uXyZfRHVhX0xpcGEtQURBTV9JRD0xMDEwNDE3ODE2LnBuZw.png/257x257SC.DN01.webp?l=en-GB", Color.fromRGBO(164, 130, 69, 0.6)),
      new VerticalCardWithTitleModel("Dành cho bạn", "Eve, mikitoP, Yuiko Ohara, fripSize, DAOKO, Hatsune Miku, Takaaki Natsushiro, ...", "https://is2-ssl.mzstatic.com/image/thumb/Features126/v4/28/8f/75/288f7530-80a6-9fa4-2e89-6fd5a1b030a2/U0MtTVMtV1ctVG9kYXlzSGl0cy1NZWdhbl9UaGVlX1N0YWxsaW9uXyZfRHVhX0xpcGEtQURBTV9JRD0xMDEwNDE3ODE2LnBuZw.png/257x257SC.DN01.webp?l=en-GB", Color.fromRGBO(164, 130, 69, 0.6))
    ];
  }

}