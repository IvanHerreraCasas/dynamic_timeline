import 'package:flutter/material.dart';
import 'interval_painter.dart';

class IntervalDecorationPainter extends IntervalPainter {
  static IntervalDecorationPainter createHorizontal() =>
      IntervalDecorationPainter._(_drawHorizontal, drawingAxis: Axis.horizontal);

  static IntervalDecorationPainter createVertical() =>
      IntervalDecorationPainter._(_drawVertical, drawingAxis: Axis.vertical);

  IntervalDecorationPainter._(this._linePainter, {required super.drawingAxis});

  final void Function(Canvas canvas, Rect drawingRegion, Paint paint) _linePainter;

  @override
  void paintCallback(Canvas canvas, Rect drawingRegion, int intervalIdx) {
    _linePainter(canvas, drawingRegion, Paint()..color = Colors.black26);
  }

  static void _drawHorizontal(Canvas canvas, Rect drawingRegion, Paint paint) =>
      canvas.drawLine(drawingRegion.topRight, drawingRegion.bottomRight, paint);

  static void _drawVertical(Canvas canvas, Rect drawingRegion, Paint paint) =>
      canvas.drawLine(drawingRegion.bottomLeft, drawingRegion.bottomRight, paint);
}
