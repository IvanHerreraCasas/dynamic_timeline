// ignore_for_file: lines_longer_than_80_chars
import 'package:dynamic_timeline/src/rendering/painter/background_painter.dart';
import 'package:dynamic_timeline/src/rendering/painter/interval_painter/background_painter_data.dart';
import 'package:dynamic_timeline/src/rendering/painter/interval_painter/colored_interval_painter.dart';
import 'package:flutter/material.dart';

/// {@template interval_painter}
/// The abstract base class for interval painters.
/// Interval painters are used to colorize the background of a timeline.
/// As the name indicates they will be called for each interval of the
/// according timeline axis (cross or main).
/// Implementations should override the [paintCallback] method to draw the intervals.
/// For an implementation example see [ColoredIntervalPainter].
/// {@endtemplate}
abstract class IntervalPainter extends BackgroundPainter {
  /// {@macro interval_painter}
  IntervalPainter({
    required Axis drawingAxis,
    required bool Function(int intervalIdx) intervalSelector,
  })  : _regionCalculation = drawingAxis == Axis.horizontal
            ? _horizontalRegionCalculation
            : _verticalRegionCalculation,
        _painterDirection = drawingAxis,
        _intervalSelector = intervalSelector;

  final Rect Function(BackgroundPainterData data, Offset canvasOffset, int idx)
      _regionCalculation;
  final Axis _painterDirection;
  final bool Function(int intervalIdx) _intervalSelector;

  @override
  Axis get painterDirection => _painterDirection;

  @override
  void paint(Canvas canvas, Offset canvasOffset) {
    for (var idx = 0; idx < data.numberOfIntervals; idx++) {
      if (!_intervalSelector(idx)) continue;
      paintCallback(canvas, _regionCalculation(data, canvasOffset, idx), idx);
    }
  }

  /// The callback which will be called for each interval. Needs to be implemented
  /// by subclasses. The [drawingRegion] is the outline of the interval borders, +
  /// which should not be exceeded.
  /// The [intervalIdx] is the index of the interval, starting at 0. Since
  /// the interval painter can be used for both axis,
  /// it's task of the implementation to decide to which type of data the index refers.
  void paintCallback(Canvas canvas, Rect drawingRegion, int intervalIdx);

  static Rect _horizontalRegionCalculation(
    BackgroundPainterData data,
    Offset canvasOffset,
    int idx,
  ) {
    return Rect.fromLTWH(
      canvasOffset.dx + data.mainAxisOffset + idx * data.mainAxisExtend,
      canvasOffset.dy + data.crossAxisOffset,
      data.mainAxisExtend,
      data.crossAxisExtend,
    );
  }

  static Rect _verticalRegionCalculation(
    BackgroundPainterData data,
    Offset canvasOffset,
    int idx,
  ) {
    return Rect.fromLTWH(
      canvasOffset.dx + data.crossAxisOffset,
      canvasOffset.dy + data.mainAxisOffset + idx * data.mainAxisExtend,
      data.crossAxisExtend,
      data.mainAxisExtend,
    );
  }
}
