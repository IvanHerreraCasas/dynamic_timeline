// ignore_for_file: lines_longer_than_80_chars
import 'package:dynamic_timeline/src/rendering/painter/interval_painter/interval_painter.dart';
import 'package:flutter/material.dart';

/// An implementation of [IntervalPainter] that draws a horizontal or vertical interval decorations.
/// To construct there are two factory methods available
/// [IntervalDecorationPainter.createHorizontal] and [IntervalDecorationPainter.createVertical].
class IntervalDecorationPainter extends IntervalPainter {
  /// Creates an implementations of [IntervalPainter] that draws a horizontal
  /// decoration line at the bottom of the interval.
  /// With [paint] you can specify the [Paint] to use for drawing the line.
  /// With [intervalSelector] you can specify which intervals should be decorated.
  /// e.g. every second interval only ..
  factory IntervalDecorationPainter.createHorizontal({
    Paint? paint,
    bool Function(int intervalIdx)? intervalSelector,
  }) =>
      IntervalDecorationPainter._(
        _drawHorizontal,
        paint: paint,
        intervalSelector: intervalSelector,
        drawingAxis: Axis.horizontal,
      );

  /// Creates an implementations of [IntervalPainter] that draws a vertical
  /// decoration line at the right side of the interval.
  /// With [paint] you can specify the [Paint] to use for drawing the line.
  /// With [intervalSelector] you can specify which intervals should be decorated.
  /// e.g. every second interval only ..
  factory IntervalDecorationPainter.createVertical({
    Paint? paint,
    bool Function(int intervalIdx)? intervalSelector,
  }) =>
      IntervalDecorationPainter._(
        _drawVertical,
        paint: paint,
        intervalSelector: intervalSelector,
        drawingAxis: Axis.vertical,
      );

  IntervalDecorationPainter._(
    this._linePainter, {
    required super.drawingAxis,
    bool Function(int intervalIdx)? intervalSelector,
    Paint? paint,
  })  : _paint = paint ?? (Paint()..color = Colors.black26),
        super(intervalSelector: intervalSelector ?? ((intervalIdx) => true));

  final void Function(Canvas canvas, Rect drawingRegion, Paint paint)
      _linePainter;
  final Paint _paint;

  @override
  void paintCallback(Canvas canvas, Rect drawingRegion, int intervalIdx) {
    _linePainter(canvas, drawingRegion, _paint);
  }

  static void _drawHorizontal(Canvas canvas, Rect drawingRegion, Paint paint) =>
      canvas.drawLine(drawingRegion.topRight, drawingRegion.bottomRight, paint);

  static void _drawVertical(Canvas canvas, Rect drawingRegion, Paint paint) =>
      canvas.drawLine(
        drawingRegion.bottomLeft,
        drawingRegion.bottomRight,
        paint,
      );
}
