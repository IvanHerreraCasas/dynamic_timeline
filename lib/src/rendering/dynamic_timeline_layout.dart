// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'dart:math';
import 'package:dynamic_timeline/src/rendering/painter/interval_painter/background_painter_data.dart';
import 'package:dynamic_timeline/src/rendering/painter/interval_painter/interval_painter.dart';
import 'package:flutter/material.dart';

class DynamicTimelineLayout {
  DynamicTimelineLayout({
    required this.axis,
    required this.maxCrossAxisItemExtent,
    required this.intervalExtent,
    required this.maxCrossAxisIndicatorExtent,
    required this.crossAxisSpacing,
    required this.crossAxisCount,
    required this.firstDateTime,
    required this.lastDateTime,
    required this.intervalDuration,
  }) : _constraints = const BoxConstraints(maxWidth: 0, maxHeight: 0);

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

  // ignore: use_setters_to_change_properties
  void updateConstraints(BoxConstraints constraints) =>
      _constraints = constraints;

  double getMaxCrossAxisItemExtent() {
    if (maxCrossAxisItemExtent.isFinite) return maxCrossAxisItemExtent;

    final crossAxisExtent = _getCrossAxisExtent();

    final freeSpaceExtent = crossAxisExtent -
        maxCrossAxisIndicatorExtent -
        crossAxisSpacing * crossAxisCount;

    return freeSpaceExtent / crossAxisCount;
  }

  double _getCrossAxisExtent() {
    final crossAxisSize = _getCrossAxisSize(_constraints.biggest);

    if (maxCrossAxisItemExtent.isInfinite) return crossAxisSize;

    final attemptExtent = maxCrossAxisIndicatorExtent +
        (crossAxisSpacing + maxCrossAxisItemExtent) * crossAxisCount;

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

  double getExtentSecondRate() => intervalExtent / intervalDuration.inSeconds;

  Duration _getTotalDuration() => lastDateTime.difference(firstDateTime);

  Size computeSize() {
    final crossAxisExtent = _getCrossAxisExtent();

    final mainAxisExtent = _getMainAxisExtent();

    return (axis == Axis.vertical)
        ? Size(crossAxisExtent, mainAxisExtent)
        : Size(mainAxisExtent, crossAxisExtent);
  }

  void updateLayoutData(IntervalPainter intervalPainter) {
    final intervalMainAxisExtend = _isOnMainAxis(intervalPainter)
        ? getExtentSecondRate() * intervalDuration.inSeconds
        : getMaxCrossAxisItemExtent() + crossAxisSpacing;
    final intervalOffset =
        _isOnMainAxis(intervalPainter) ? maxCrossAxisIndicatorExtent : 0;
    final crossAxisExtend = intervalPainter.painterDirection == Axis.horizontal
        ? computeSize().height - intervalOffset
        : computeSize().width - intervalOffset;

    intervalPainter.setLayout(
      data: BackgroundPainterData(
        mainAxisExtend: intervalMainAxisExtend,
        crossAxisExtend: crossAxisExtend,
        numberOfIntervals: _isOnMainAxis(intervalPainter)
            ? _getIntervalCount()
            : crossAxisCount,
        mainAxisOffset: intervalPainter.painterDirection == axis
            ? 0
            : maxCrossAxisIndicatorExtent,
        crossAxisOffset: intervalPainter.painterDirection == axis
            ? maxCrossAxisIndicatorExtent
            : 0,
      ),
    );
  }

  int _getIntervalCount() => (lastDateTime.difference(firstDateTime).inMinutes /
          intervalDuration.inMinutes)
      .floor();

  bool _isOnMainAxis(IntervalPainter intervalPainter) =>
      intervalPainter.painterDirection == axis;
}
