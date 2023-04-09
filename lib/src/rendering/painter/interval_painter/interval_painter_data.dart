import 'package:flutter/material.dart';

class IntervalPainterData {

  IntervalPainterData(
      {this.intervalSize = Size.zero,
        this.numberOfIntervals=0,
        this.offset=Offset.zero});

  final Size intervalSize;
  final int numberOfIntervals;
  final Offset offset;
}