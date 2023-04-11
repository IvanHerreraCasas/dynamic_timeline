import 'package:flutter/material.dart';
import 'interval_painter.dart';

class IntervalDecorationPainter extends IntervalPainter {
  static IntervalDecorationPainter createHorizontal(
          {Paint? paint, bool Function(int intervalIdx)? intervalSelector}) =>
      IntervalDecorationPainter._(
        _drawHorizontal,
        paint: paint,
        intervalSelector: intervalSelector,
        drawingAxis: Axis.horizontal,
      );

  static IntervalDecorationPainter createVertical(
          {Paint? paint, bool Function(int intervalIdx)? intervalSelector}) =>
      IntervalDecorationPainter._(
        _drawVertical,
        paint: paint,
        intervalSelector: intervalSelector,
        drawingAxis: Axis.vertical,
      );

  IntervalDecorationPainter._(this._linePainter,
      {required super.drawingAxis, bool Function(int intervalIdx)? intervalSelector, Paint? paint})
      : _intervalSelector = intervalSelector ?? ((intervalIdx) => true),
        _paint = paint ?? (Paint()..color = Colors.black26);

  final void Function(Canvas canvas, Rect drawingRegion, Paint paint) _linePainter;
  final bool Function(int intervalIdx) _intervalSelector;
  final Paint _paint;

  @override
  void paintCallback(Canvas canvas, Rect drawingRegion, int intervalIdx) {
    if (!_intervalSelector(intervalIdx)) return;
    _linePainter(canvas, drawingRegion, _paint);
  }

  static void _drawHorizontal(Canvas canvas, Rect drawingRegion, Paint paint) =>
      canvas.drawLine(drawingRegion.topRight, drawingRegion.bottomRight, paint);

  static void _drawVertical(Canvas canvas, Rect drawingRegion, Paint paint) =>
      canvas.drawLine(drawingRegion.bottomLeft, drawingRegion.bottomRight, paint);
}
