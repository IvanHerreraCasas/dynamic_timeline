// ignore_for_file: lines_longer_than_80_chars
import 'package:dynamic_timeline/src/rendering/painter/interval_painter/interval_painter.dart';
import 'package:flutter/material.dart';

/// An implementation of [IntervalPainter] that paints the intervals with a filled [Paint] box.
/// It has two factory methods available [ColoredIntervalPainter.createHorizontal] and
/// [ColoredIntervalPainter.createVertical] to construct the painter.
class ColoredIntervalPainter extends IntervalPainter {
  ColoredIntervalPainter._({
    required Axis axis,
    bool Function(int intervalIdx)? intervalSelector,
    Paint? paint,
  })  : _paint = paint ?? (Paint()..color = Colors.black12),
        super(
          drawingAxis: axis,
          intervalSelector:
              intervalSelector ?? ((intervalIdx) => intervalIdx.isEven),
        );

  /// Creates a [ColoredIntervalPainter] that paints the horizontal intervals.
  /// Each interval is painted with the given [paint]. The [intervalSelector] can be used
  /// to determine which intervals should be painted, the default selector will be applied,
  /// which paints every second interval.
  static IntervalPainter createHorizontal({
    Paint? paint,
    bool Function(int intervalIdx)? intervalSelector,
  }) =>
      ColoredIntervalPainter._(
        axis: Axis.horizontal,
        paint: paint,
        intervalSelector: intervalSelector,
      );

  /// Creates a [ColoredIntervalPainter] that paints the vertical intervals.
  /// Each interval is painted with the given [paint].The [intervalSelector] can be used
  /// to determine which intervals should be painted, the default selector will be applied,
  /// which paints every second interval.
  static IntervalPainter createVertical({
    Paint? paint,
    bool Function(int intervalIdx)? intervalSelector,
  }) =>
      ColoredIntervalPainter._(
        axis: Axis.vertical,
        paint: paint,
        intervalSelector: intervalSelector,
      );

  final Paint _paint;

  @override
  void paintCallback(Canvas canvas, Rect drawingRegion, int intervalIdx) =>
      canvas.drawRect(drawingRegion, _paint);
}
