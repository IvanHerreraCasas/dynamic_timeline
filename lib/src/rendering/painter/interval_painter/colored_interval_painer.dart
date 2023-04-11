import 'package:flutter/material.dart';
import 'package:flutter/src/painting/basic_types.dart';
import 'interval_painter.dart';
import 'dart:ui';

class ColoredIntervalPainter extends IntervalPainter {
  ColoredIntervalPainter._({
    required Axis axis,
    bool Function(int intervalIdx)? intervalSelector,
    Paint? paint,
  })  : _paint = paint ?? (Paint()..color = Colors.black12),
        super(
            drawingAxis: axis,
            intervalSelector: intervalSelector ?? ((intervalIdx) => intervalIdx % 2 == 0));

  static IntervalPainter createHorizontal(
          {Paint? paint, bool Function(int intervalIdx)? intervalSelector}) =>
      ColoredIntervalPainter._(
          axis: Axis.horizontal, paint: paint, intervalSelector: intervalSelector);

  static IntervalPainter createVertical(
          {Paint? paint, bool Function(int intervalIdx)? intervalSelector}) =>
      ColoredIntervalPainter._(
          axis: Axis.vertical, paint: paint, intervalSelector: intervalSelector);

  final Paint _paint;

  @override
  void paintCallback(Canvas canvas, Rect drawingRegion, int intervalIdx) =>
      canvas.drawRect(drawingRegion, _paint);
}
