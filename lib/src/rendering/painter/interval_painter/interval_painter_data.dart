import 'package:flutter/material.dart';

class IntervalPainterData {

  IntervalPainterData(
      {this.intervalSize = Size.zero,
        this.numberOfIntervals=0,
        this.mainAxisOffset=0,
        this.crossAxisOffset=0});

  final Size intervalSize;
  final int numberOfIntervals;
  final double mainAxisOffset;
  final double crossAxisOffset;
}