import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
// ignore: must_be_immutable
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
  double ? blur = 0;
  double ? headerOpacity = 1;
  double ? footerOpacity = 1;
  double ? headerHeightFraction = 0.2;
  double ? footerHeightFraction = 0.3;
  double ? childTopAlignFraction = 0;
  String backgroundImagePath;
  @override
  RenderObject createRenderObject(BuildContext context) {
    final LyricsFrameRender renderObject = LyricsFrameRender(context, backgroundImagePath);
    updateRenderObject(context, renderObject);
    return renderObject;
  }

  @override
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

  set backgroundImagePath(String backgroundImagePath) {
    _backgroundImagePath = backgroundImagePath;
    getImageInfoFromNetwork(_backgroundImagePath);
  }

  double get childTopAlignFraction {
    return _childTopAlignFraction;
  }

  set childTopAlignFraction(double childTopAlignFraction) {
    assert(childTopAlignFraction <= 1 && childTopAlignFraction >= -1, 'Align must be between -1 and 1');
    _childTopAlignFraction = childTopAlignFraction;
    markNeedsPaint();
  }

  double get footerHeightFraction {
    return _footerHeightFraction;
    
  }

  set footerHeightFraction(double footerHeightFraction) {
    assert(footerHeightFraction <= 1.0 && footerHeightFraction >= 0.0);
    _footerHeightFraction = footerHeightFraction;
    markNeedsPaint();
  }

  double get headerHeightFraction {
    return _headerHeightFraction;
  }

  set headerHeightFraction(double headerHeightFraction) {
    assert(headerHeightFraction <= 1.0 && headerHeightFraction >= 0.0);
    _headerHeightFraction = headerHeightFraction;
    markNeedsPaint();
  }

  double get blur {
    return _blur;
  }

  set blur(double blur) {
    assert(blur >= 0.0);
    _blur = blur;
    markNeedsPaint();
  }

  double get headerOpacity {
    return _headerOpacity;
  }

  set headerOpacity(double headerOpacity) {
    assert(headerOpacity <= 1 && headerOpacity >= 0);
    _headerOpacity = headerOpacity;
    markNeedsPaint();
  }

  double get footerOpacity {
    return _footerOpacity;
  }

  set footerOpacity(double footerOpacity) {
    assert(footerOpacity <= 1 && footerOpacity >= 0);
    _footerOpacity = footerOpacity;
    markNeedsPaint();
  }

  double get height {
    return _height;
  }

  set height(double height) {
    _height = height;
    markNeedsLayout();
    markNeedsPaint();
  }

  double get width {
    return _width;
  }

  set width(double width) {
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
  // ignore: avoid_void_async
  void getImageInfo() async {
    final ByteData bytes = await rootBundle.load('assets/images/TaylorRectangle.png');
    image = await loadImage(Uint8List.view(bytes.buffer));
  }

  // ignore: always_declare_return_types, inference_failure_on_function_return_type
  getImageInfoFromNetwork(String backgroundImagePath) async {
    if (backgroundImagePath == '') {
      backgroundImagePath = 'https://media.2dep.vn/upload/thucquyen/2021/11/25/ro-tin-taylor-swift-an-trua-voi-tai-tu-gong-yoo-ngay-hop-tac-khong-con-xa-1637805528-1.jpg';
    }
    final Uri uri = Uri.parse(backgroundImagePath);
    final http.Response res = await http.get(uri);
    image = await loadImage(res.bodyBytes);
  }

  Future < ui.Image > loadImage(Uint8List img) async {
    final Completer < ui.Image > completer = Completer();
    ui.decodeImageFromList(img, completer.complete);
    return completer.future;
  }

  @override
  void performLayout() {
    size = constraints.constrainDimensions(width, height);
       final BoxConstraints childConstrain = BoxConstraints(
      maxWidth: size.width,
      maxHeight: size.height,
    );
    child!.layout(childConstrain);
  
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null) {
      return;
    }
    final Offset offsetOrigin = offset;
    offset = Offset(offset.dx - 20, offset.dy - 20);
    final Size sizeOrigin = this.size;
    final Size size = Size(this.size.width + 40, this.size.height + 40);
    final ImageFilterLayer layerFront1 = ImageFilterLayer(imageFilter: ui.ImageFilter.blur(sigmaX: blur, sigmaY: blur, tileMode: ui.TileMode.decal));

    context.pushClipRect(needsCompositing, offsetOrigin, Offset.zero & sizeOrigin, (context, offset_) { 
      if (_image != null) {
      final double imageWidth = _image!.width.toDouble();
      final double imageHeight = _image!.height.toDouble();
      bool fitWidth = false;
      if (imageWidth / imageHeight < size.width / size.height) {
        fitWidth = true;
      }
      final Rect imageClip = Rect.fromCenter(center: Offset(imageWidth / 2, imageHeight / 2), width: fitWidth ? imageWidth : imageHeight * size.width / size.height, height: fitWidth ? imageWidth * size.height / size.width : imageHeight);
      final Paint painter = Paint()..color = const Color.fromARGB(255, 0, 0, 0)..blendMode = BlendMode.srcOver;
      // ignore: cascade_invocations
      painter.imageFilter = ui.ImageFilter.blur(sigmaX: blur*0.8, sigmaY: blur*0.8, tileMode: ui.TileMode.decal);
      context.canvas.drawImageRect(_image!, imageClip, offset & size, painter);
      context.canvas.drawRect(Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height), painter..color = const ui.Color.fromARGB(134, 0, 0, 0) ..imageFilter = ui.ImageFilter.blur(sigmaX: blur*0.8, sigmaY: blur*0.8));
      context.paintChild(child!, offsetOrigin);
      // ignore: cascade_invocations
      context.pushLayer(layerFront1, (context_, offset_) {
        final Paint painter = Paint()..color = const ui.Color.fromARGB(255, 0, 0, 0)..blendMode = BlendMode.srcOver;
        context_.canvas.drawImageRect(_image!, Rect.fromLTWH(imageClip.left, imageClip.top, imageClip.width, imageClip.height * headerHeightFraction), Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height * headerHeightFraction), painter);
        context_.canvas.drawRect(Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height * headerHeightFraction), painter..color = const ui.Color.fromARGB(130, 0, 0, 0) );
        painter..color = const ui.Color.fromARGB(255, 0, 0, 0) ..blendMode = BlendMode.srcOver;
        context_.canvas.drawImageRect(_image!, Rect.fromLTWH(imageClip.left, imageClip.top + imageClip.height * (1 - footerHeightFraction), imageClip.width, imageClip.height * footerHeightFraction), Rect.fromLTWH(offset.dx, offset.dy + size.height * (1 - footerHeightFraction), size.width, size.height * footerHeightFraction), painter);
        context_.canvas.drawRect(Rect.fromLTWH(offset.dx, offset.dy + size.height * (1 - footerHeightFraction), size.width, size.height * footerHeightFraction), painter..color = const ui.Color.fromARGB(130, 0, 0, 0) );
      }, offset);
    }
    });
    
  }
}