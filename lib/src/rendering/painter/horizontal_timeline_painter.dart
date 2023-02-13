import '../dynamic_timeline_layouter.dart';
import 'package:flutter/material.dart';
import 'dynamic_timeline_painter.dart';

class HorizontalTimelinePainter extends DynamicTimelinePainter{
  HorizontalTimelinePainter({required DynamicTimelineLayouter layouter, required Paint linePaint, required String? Function(DateTime actualDate) labelBuilder, required TextStyle labelTextStyle}) : super(layouter: layouter, linePaint: linePaint, labelBuilder: labelBuilder, labelTextStyle: labelTextStyle);


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
    paintLabels(canvas,size);
  }

  @override
  void activateNextLabelTransformation(Canvas canvas){
    canvas.translate(_currentOffset.dx,_currentOffset.dy);
    canvas.rotate(-1.2);
    _currentOffset = Offset(_currentOffset.dx+ layouter.intervalExtent, _currentOffset.dy );
  }
}