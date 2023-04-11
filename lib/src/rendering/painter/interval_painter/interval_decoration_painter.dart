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
      : _paint = paint ?? (Paint()..color = Colors.black26),
      super(intervalSelector: intervalSelector?? ((intervalIdx) => true));

  final void Function(Canvas canvas, Rect drawingRegion, Paint paint) _linePainter;
  final Paint _paint;

  @override
  void paintCallback(Canvas canvas, Rect drawingRegion, int intervalIdx) {
    _linePainter(canvas, drawingRegion, _paint);
  }

  static void _drawHorizontal(Canvas canvas, Rect drawingRegion, Paint paint) =>
      canvas.drawLine(drawingRegion.topRight, drawingRegion.bottomRight, paint);

  static void _drawVertical(Canvas canvas, Rect drawingRegion, Paint paint) =>
      canvas.drawLine(drawingRegion.bottomLeft, drawingRegion.bottomRight, paint);
}
