import 'package:dynamic_timeline/src/rendering/dynamic_timeline_layouter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

abstract class DynamicTimelinePainter  {
  static final int labelSpacing = 10;

  DynamicTimelinePainter({required this.layouter,required this.linePaint,required this.labelBuilder,
  required this.labelTextStyle});

  final DynamicTimelineLayouter layouter;
  Paint linePaint;
  String? Function(DateTime) labelBuilder;
  TextStyle labelTextStyle;


  void paintLabels(Canvas canvas, Size size){
    var dateTime = layouter.firstDateTime;
    while (dateTime.isBefore(layouter.lastDateTime)) {
      canvas.save();
      activateNextLabelTransformation(canvas);
      final label = labelBuilder(dateTime);
      if (label != null) {
        TextPainter(
          text: TextSpan(
            text: label,
            style: labelTextStyle,
          ),
          textDirection: TextDirection.ltr,
          ellipsis: '.',
        )
        // "-labelSpacing" to have space between the label and the line
          ..layout(maxWidth: size.width - labelSpacing)
          ..paint(canvas, Offset.zero);
      }
      dateTime = dateTime.add(layouter.intervalDuration);
      canvas.restore();
    }
  }

  void activateNextLabelTransformation(Canvas canvas);

  void paint(Canvas canvas, Offset offset, Size size);
}



