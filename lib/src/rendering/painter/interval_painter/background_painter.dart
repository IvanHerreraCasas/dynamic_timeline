import 'package:flutter/material.dart';
import 'interval_painter_data.dart';

abstract class IntervalPainter{

  IntervalPainter();

  IntervalPainterData data = IntervalPainterData();

  Axis get painterDirection;

  void paint(Canvas canvas, );

  void setLayout({required IntervalPainterData data}) => this.data = data;
}

class HorizontalIntervalPainter extends IntervalPainter {

  HorizontalIntervalPainter();

  @override
  Axis get painterDirection => Axis.horizontal;

  @override
  void paint(Canvas canvas, ) {
    var paint = Paint()..color = Colors.black12;
    for (var i = 0; i < data.numberOfIntervals; i++) {
      if (i % 2 == 0)
        canvas.drawRect(
            Rect.fromLTWH(data.offset.dx + i * data.intervalSize.width, data.offset.dy ,
                data.intervalSize.width, data.intervalSize.height),
            paint);
    }
  }
}

class VerticalIntervalPainter extends IntervalPainter {

  VerticalIntervalPainter();

  @override
  Axis get painterDirection => Axis.vertical;

  @override
  void paint(Canvas canvas, ) {
    var paint = Paint()..color = Colors.black12;
    for (var i = 0; i < data.numberOfIntervals; i++) {
      if (i % 2 == 0)
        canvas.drawRect(
            Rect.fromLTWH(data.offset.dx , data.offset.dy + i * data.intervalSize.height,
                data.intervalSize.width, data.intervalSize.height),
            paint);
    }
  }

}

