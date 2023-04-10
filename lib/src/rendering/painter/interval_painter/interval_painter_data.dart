import 'package:flutter/material.dart';

class IntervalPainterData {
  IntervalPainterData(
      {this.mainAxisExtend = 0,
      this.crossAxisExtend = 0,
      this.numberOfIntervals = 0,
      this.mainAxisOffset = 0,
      this.crossAxisOffset = 0});

  final double mainAxisExtend;
  final double crossAxisExtend;

  final int numberOfIntervals;
  final double mainAxisOffset;
  final double crossAxisOffset;
}
