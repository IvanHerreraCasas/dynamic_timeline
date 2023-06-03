// ignore_for_file: lines_longer_than_80_chars

import 'package:dynamic_timeline/dynamic_timeline.dart';
import 'package:dynamic_timeline/src/rendering/painter/interval_painter/background_painter_data.dart';
import 'package:dynamic_timeline/src/rendering/painter/interval_painter/colored_interval_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shouldly/shouldly.dart';

import 'test_layout_engine_factory.dart';

void main() {
  group('IntervalPainter', () {
    test(
      'Creation of empty IntervalPainterData --> data gets initialized as zero',
      () {
        final data = BackgroundPainterData();
        data.crossAxisExtend.should.be(0);
        data.mainAxisExtend.should.be(0);
        data.numberOfIntervals.should.be(0);
        data.mainAxisOffset.should.be(0);
        data.crossAxisOffset.should.be(0);
      },
    );

    test('Initialization horizontal painter on tine-line main axis direction',
        () {
      final painter = ColoredIntervalPainter.createHorizontal();
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
        ..updateLayoutData(painter);

      painter.data.mainAxisExtend.should.be(layoutEngine.intervalExtent);
      painter.data.crossAxisExtend.should.be(
        elementSizeConstraint.maxHeight -
            layoutEngine.maxCrossAxisIndicatorExtent,
      );
      painter.data.mainAxisOffset.should.be(0);
      painter.data.crossAxisOffset.should
          .be(layoutEngine.maxCrossAxisIndicatorExtent);
      painter.data.numberOfIntervals.should.be(3);
    });

    test('Initialization horizontal painter on tine-line cross axis direction',
        () {
      final painter = ColoredIntervalPainter.createHorizontal();
      final layoutEngine = TestLayoutEngineFactory.create();
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
        ..updateLayoutData(painter);

      // 170 = (elementSizeConstraint.maxWidth-layoutEngine.maxCrossAxisIndicatorExtent)/2;
      painter.data.mainAxisExtend.should.be(170);
      painter.data.crossAxisExtend.should.be(150);
      painter.data.mainAxisOffset.should
          .be(layoutEngine.maxCrossAxisIndicatorExtent);
      painter.data.crossAxisOffset.should.be(0);
      painter.data.numberOfIntervals.should.be(2);
    });

    test('Initialization vertical painter on tine-line cross axis direction',
        () {
      final painter = ColoredIntervalPainter.createVertical();
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
        ..updateLayoutData(painter);

      painter.data.crossAxisExtend.should.be(150);
      // 220 = (elementSizeConstraint.maxHeight-layoutEngine.maxCrossAxisIndicatorExtent)/2;
      painter.data.mainAxisExtend.should.be(220);
      painter.data.crossAxisOffset.should.be(0);
      painter.data.mainAxisOffset.should
          .be(layoutEngine.maxCrossAxisIndicatorExtent);
      painter.data.numberOfIntervals.should.be(2);
    });

    test('Initialization vertical painter on tine-line main axis direction',
        () {
      final painter = ColoredIntervalPainter.createVertical();
      final layoutEngine = TestLayoutEngineFactory.create();
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
        ..updateLayoutData(painter);

      painter.data.crossAxisExtend.should.be(
        elementSizeConstraint.maxWidth -
            layoutEngine.maxCrossAxisIndicatorExtent,
      );
      painter.data.mainAxisExtend.should.be(layoutEngine.intervalExtent);
      painter.data.crossAxisOffset.should
          .be(layoutEngine.maxCrossAxisIndicatorExtent);
      painter.data.mainAxisOffset.should.be(0);
      painter.data.numberOfIntervals.should.be(3);
    });
  });
}
