import 'dart:math';

import 'package:flutter/material.dart';

class DynamicTimelineLayout{

  DynamicTimelineLayout({
    required this.axis,
    required this.maxCrossAxisItemExtent,
    required this.intervalExtent,
    required this.maxCrossAxisIndicatorExtent,
    required this.crossAxisSpacing,
    required this.crossAxisCount,
    required this.firstDateTime,
    required this.lastDateTime,
    required this.intervalDuration});

  DateTime firstDateTime;
  Duration intervalDuration;
  DateTime lastDateTime;
  double maxCrossAxisIndicatorExtent;
  double maxCrossAxisItemExtent;
  double intervalExtent;
  double crossAxisSpacing;
  int crossAxisCount;
  Axis axis;

  double getMaxCrossAxisItemExtent({required BoxConstraints constraints}) {
    if (maxCrossAxisItemExtent.isFinite) return maxCrossAxisItemExtent;

    final crossAxisExtent = _getCrossAxisExtent(constraints: constraints);

    final freeSpaceExtent =
        crossAxisExtent - maxCrossAxisIndicatorExtent - crossAxisSpacing * crossAxisCount;

    return freeSpaceExtent / crossAxisCount;
  }

  double _getCrossAxisExtent({required BoxConstraints constraints}) {
    final crossAxisSize = _getCrossAxisSize(constraints.biggest);

    if (maxCrossAxisItemExtent.isInfinite) return crossAxisSize;

    final attemptExtent = maxCrossAxisIndicatorExtent +
        (crossAxisSpacing + maxCrossAxisItemExtent!) * crossAxisCount;

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

  double _getMainAxisExtent({required BoxConstraints constraints}) {
    final mainAxisSize = _getMainAxisSize(constraints.biggest);
    final attemptExtent =
        getExtentSecondRate() * _getTotalDuration().inSeconds;

    return min(mainAxisSize, attemptExtent);
  }

  double getExtentSecondRate() {
    return intervalExtent / intervalDuration.inSeconds;
  }

  Duration _getTotalDuration() {
    return lastDateTime.difference(firstDateTime);
  }


  Size computeSize({required BoxConstraints constraints}) {
    final crossAxisExtent = _getCrossAxisExtent(constraints: constraints);

    final mainAxisExtent = _getMainAxisExtent(constraints: constraints);

    switch (axis) {
      case Axis.vertical:
        return Size(crossAxisExtent, mainAxisExtent);
      case Axis.horizontal:
        return Size(mainAxisExtent, crossAxisExtent);
    }
  }

}