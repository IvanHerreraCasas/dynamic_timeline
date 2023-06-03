// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'package:dynamic_timeline/src/rendering/dynamic_timeline_layout.dart';
import 'package:dynamic_timeline/src/rendering/painter/dynamic_timeline_painter.dart';
import 'package:flutter/material.dart';

class HorizontalTimelinePainter extends DynamicTimelinePainter {
  HorizontalTimelinePainter({
    required DynamicTimelineLayout layouter,
    required Paint linePaint,
    required TextStyle labelTextStyle,
  }) : super(
          layouter: layouter,
          linePaint: linePaint,
          labelTextStyle: labelTextStyle,
        );

  @override
  void paint(Canvas canvas, Offset offset, Size size) {
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
  }
}
