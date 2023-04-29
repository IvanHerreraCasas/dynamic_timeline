import 'package:flutter/material.dart';
import '../rendering.dart';
import 'dynamic_timeline_painter.dart';

class VerticalTimelinePainter extends DynamicTimelinePainter{

  VerticalTimelinePainter({required DynamicTimelineLayout layouter,
    required Paint linePaint,
    required TextStyle labelTextStyle}) :
        super(layouter: layouter,
          linePaint: linePaint,
          labelTextStyle: labelTextStyle);

  Offset _currentOffset = Offset(0,0);

  void paint(Canvas canvas, Offset offset, Size size){

    // paint line
    canvas.drawLine(
      Offset(
        offset.dx + layouter.maxCrossAxisIndicatorExtent,
        offset.dy,
      ),
      Offset(
        offset.dx + layouter.maxCrossAxisIndicatorExtent,
        offset.dy + size.height,
      ),
      linePaint,
    );

    _currentOffset = offset;
  }

}