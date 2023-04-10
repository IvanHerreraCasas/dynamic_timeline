import 'dart:math';

import 'package:dynamic_timeline/src/rendering/painter/interval_painter/interval_painter.dart';
import 'package:flutter/material.dart';

import 'painter/interval_painter/interval_painter_data.dart';

class DynamicTimelineLayout {
  DynamicTimelineLayout(
      {required this.axis,
      required this.maxCrossAxisItemExtent,
      required this.intervalExtent,
      required this.maxCrossAxisIndicatorExtent,
      required this.crossAxisSpacing,
      required this.crossAxisCount,
      required this.firstDateTime,
      required this.lastDateTime,
      required this.intervalDuration})
      : _constraints = BoxConstraints(minWidth: 0, maxWidth: 0, maxHeight: 0, minHeight: 0);

  DateTime firstDateTime;
  Duration intervalDuration;
  DateTime lastDateTime;
  double maxCrossAxisIndicatorExtent;
  double maxCrossAxisItemExtent;
  double intervalExtent;
  double crossAxisSpacing;
  int crossAxisCount;
  Axis axis;
  BoxConstraints _constraints;

  void updateConstraints(BoxConstraints constraints) => _constraints = constraints;

  double getMaxCrossAxisItemExtent() {
    if (maxCrossAxisItemExtent.isFinite) return maxCrossAxisItemExtent;

    final crossAxisExtent = _getCrossAxisExtent();

    final freeSpaceExtent =
        crossAxisExtent - maxCrossAxisIndicatorExtent - crossAxisSpacing * crossAxisCount;

    return freeSpaceExtent / crossAxisCount;
  }

  double _getCrossAxisExtent() {
    final crossAxisSize = _getCrossAxisSize(_constraints.biggest);

    if (maxCrossAxisItemExtent.isInfinite) return crossAxisSize;

    final attemptExtent =
        maxCrossAxisIndicatorExtent + (crossAxisSpacing + maxCrossAxisItemExtent) * crossAxisCount;

    return min(
      crossAxisSize,
      attemptExtent,
    );
  }

  double _getCrossAxisSize(Size size) {
    switch (axis) {
      case Axis.vertical:
        return size.width;
      case Axis.horizontal:
        return size.height;
    }
  }

  double _getMainAxisSize(Size size) {
    switch (axis) {
      case Axis.vertical:
        return size.height;
      case Axis.horizontal:
        return size.width;
    }
  }

  double _getMainAxisExtent() {
    final mainAxisSize = _getMainAxisSize(_constraints.biggest);
    final attemptExtent = getExtentSecondRate() * _getTotalDuration().inSeconds;

    return min(mainAxisSize, attemptExtent);
  }

  double getExtentSecondRate() {
    return intervalExtent / intervalDuration.inSeconds;
  }

  Duration _getTotalDuration() {
    return lastDateTime.difference(firstDateTime);
  }

  Size computeSize() {
    final crossAxisExtent = _getCrossAxisExtent();

    final mainAxisExtent = _getMainAxisExtent();

    return (axis == Axis.vertical)
        ? Size(crossAxisExtent, mainAxisExtent)
        : Size(mainAxisExtent, crossAxisExtent);
  }

  void updateLayoutDataFor(IntervalPainter intervalPainter) {
    final intervalMainAxisExtend = _isMainAxis(intervalPainter)
        ? getExtentSecondRate() * intervalDuration.inSeconds
        : getMaxCrossAxisItemExtent() + crossAxisSpacing;
    final intervalOffset = _isMainAxis(intervalPainter) ? maxCrossAxisIndicatorExtent:0;

    if (intervalPainter.painterDirection == Axis.horizontal) {
      intervalPainter.setLayout(
          data: IntervalPainterData(
              intervalSize: Size(intervalMainAxisExtend, computeSize().height - intervalOffset),
              numberOfIntervals:
                  _isMainAxis(intervalPainter) ? _getIntervalCount() : crossAxisCount,
              mainAxisOffset: intervalPainter.painterDirection == axis ? 0 : maxCrossAxisIndicatorExtent,
              crossAxisOffset: intervalPainter.painterDirection == axis ? maxCrossAxisIndicatorExtent : 0,
    ));
    } else {
      intervalPainter.setLayout(
          data: IntervalPainterData(
              intervalSize: Size(computeSize().width - intervalOffset, intervalMainAxisExtend),
              numberOfIntervals:
                  _isMainAxis(intervalPainter) ? _getIntervalCount() : crossAxisCount,
            mainAxisOffset:  intervalPainter.painterDirection == axis ? 0 : maxCrossAxisIndicatorExtent,
            crossAxisOffset: intervalPainter.painterDirection == axis ? maxCrossAxisIndicatorExtent : 0,
          ));
    }
  }

  int _getIntervalCount() =>
      (lastDateTime.difference(firstDateTime).inMinutes / intervalDuration.inMinutes).floor();

  bool _isMainAxis(IntervalPainter intervalPainter) => intervalPainter.painterDirection == axis;
}
