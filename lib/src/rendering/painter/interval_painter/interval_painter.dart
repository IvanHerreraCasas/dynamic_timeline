import 'package:flutter/material.dart';
import 'background_painter_data.dart';
import 'background_painter.dart';

abstract class IntervalPainter extends BackgroundPainter {
  IntervalPainter({required Axis drawingAxis})
      : _regionCalculation = drawingAxis == Axis.horizontal
            ? _horizontalRegionCalculation
            : _verticalRegionCalculation,
        this._painterDirection = drawingAxis;

  final Axis _painterDirection;

  Rect Function(BackgroundPainterData data, Offset canvasOffset, int idx) _regionCalculation;

  void paintCallback(Canvas canvas, Rect drawingRegion, int intervalIdx);

  @override
  Axis get painterDirection => _painterDirection;

  @override
  void paint(Canvas canvas, Offset canvasOffset) {
    for (var idx = 0; idx < data.numberOfIntervals; idx++) {
      paintCallback(canvas, _regionCalculation(data, canvasOffset, idx), idx);
    }
  }

  static Rect _horizontalRegionCalculation(
      BackgroundPainterData data, Offset canvasOffset, int idx) {
    return Rect.fromLTWH(canvasOffset.dx + data.mainAxisOffset + idx * data.mainAxisExtend,
        canvasOffset.dy + data.crossAxisOffset, data.mainAxisExtend, data.crossAxisExtend);
  }

  static Rect _verticalRegionCalculation(BackgroundPainterData data, Offset canvasOffset, int idx) {
    return Rect.fromLTWH(
        canvasOffset.dx + data.crossAxisOffset,
        canvasOffset.dy + data.mainAxisOffset + idx * data.mainAxisExtend,
        data.crossAxisExtend,
        data.mainAxisExtend);
  }
}
