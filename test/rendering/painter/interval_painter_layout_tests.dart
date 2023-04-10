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
          expect(data.crossAxisExtend, 0);
          expect(data.mainAxisExtend, 0);
          expect(data.numberOfIntervals, 0);
          expect(data.mainAxisOffset, 0);
          expect(data.crossAxisOffset, 0);
        },
      );

      test('Initialization horizontal painter on tine-line main axis direction', () {
        final painter = HorizontalIntervalPainter();
        final layoutEngine = TestLayoutEngineFactory.create(
          axis: Axis.horizontal,
        );
        const elementSizeConstraint = BoxConstraints(
          minHeight: 500,
          maxHeight: 500,
          maxWidth: 400,
          minWidth: 400,
        );

        // we need to call compute size beforehand to have a valid
        // initialization for "_recentSize"
        layoutEngine
          ..updateConstraints(elementSizeConstraint)
          ..updateLayoutDataFor(painter);

        expect(painter.data.mainAxisExtend, layoutEngine.intervalExtent);
        expect(painter.data.crossAxisExtend,
            elementSizeConstraint.maxHeight - layoutEngine.maxCrossAxisIndicatorExtent);
        expect(painter.data.mainAxisOffset, 0);
        expect(painter.data.crossAxisOffset, layoutEngine.maxCrossAxisIndicatorExtent);
        expect(painter.data.numberOfIntervals, 3);
      });

      test('Initialization horizontal painter on tine-line cross axis direction', () {
        final painter = HorizontalIntervalPainter();
        final layoutEngine = TestLayoutEngineFactory.create(
          axis: Axis.vertical,
        );
        const elementSizeConstraint = BoxConstraints(
          minHeight: 500,
          maxHeight: 500,
          maxWidth: 400,
          minWidth: 400,
        );

        // we need to call compute size beforehand to have a valid
        // initialization for "_recentSize"
        layoutEngine
          ..updateConstraints(elementSizeConstraint)
          ..updateLayoutDataFor(painter);

        // 170 = (elementSizeConstraint.maxWidth-layoutEngine.maxCrossAxisIndicatorExtent)/2;
        expect(painter.data.mainAxisExtend, 170);
        expect(painter.data.crossAxisExtend, 150);
        expect(painter.data.mainAxisOffset, layoutEngine.maxCrossAxisIndicatorExtent);
        expect(painter.data.crossAxisOffset, 0);
        expect(painter.data.numberOfIntervals, 2);
      });

      test('Initialization vertical painter on tine-line cross axis direction', () {
        final painter = VerticalIntervalPainter();
        final layoutEngine = TestLayoutEngineFactory.create(
          axis: Axis.horizontal,
        );
        const elementSizeConstraint = BoxConstraints(
          minHeight: 500,
          maxHeight: 500,
          maxWidth: 400,
          minWidth: 400,
        );

        // we need to call compute size beforehand to have a valid
        // initialization for "_recentSize"
        layoutEngine
          ..updateConstraints(elementSizeConstraint)
          ..updateLayoutDataFor(painter);

        expect(painter.data.crossAxisExtend, 150);
        // 220 = (elementSizeConstraint.maxHeight-layoutEngine.maxCrossAxisIndicatorExtent)/2;
        expect(painter.data.mainAxisExtend, 220);
        expect(painter.data.crossAxisOffset, 0);
        expect(painter.data.mainAxisOffset, layoutEngine.maxCrossAxisIndicatorExtent);
        expect(painter.data.numberOfIntervals, 2);
      });

      test('Initialization vertical painter on tine-line main axis direction', () {
        final painter = VerticalIntervalPainter();
        final layoutEngine = TestLayoutEngineFactory.create(
          axis: Axis.vertical,
        );
        const elementSizeConstraint = BoxConstraints(
          minHeight: 500,
          maxHeight: 500,
          maxWidth: 400,
          minWidth: 400,
        );

        // we need to call compute size beforehand to have a valid
        // initialization for "_recentSize"
        layoutEngine
          ..updateConstraints(elementSizeConstraint)
          ..updateLayoutDataFor(painter);

        expect(painter.data.crossAxisExtend,
            elementSizeConstraint.maxWidth - layoutEngine.maxCrossAxisIndicatorExtent);
        expect(painter.data.mainAxisExtend, layoutEngine.intervalExtent);
        expect(painter.data.crossAxisOffset, layoutEngine.maxCrossAxisIndicatorExtent);
        expect(painter.data.mainAxisOffset, 0);
        expect(painter.data.numberOfIntervals, 3);
      });
    });
  }
}
