import '../dynamic_timeline_layouter.dart';
import 'package:flutter/material.dart';
import 'dynamic_timeline_painter.dart';

class VerticalTimelinePainter extends DynamicTimelinePainter{

  VerticalTimelinePainter({required DynamicTimelineLayouter layouter,
    required Paint linePaint,
    required String? Function(DateTime dateLabel) labelBuilder,
    required TextStyle labelTextStyle}) :
        super(layouter: layouter,
          linePaint: linePaint,
          labelBuilder: labelBuilder,
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
    paintLabels(canvas,size);
  }
  
  @override
  void activateNextLabelTransformation(Canvas canvas){
    canvas.translate(_currentOffset.dx,_currentOffset.dy);
    _currentOffset = Offset(_currentOffset.dx, _currentOffset.dy + layouter.intervalExtent);
  }
}