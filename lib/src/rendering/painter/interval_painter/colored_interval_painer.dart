import 'package:flutter/src/painting/basic_types.dart';
import 'interval_painter.dart';
import 'dart:ui';

class ColoredIntervalPainter extends IntervalPainter {

  ColoredIntervalPainter._({required Axis axis}) : super(drawingAxis: axis);

  Color? Function(int intervalIdx) _getIntervalColor =
      (intervalIdx) => <Color?>[const Color.fromARGB(255, 210, 210, 210), null][intervalIdx % 2];

  static IntervalPainter createHorizontal(
          {Color? Function(int intervalIdx)? intervalColorCallback}) =>
      ColoredIntervalPainter._(axis: Axis.horizontal)..setIntervalColor(intervalColorCallback);

  static IntervalPainter createVertical(
          {Color? Function(int intervalIdx)? intervalColorCallback}) =>
      ColoredIntervalPainter._(axis: Axis.vertical)..setIntervalColor(intervalColorCallback);

  void setIntervalColor(Color? Function(int intervalIdx)? callback) =>
      _getIntervalColor = callback ?? _getIntervalColor;

  @override
  void paintCallback(Canvas canvas, Rect drawingRegion, int intervalIdx) {
    final color = _getIntervalColor(intervalIdx);
    if (color == null) return;
    final paint = Paint()..color = color!;
    canvas.drawRect(drawingRegion, paint);
  }
}
