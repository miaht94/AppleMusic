import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
class LyricsFrame extends SingleChildRenderObjectWidget {
  LyricsFrame({
    Key ? key,
    Widget ? child,
    required this.width,
    required this.height,
    required this.backgroundImagePath,
    this.blur,
    this.headerOpacity,
    this.footerOpacity,
    this.headerHeightFraction,
    this.footerHeightFraction,
    this.childTopAlignFraction,
  }): super(key: key, child: child);
  double width;
  double height;
  double ? blur = 0.0;
  double ? headerOpacity = 1;
  double ? footerOpacity = 1;
  double ? headerHeightFraction = 0.2;
  double ? footerHeightFraction = 0.3;
  double ? childTopAlignFraction = 0;
  String backgroundImagePath;
  @override
  RenderObject createRenderObject(BuildContext context) {
    LyricsFrameRender renderObject = LyricsFrameRender(context, backgroundImagePath);
    updateRenderObject(context, renderObject);
    return renderObject;
  }

  void updateRenderObject(BuildContext context, LyricsFrameRender renderObject) {
    renderObject..width = width..height = height..headerOpacity = headerOpacity ?? 1..footerOpacity = footerOpacity ?? 1..blur = blur ?? 0.0
    ..footerHeightFraction = footerHeightFraction?? 0.3 ..headerHeightFraction = headerHeightFraction ?? 0.25
    ..childTopAlignFraction = childTopAlignFraction?? 0
    ..backgroundImagePath = backgroundImagePath;
  }
}

class LyricsFrameRender extends RenderProxyBox {
  LyricsFrameRender(this.buildContext, this._backgroundImagePath) {
    getImageInfoFromNetwork(_backgroundImagePath);
  }
  BuildContext buildContext;
  ui.Image ? _image;
  late double _width;
  late double _height;
  late double _headerOpacity;
  late double _footerOpacity;
  late double _blur;
  late double _headerHeightFraction;
  late double _footerHeightFraction;
  late double _childTopAlignFraction;
  late String _backgroundImagePath;

  String get backgroundImagePath {
    return _backgroundImagePath;
  }

  void set backgroundImagePath(String backgroundImagePath) {
    _backgroundImagePath = backgroundImagePath;
    getImageInfoFromNetwork(_backgroundImagePath);
  }

  double get childTopAlignFraction {
    return _childTopAlignFraction;
  }

  void set childTopAlignFraction(double childTopAlignFraction) {
    assert(childTopAlignFraction <= 1 && childTopAlignFraction >= -1, "Align must be between -1 and 1");
    _childTopAlignFraction = childTopAlignFraction;
    markNeedsPaint();
  }

  double get footerHeightFraction {
    return _footerHeightFraction;
    
  }

  void set footerHeightFraction(double footerHeightFraction) {
    assert(footerHeightFraction <= 1.0 && footerHeightFraction >= 0.0);
    _footerHeightFraction = footerHeightFraction;
    markNeedsPaint();
  }

  double get headerHeightFraction {
    return _headerHeightFraction;
  }

  void set headerHeightFraction(double headerHeightFraction) {
    assert(headerHeightFraction <= 1.0 && headerHeightFraction >= 0.0);
    _headerHeightFraction = headerHeightFraction;
    markNeedsPaint();
  }

  double get blur {
    return _blur;
  }

  void set blur(double blur) {
    assert(blur >= 0.0);
    _blur = blur;
    markNeedsPaint();
  }

  double get headerOpacity {
    return _headerOpacity;
  }

  void set headerOpacity(double headerOpacity) {
    assert(headerOpacity <= 1 && headerOpacity >= 0);
    _headerOpacity = headerOpacity;
    markNeedsPaint();
  }

  double get footerOpacity {
    return _footerOpacity;
  }

  void set footerOpacity(double footerOpacity) {
    assert(footerOpacity <= 1 && footerOpacity >= 0);
    _footerOpacity = footerOpacity;
    markNeedsPaint();
  }

  double get height {
    return _height;
  }

  void set height(double height) {
    _height = height;
    markNeedsLayout();
    markNeedsPaint();
  }

  double get width {
    return _width;
  }

  void set width(double width) {
    _width = width;
    markNeedsLayout();
    markNeedsPaint();
  }
  set image(ui.Image ? image) {
    _image = image;
    markNeedsPaint();
    // markNeedsLayout();
  }
  ui.Image ? get image {
    return _image;
  }
  void getImageInfo() async {
    ByteData bytes = await rootBundle.load("assets/images/TaylorRectangle.png");
    image = await loadImage(Uint8List.view(bytes.buffer));
  }

  getImageInfoFromNetwork(String backgroundImagePath) async {
    if (backgroundImagePath == "")
      backgroundImagePath = "https://media.2dep.vn/upload/thucquyen/2021/11/25/ro-tin-taylor-swift-an-trua-voi-tai-tu-gong-yoo-ngay-hop-tac-khong-con-xa-1637805528-1.jpg";
    Uri uri = Uri.parse(backgroundImagePath);
    http.Response res = await http.get(uri);
    image = await loadImage(res.bodyBytes);
  }

  Future < ui.Image > loadImage(Uint8List img) async {
    final Completer < ui.Image > completer = Completer();
    ui.decodeImageFromList(img, (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }

  @override
  void performLayout() {
    // print(constraints);
    size = constraints.constrainDimensions(width, height);
    // size = Size(width + 20, height + 20);
    // size = constraints.biggest;
    BoxConstraints childConstrain = BoxConstraints(
      maxWidth: size.width,
      minWidth: 0,
      // minHeight: height * (1 - headerHeightFraction - footerHeightFraction + (headerHeightFraction + footerHeightFraction) * 0.5),
      // maxHeight: height * (1 - headerHeightFraction - footerHeightFraction + (headerHeightFraction + footerHeightFraction) * 0.5)
      minHeight: 0,
      maxHeight: size.height,
      // maxHeight: size.height - childTopAlignFraction * size.height - headerHeightFraction*0.7*size.height - footerHeightFraction*0.7*size.height
    );
    child!.layout(childConstrain);
  
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null) return;
    Offset offsetOrigin = offset;
    offset = Offset(offset.dx - 20, offset.dy - 20);
    Size sizeOrigin = this.size;
    Size size = Size(this.size.width + 40, this.size.height + 40);
    Paint painter = Paint()..color = Colors.black..blendMode = BlendMode.srcOver;
    ImageFilterLayer layerFront1 = ImageFilterLayer(imageFilter: ui.ImageFilter.blur(sigmaX: blur, sigmaY: blur, tileMode: ui.TileMode.decal));
    ImageFilterLayer layerFront2 = ImageFilterLayer(imageFilter: ui.ImageFilter.blur(sigmaX: blur, sigmaY: blur, tileMode: ui.TileMode.decal));
    ImageFilterLayer layerBack = ImageFilterLayer(imageFilter: ui.ImageFilter.blur(sigmaX: blur, sigmaY: blur, tileMode: ui.TileMode.decal));
    // BackdropFilterLayer backdropFilterLayer = BackdropFilterLayer(filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur ));

    context.pushClipRect(needsCompositing, offsetOrigin, Offset.zero & sizeOrigin, (context, offset_) { 
      if (_image != null) {
      double imageWidth = _image!.width.toDouble();
      double imageHeight = _image!.height.toDouble();
      bool fitWidth = false;
      if (imageWidth / imageHeight < size.width / size.height) {
        fitWidth = true;
      }
      Rect imageClip = Rect.fromCenter(center: Offset(imageWidth / 2, imageHeight / 2), width: fitWidth ? imageWidth : imageHeight * size.width / size.height, height: fitWidth ? imageWidth * size.height / size.width : imageHeight);
      // context.canvas.drawImageRect(_image!, imageClip, Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height), painter);
       // Backdrop blur background
      // context.pushLayer(backdropFilterLayer, (context, offset) { }, offset);
      Paint painter = Paint()..color = Color.fromARGB(255, 0, 0, 0)..blendMode = BlendMode.srcOver;
      painter.imageFilter = ui.ImageFilter.blur(sigmaX: blur*0.8, sigmaY: blur*0.8, tileMode: ui.TileMode.decal);
      context.canvas.drawImageRect(_image!, imageClip, offset & size, painter);
      context.canvas.drawRect(Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height), painter..color = ui.Color.fromARGB(134, 0, 0, 0) ..imageFilter = ui.ImageFilter.blur(sigmaX: blur*0.8, sigmaY: blur*0.8, tileMode: ui.TileMode.clamp));
      context.paintChild(child!, offsetOrigin);
      context.pushLayer(layerFront1, (context_, offset_) {
        Paint painter = Paint()..color = ui.Color.fromARGB(255, 0, 0, 0)..blendMode = BlendMode.srcOver;
        context_.canvas.drawImageRect(_image!, Rect.fromLTWH(imageClip.left, imageClip.top, imageClip.width, imageClip.height * headerHeightFraction), Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height * headerHeightFraction), painter);
        context_.canvas.drawRect(Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height * headerHeightFraction), painter..color = ui.Color.fromARGB(130, 0, 0, 0) );
        painter..color = ui.Color.fromARGB(255, 0, 0, 0) ..blendMode = BlendMode.srcOver;
        context_.canvas.drawImageRect(_image!, Rect.fromLTWH(imageClip.left, imageClip.top + imageClip.height * (1 - footerHeightFraction), imageClip.width, imageClip.height * footerHeightFraction), Rect.fromLTWH(offset.dx, offset.dy + size.height * (1 - footerHeightFraction), size.width, size.height * footerHeightFraction), painter);
        context_.canvas.drawRect(Rect.fromLTWH(offset.dx, offset.dy + size.height * (1 - footerHeightFraction), size.width, size.height * footerHeightFraction), painter..color = ui.Color.fromARGB(130, 0, 0, 0) );
      }, offset);
    }
    });
    
  }
}