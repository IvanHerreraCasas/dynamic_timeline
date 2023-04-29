import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../rendering.dart';

abstract class DynamicTimelinePainter  {
  static final int labelSpacing = 10;

  DynamicTimelinePainter({required this.layouter,required this.linePaint,
  required this.labelTextStyle});

  final DynamicTimelineLayout layouter;
  Paint linePaint;
  TextStyle labelTextStyle;


  void paint(Canvas canvas, Offset offset, Size size);
}



