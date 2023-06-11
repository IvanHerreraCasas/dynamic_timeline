// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'package:dynamic_timeline/src/rendering/dynamic_timeline_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

abstract class DynamicTimelinePainter {
  DynamicTimelinePainter({
    required this.layouter,
    required this.linePaint,
    required this.labelTextStyle,
  });

  static const int labelSpacing = 10;

  final DynamicTimelineLayout layouter;
  Paint linePaint;
  TextStyle labelTextStyle;

  void paint(Canvas canvas, Offset offset, Size size);
}
