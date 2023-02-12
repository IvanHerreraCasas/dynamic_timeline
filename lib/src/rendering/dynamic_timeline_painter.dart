import 'package:dynamic_timeline/src/rendering/dynamic_timeline_layouter.dart';
import 'package:flutter/material.dart';

class DynamicTimelinePainter{
  static final int labelSpacing = 10;

  DynamicTimelinePainter({required this.layouter,required this.linePaint,required this.labelBuilder,
  required this.labelTextStyle});

  final LayouterDynamicTimeline layouter;
  Paint linePaint;
  String? Function(DateTime) labelBuilder;
  TextStyle labelTextStyle;

  void paintVertical(Canvas canvas, Offset offset, Size size){

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

    // paint labels
    var dateTime = layouter.firstDateTime;
    var labelOffset = offset;

    while (dateTime.isBefore(layouter.lastDateTime)) {
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
        // - 10 to have space between the label and the line
          ..layout(maxWidth: size.width - 10)
          ..paint(canvas, labelOffset);
      }
      labelOffset = Offset(labelOffset.dx, labelOffset.dy + layouter.intervalExtent);
      dateTime = dateTime.add(layouter.intervalDuration);
    }
  }

  void paintHorizontal(Canvas canvas, Offset offset, Size size){

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

    // paint labels
    var dateTime = layouter.firstDateTime;
    var labelOffset = offset;

    while (dateTime.isBefore(layouter.lastDateTime)) {
      final label = labelBuilder(dateTime);

      if (label != null) {
        canvas.save();
        canvas.translate(
            labelOffset.dx, labelOffset.dy + layouter.maxCrossAxisIndicatorExtent - labelSpacing);
        canvas.rotate(-1.3);
        TextPainter(
          text: TextSpan(
            text: label,
            style: labelTextStyle,
          ),
          textDirection: TextDirection.ltr,
          ellipsis: '.',
        )
        // - 10 to have space between the label and the line
          ..layout(maxWidth: size.width - labelSpacing)
          ..paint(canvas, const Offset(0, 0));
        canvas.restore();
      }
      labelOffset = Offset(labelOffset.dx + layouter.intervalExtent, labelOffset.dy);
      dateTime = dateTime.add(layouter.intervalDuration);
    }
  }
}