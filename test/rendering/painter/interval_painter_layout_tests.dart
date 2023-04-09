import 'package:dynamic_timeline/src/rendering/painter/interval_painter/interval_painter_data.dart';
import 'package:dynamic_timeline/dynamic_timeline.dart';
import 'package:flutter_test/flutter_test.dart';
import 'test_layout_engine_factory.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

class IntervalPainterLayoutTests {
  static void run() {
    group('IntervalPainter', () {
      test(
        'Creation of empty IntervalPainterData --> data gets initialized as zero',
        () {
          final data = IntervalPainterData();
          expect(data.intervalSize, Size.zero);
          expect(data.numberOfIntervals, 0);
          expect(data.offset, Offset.zero);
        },
      );

      test('Initialization horizontal painter on horizontal tine-line', () {
        final painter = HorizontalIntervalPainter();
        final layoutEngine = TestLayoutEngineFactory.create(axis: Axis.horizontal,);
        const elementSizeConstraint = BoxConstraints(
          minHeight: 500,
          maxHeight: 500,
          maxWidth: 400,
          minWidth: 400,
        );

        // we need to call compute size beforehand to have a valid
        // initialization for "_recentSize"
        layoutEngine..computeSize(constraints: elementSizeConstraint)
        ..updateLayoutDataFor(painter);

        expect(painter.data.intervalSize.width, layoutEngine.intervalExtent);
        expect(painter.data.intervalSize.height, elementSizeConstraint.maxHeight
            -layoutEngine.maxCrossAxisIndicatorExtent);
        expect(painter.data.offset.dx, 0);
        expect(painter.data.offset.dy, layoutEngine.maxCrossAxisIndicatorExtent);
        expect(painter.data.numberOfIntervals, 3);
      });

      test('Initialization vertical painter on vertical tine-line', () {
        final painter = VerticalIntervalPainter();
        final layoutEngine = TestLayoutEngineFactory.create(axis: Axis.vertical,);
        const elementSizeConstraint = BoxConstraints(
          minHeight: 500,
          maxHeight: 500,
          maxWidth: 400,
          minWidth: 400,
        );

        // we need to call compute size beforehand to have a valid
        // initialization for "_recentSize"
        layoutEngine..computeSize(constraints: elementSizeConstraint)
          ..updateLayoutDataFor(painter);

        expect(painter.data.intervalSize.width, elementSizeConstraint.maxWidth
            -layoutEngine.maxCrossAxisIndicatorExtent);
        expect(painter.data.intervalSize.height, layoutEngine.intervalExtent);
        expect(painter.data.offset.dx, layoutEngine.maxCrossAxisIndicatorExtent);
        expect(painter.data.offset.dy, 0);
        expect(painter.data.numberOfIntervals, 3);
      });

    });
  }
}
