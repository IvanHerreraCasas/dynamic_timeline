import 'package:dynamic_timeline/src/rendering/dynamic_timeline_layouter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

abstract class DynamicTimelinePainter  {
  static final int labelSpacing = 10;

  DynamicTimelinePainter({required this.layouter,required this.linePaint,
  required this.labelTextStyle});

  final DynamicTimelineLayouter layouter;
  Paint linePaint;
  TextStyle labelTextStyle;


  void paint(Canvas canvas, Offset offset, Size size);
}



