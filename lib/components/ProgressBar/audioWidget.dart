import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';


class AudioWidget extends LeafRenderObjectWidget {
  const AudioWidget({
    Key? key,
    required this.barColor,
    required this.thumbColor,
    required this.thumbSize,
    required this.totalTime,
    required this.controller,
  }) : super(key: key);

  final Color barColor;
  final Color thumbColor;
  final double thumbSize;
  final Duration totalTime;
  final AnimationController? controller;

  @override
  RenderAudioWidget createRenderObject(BuildContext context) {
    return RenderAudioWidget(
      barColor: barColor,
      thumbColor: thumbColor,
      thumbSize: thumbSize,
      controller: controller,
      totalTime: totalTime,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderAudioWidget renderObject) {
    renderObject
        ..barColor = barColor
        ..thumbColor = thumbColor
        ..thumbSize = thumbSize
        ..totalTime = totalTime;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties){
    super.debugFillProperties(properties);
    properties.add(ColorProperty('barColor', barColor));
    properties.add(ColorProperty('thumbColor', thumbColor));
    properties.add(DoubleProperty('thumbSize', thumbSize));
  }
}

class RenderAudioWidget extends RenderBox {
  RenderAudioWidget({
    required Color barColor,
    required Color thumbColor,
    required Duration totalTime,
    required double thumbSize,
    required AnimationController? controller,
  })  : _barColor = barColor,
        _thumbSize = thumbSize,
        _totalTime = totalTime,
        _thumbColor = thumbColor
      {

      // initialize the gesture recognizer
      _drag = HorizontalDragGestureRecognizer()
        ..onStart = (DragStartDetails details) {
          _updateThumbPosition(details.localPosition);
          controller!.forward();
        }
        ..onUpdate = (DragUpdateDetails details) {
          _updateThumbPosition(details.localPosition);
          _updateThumbSize(thumbSize * 2.5);
        }
        ..onEnd = (DragEndDetails details){
          controller!.reverse();
      };
  }

  double _currentThumbValue = 0.5;

  Color get barColor => _barColor;
  Color _barColor;
  set barColor(Color value){
    if (value == _barColor)
      return;
    _barColor = value;
    markNeedsPaint();
  }

  Color get thumbColor => _thumbColor;
  Color _thumbColor;
  set thumbColor(Color value){
    if (value == _thumbColor)
      return;
    _thumbColor = value;
    markNeedsPaint();
  }
  Duration get totalTime => _totalTime;
  Duration _totalTime;
  set totalTime(Duration value){
    if (value == _totalTime)
      return;
    _totalTime = value;
    markNeedsPaint();
  }

  double get thumbSize => _thumbSize;
  double _thumbSize;
  set thumbSize(double value) {
    if (_thumbSize == value)
      return;
    _thumbSize = value;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    size = computeDryLayout(constraints);
  }
  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final desiredWidth = constraints.maxWidth;
    final desiredHeight = 20.0;
    final desiredSize = Size(desiredWidth, desiredHeight);
    return constraints.constrain(desiredSize);
  }

  static const _minDesiredWidth = 100.0;
  @override
  double computeMinIntrinsicWidth(double height) => _minDesiredWidth;
  @override
  double computeMaxIntrinsicWidth(double height) => _minDesiredWidth;
  @override
  double computeMinIntrinsicHeight(double width) => thumbSize;
  @override
  double computeMaxIntrinsicHeight(double width) => thumbSize;


  @override
  void paint(PaintingContext context, Offset offset){
    final canvas = context.canvas;
    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    // paint played bar
    paintPlayedBar(canvas);

    // paint remain bar
    PaintRemainBar(canvas);

    // paint current duration
    PaintCurrentDuration(canvas);

    // paint remain duration
    PaintRemainDuration(canvas);

    // paint thumb
    final thumbPaint = Paint()
      ..color = thumbColor;
    final thumbDx = _currentThumbValue * size.width;
    final center = Offset(thumbDx, size.height / 2);
    canvas.drawCircle(center, thumbSize / 2, thumbPaint);

    canvas.restore();
  }

  void PaintRemainDuration(Canvas canvas) {
    final remainDurationString = _getStringDuration(_getDuration(1.0 - _currentThumbValue));
    TextSpan textSpanRemain = TextSpan(style: TextStyle(color: barColor), text: "- ${remainDurationString}");
    TextPainter textPainter = TextPainter(text: textSpanRemain,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr
    );
    textPainter.layout();
    final remainDuration = Offset(size.width - textPainter.width, size.height);
    textPainter.paint(canvas, remainDuration);
  }

  void PaintCurrentDuration(Canvas canvas) {
    final currentDurationString = _getStringDuration(_getDuration(_currentThumbValue));
    TextSpan textSpanCurrent = TextSpan(style: TextStyle(color: barColor), text: currentDurationString);
    TextPainter textPainter = TextPainter(text: textSpanCurrent,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr
    );
    textPainter.layout();
    final currentDuration = Offset(0, size.height);
    textPainter.paint(canvas, currentDuration);
  }

  void PaintRemainBar(Canvas canvas) {
    final remainBarPaint = Paint()
      ..color = barColor.withOpacity(0.2)
      ..strokeWidth = 3;
    final startDx = _currentThumbValue * size.width;
    final point3 = Offset(startDx, size.height / 2);
    final point4 = Offset(size.width, size.height / 2);
    canvas.drawLine(point3, point4, remainBarPaint);
  }

  void paintPlayedBar(Canvas canvas) {
    final playedBarPaint = Paint()
      ..color = barColor
      ..strokeWidth = 3;
    final EndDx = _currentThumbValue * size.width;
    final point1 = Offset(0, size.height / 2);
    final point2 = Offset(EndDx, size.height / 2);
    canvas.drawLine(point1, point2, playedBarPaint);
  }

  late HorizontalDragGestureRecognizer _drag;

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    assert(debugHandleEvent(event, entry));
    if (event is PointerDownEvent) {
      _drag.addPointer(event);
    }
  }

  void _updateThumbPosition(Offset localPosition) {
    var dx = localPosition.dx.clamp(0, size.width);
    _currentThumbValue = dx / size.width;
    markNeedsPaint();
  }

  void _updateThumbSize(double newThumbSize) {
    if (_thumbSize == newThumbSize) {
      return;
    }
    _thumbSize = newThumbSize;
    markNeedsPaint();
  }

  Duration _getDuration(double thumbValue){
    return Duration(seconds: (_totalTime.inSeconds * thumbValue).toInt());
  }

  String _getStringDuration(Duration duration){
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitHours = twoDigits(duration.inHours.remainder(60));
    twoDigitHours = duration.inHours > 0 ? "${twoDigitHours}:":"";
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigitHours}$twoDigitMinutes:$twoDigitSeconds";
  }

}