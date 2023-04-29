import 'package:flutter/material.dart';
import 'dynamic_timeline_painter.dart';
import '../rendering.dart';

class HorizontalTimelinePainter extends DynamicTimelinePainter{
  HorizontalTimelinePainter({required DynamicTimelineLayout layouter, required Paint linePaint, required TextStyle labelTextStyle}) :
        super(layouter: layouter, linePaint: linePaint, labelTextStyle: labelTextStyle);


  Offset _currentOffset = Offset(0,0);

  void paint(Canvas canvas, Offset offset, Size size){

    // paint line
    canvas.drawLine(
      Offset(
        offset.dx,
        offset.dy + layouter.maxCrossAxisIndicatorExtent,
      ),
      Offset(
        offset.dx + size.width,
        offset.dy + layouter.maxCrossAxisIndicatorExtent,
      ),
      linePaint,
    );

    _currentOffset = Offset( offset.dx, offset.dy + layouter.maxCrossAxisIndicatorExtent - DynamicTimelinePainter.labelSpacing);
  }

}