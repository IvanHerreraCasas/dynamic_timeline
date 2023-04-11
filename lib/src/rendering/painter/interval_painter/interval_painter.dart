import 'package:flutter/material.dart';
import 'background_painter_data.dart';
import 'background_painter.dart';

abstract class IntervalPainter extends BackgroundPainter {
  IntervalPainter(
      {required Axis drawingAxis, required bool Function(int intervalIdx) intervalSelector})
      : _regionCalculation = drawingAxis == Axis.horizontal
            ? _horizontalRegionCalculation
            : _verticalRegionCalculation,
        this._painterDirection = drawingAxis,
        this._intervalSelector = intervalSelector;

  Rect Function(BackgroundPainterData data, Offset canvasOffset, int idx) _regionCalculation;
  final Axis _painterDirection;
  final bool Function(int intervalIdx) _intervalSelector;

  @override
  Axis get painterDirection => _painterDirection;

  @override
  void paint(Canvas canvas, Offset canvasOffset) {
    for (var idx = 0; idx < data.numberOfIntervals; idx++) {
      if(!_intervalSelector(idx)) continue;
      paintCallback(canvas, _regionCalculation(data, canvasOffset, idx), idx);
    }
  }

  void paintCallback(Canvas canvas, Rect drawingRegion, int intervalIdx);

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
