// ignore_for_file: inference_failure_on_uninitialized_variable

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'ProgressBarConstant.dart';


// ignore: duplicate_ignore
class ProgressBarObject extends LeafRenderObjectWidget {
  const ProgressBarObject({
    Key? key,
    required this.barColor,
    required this.thumbColor,
    required this.thumbSize,
    required this.totalTime,
    required this.currentTime,
    required this.controller,
    required this.onTimeChanged,
    required this.onPositionChanged,

  }) : super(key: key);

  final Color barColor;
  final Color thumbColor;
  final double thumbSize;
  final Duration totalTime;
  final Duration currentTime;
  final AnimationController? controller;
  // ignore: prefer_typing_uninitialized_variables,
  final onTimeChanged;
  // ignore: prefer_typing_uninitialized_variables
  final onPositionChanged;

  @override
  RenderProgessBarObject createRenderObject(BuildContext context) {
    return RenderProgessBarObject(
      barColor: barColor,
      thumbColor: thumbColor,
      thumbSize: thumbSize,
      controller: controller,
      totalTime: totalTime,
      currentTime: currentTime,
      onTimeChanged: onTimeChanged,
      onPositionChanged: onPositionChanged,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderProgessBarObject renderObject) {
    renderObject
        ..barColor = barColor
        ..thumbColor = thumbColor
        ..thumbSize = thumbSize
        ..totalTime = totalTime
        ..currentTime = currentTime;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties){
    super.debugFillProperties(properties);
    properties.add(ColorProperty('barColor', barColor));
    // ignore: cascade_invocations
    properties.add(ColorProperty('thumbColor', thumbColor));
    // ignore: cascade_invocations
    properties.add(DoubleProperty('thumbSize', thumbSize));
  }
}

class RenderProgessBarObject extends RenderBox {
  RenderProgessBarObject({
    required Color barColor,
    required Color thumbColor,
    required Duration totalTime,
    required double thumbSize,
    required AnimationController? controller,
    required Duration currentTime,
    // ignore: inference_failure_on_untyped_parameter
    required onTimeChanged,
    // ignore: inference_failure_on_untyped_parameter
    required onPositionChanged,

  })  : _barColor = barColor,
        _thumbSize = thumbSize,
        _totalTime = totalTime,
        _currentTime = currentTime,
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
          _updateThumbSize(thumbSize * ON_CLICK_THUMB_SIZE_RATIO);
          onPositionChanged(_getDuration(_currentThumbValue));
        }
        ..onEnd = (DragEndDetails details){
          controller!.reverse();
          _updateCurrentTime();
          onTimeChanged(_currentTime);
      };

      _tap = TapGestureRecognizer()..onTapUp = (TapUpDetails details){
        _updateThumbPosition(details.localPosition);
        onPositionChanged(_getDuration(_currentThumbValue));
        _updateCurrentTime();
        onTimeChanged(_currentTime);
      };
  }

  double _currentThumbValue = 0;

  Color get barColor => _barColor;
  Color _barColor;

  Duration get currentTime => _currentTime;
  Duration _currentTime;
  set currentTime(Duration value){
    if (value == _currentTime) {
      return;
    }
    _currentTime = value;
    _currentThumbValue = _getCurrentPosition();

    markNeedsPaint();
  }

  set barColor(Color value){
    if (value == _barColor) {
      return;
    }
    _barColor = value;
    markNeedsPaint();
  }

  Color get thumbColor => _thumbColor;
  Color _thumbColor;
  set thumbColor(Color value){
    if (value == _thumbColor) {
      return;
    }
    _thumbColor = value;
    markNeedsPaint();
  }

  Duration get totalTime => _totalTime;
  Duration _totalTime;
  set totalTime(Duration value){
    if (value == _totalTime) {
      return;
    }
    _totalTime = value;
    markNeedsPaint();
  }

  double get thumbSize => _thumbSize;
  double _thumbSize;
  set thumbSize(double value) {
    if (_thumbSize == value) {
      return;
    }
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
    const desiredHeight = DESIRED_HEIGHT;
    final desiredSize = Size(desiredWidth, desiredHeight);
    return constraints.constrain(desiredSize);
  }

  static const _minDesiredWidth = MIN_DESIRED_WIDTH;
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
    // ignore: cascade_invocations
    canvas.save();
    // ignore: cascade_invocations
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

    // ignore: cascade_invocations
    canvas.restore();
  }

  // ignore: non_constant_identifier_names
  void PaintRemainDuration(Canvas canvas) {
    final remainDurationString = _getStringDuration(_getDuration(1.0 - _currentThumbValue));
    final TextSpan textSpanRemain = TextSpan(style: TextStyle(color: barColor), text: '- $remainDurationString');
    final TextPainter textPainter = TextPainter(text: textSpanRemain,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr
    );
    // ignore: cascade_invocations
    textPainter.layout();
    final remainDuration = Offset(size.width - textPainter.width, size.height);
    textPainter.paint(canvas, remainDuration);
  }

  // ignore: non_constant_identifier_names
  void PaintCurrentDuration(Canvas canvas) {
    final currentDurationString = _getStringDuration(_getDuration(_currentThumbValue));
    final TextSpan textSpanCurrent = TextSpan(style: TextStyle(color: barColor), text: currentDurationString);
    final TextPainter textPainter = TextPainter(text: textSpanCurrent,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr
    );
    // ignore: cascade_invocations
    textPainter.layout();
    final currentDuration = Offset(0, size.height);
    textPainter.paint(canvas, currentDuration);
  }

  // ignore: non_constant_identifier_names
  void PaintRemainBar(Canvas canvas) {
    final remainBarPaint = Paint()
      ..color = barColor.withOpacity(REMAIN_BAR_OPACITY)
      ..strokeWidth = STROKE_WIDTH;
    final startDx = (!_currentThumbValue.isNaN) ? _currentThumbValue * size.width : 0.0;
    final point3 = Offset(startDx, size.height / 2);
    final point4 = Offset(size.width, size.height / 2);
    canvas.drawLine(point3, point4, remainBarPaint);
  }

  void paintPlayedBar(Canvas canvas) {
    final playedBarPaint = Paint()
      ..color = barColor
      ..strokeWidth = STROKE_WIDTH;
    final endDx = (!_currentThumbValue.isNaN) ? _currentThumbValue * size.width : 0.0;
    final point1 = Offset(0, size.height / 2);
    final point2 = Offset(endDx, size.height / 2);
    canvas.drawLine(point1, point2, playedBarPaint);
  }

  late HorizontalDragGestureRecognizer _drag;
  late TapGestureRecognizer _tap;

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    assert(debugHandleEvent(event, entry));
    if (event is PointerDownEvent) {
      _drag.addPointer(event);
      _tap.addPointer(event);
    }

  }

  void _updateThumbPosition(Offset localPosition) {
    final dx = localPosition.dx.clamp(0, size.width);
    _currentThumbValue = dx / size.width;
    markNeedsPaint();
  }

  void _updateCurrentTime() {
    _currentTime = _getDuration(_currentThumbValue);
  }

  void _updateThumbSize(double newThumbSize) {
    if (_thumbSize == newThumbSize) {
      return;
    }
    _thumbSize = newThumbSize;
    markNeedsPaint();
  }

  Duration _getDuration(double thumbValue){
    if(_totalTime.inSeconds.isFinite && thumbValue.isFinite){
      return Duration(seconds: (_totalTime.inSeconds * thumbValue).toInt());
    }
    return const Duration();
  }

  String _getStringDuration(Duration duration){
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitHours = twoDigits(duration.inHours.remainder(60));
    twoDigitHours = duration.inHours > 0 ? '$twoDigitHours:':'';
    final String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    // ignore: prefer_single_quotes
    return "$twoDigitHours$twoDigitMinutes:$twoDigitSeconds";
  }

  double _getCurrentPosition() {
    // ignore: unnecessary_null_comparison
    if (_currentTime == null) {
      return 0;
    }
    return _currentTime.inMilliseconds / _totalTime.inMilliseconds;
  }

}