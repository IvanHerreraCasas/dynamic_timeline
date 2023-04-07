import 'package:flutter/material.dart';

class BackgroundPainter {
  BackgroundPainter(
      {required this.axis,
      required this.intervalMainAxisExtend,
      required this.crossAxisExtend,
      required this.numberOfIntervals});

  final Axis axis;
  final double intervalMainAxisExtend;
  final double crossAxisExtend;
  final int numberOfIntervals;

  void paint(Canvas canvas, Offset offset, double crossAxisOffset) {
    if (axis == Axis.vertical)
      paintVertical(canvas, offset, crossAxisOffset);
    else
      paintHorizontal(canvas, offset, crossAxisOffset);
  }

  void paintVertical(Canvas canvas, Offset offset, double crossAxisOffset) {
    var paint = Paint()..color = Colors.black12;
    for (var i = 0; i < numberOfIntervals; i++) {
      if (i % 2 == 0)
        canvas.drawRect(
            Rect.fromLTWH(offset.dx  + crossAxisOffset, offset.dy + i * intervalMainAxisExtend,
              crossAxisExtend,intervalMainAxisExtend),
            paint);
    }
  }

  void paintHorizontal(Canvas canvas, Offset offset, double crossAxisOffset) {
    var paint = Paint()..color = Colors.black12;
    for (var i = 0; i < numberOfIntervals; i++) {
      if (i % 2 == 0)
        canvas.drawRect(
            Rect.fromLTWH(offset.dx + i * intervalMainAxisExtend, offset.dy + crossAxisOffset,
                intervalMainAxisExtend, crossAxisExtend),
            paint);
    }
  }
}
