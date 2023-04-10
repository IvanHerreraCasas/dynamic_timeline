import 'package:flutter/material.dart';
import 'interval_painter_data.dart';

abstract class IntervalPainter {
  IntervalPainter();

  IntervalPainterData data = IntervalPainterData();

  Axis get painterDirection;

  void paint(
    Canvas canvas,
    Offset canvasOffset,
  );

  void setLayout({required IntervalPainterData data}) => this.data = data;
}

class HorizontalIntervalPainter extends IntervalPainter {
  HorizontalIntervalPainter();

  @override
  Axis get painterDirection => Axis.horizontal;

  @override
  void paint(Canvas canvas, Offset canvasOffset) {
    var paint = Paint()..color = Colors.black12;
    for (var i = 0; i < data.numberOfIntervals; i++) {
      if (i % 2 == 0)
        canvas.drawRect(
            Rect.fromLTWH(
                canvasOffset.dx + data.mainAxisOffset + i * data.mainAxisExtend,
                canvasOffset.dy + data.crossAxisOffset,
                data.mainAxisExtend,
                data.crossAxisExtend),
            paint);
    }
  }
}

class VerticalIntervalPainter extends IntervalPainter {
  VerticalIntervalPainter();

  @override
  Axis get painterDirection => Axis.vertical;

  @override
  void paint(
    Canvas canvas,
    Offset canvasOffset,
  ) {
    var paint = Paint()..color = Colors.black12;
    for (var i = 0; i < data.numberOfIntervals; i++) {
      if (i % 2 == 0)
        canvas.drawRect(
            Rect.fromLTWH(
                canvasOffset.dx + data.crossAxisOffset,
                canvasOffset.dy + data.mainAxisOffset + i * data.mainAxisExtend,
                data.crossAxisExtend,
                data.mainAxisExtend),
            paint);
    }
  }
}
