import 'package:dynamic_timeline/dynamic_timeline.dart';
import 'package:dynamic_timeline/src/rendering/painter/interval_painter/background_painter_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shouldly/shouldly.dart';
import '../../../helpers/helpers.dart';
import 'package:flutter/material.dart';

class ColoredIntervalPainterTests {
  static void run() {
    group('Colored interval painter tests', () {
      test('Calling the painter on 3 intervals and a callback always returning a color '
          '--> The fake canvas gets called all 3 times', () {
        var canvas = _FakeCanvas();
        var cip = ColoredIntervalPainter.createHorizontal(intervalColorCallback: (idx) => Colors.red);
        cip.data = BackgroundPainterData(
          crossAxisExtend: 300,
          mainAxisExtend: 500,
          mainAxisOffset: 0,
          crossAxisOffset: 0,
          numberOfIntervals: 3,
        );
        cip.paint(canvas, Offset.zero);
       canvas.numDrawRectCalls.should.be( 3);
      });

      test('Calling the painter on 3 intervals with default callback '
          '--> The fake canvas gets called all 2 times since the default only triggers '
          ' on even elements', () {
        var canvas = _FakeCanvas();
        var cip = ColoredIntervalPainter.createHorizontal();
        cip.data = BackgroundPainterData(
          crossAxisExtend: 300,
          mainAxisExtend: 500,
          mainAxisOffset: 0,
          crossAxisOffset: 0,
          numberOfIntervals: 3,
        );
        cip.paint(canvas, Offset.zero);
        canvas.numDrawRectCalls.should.be( 2);
      });

      test('Calling a horizontal painter on 1 interval '
          '--> Gets called with all the right parameters', () {
        var canvas = _FakeCanvas();
        var cip = ColoredIntervalPainter.createHorizontal(intervalColorCallback: (idx) => Colors.red);
        cip.data = BackgroundPainterData(
          crossAxisExtend: 300,
          mainAxisExtend: 500,
          mainAxisOffset: 50,
          crossAxisOffset: 10,
          numberOfIntervals: 1,
        );
        cip.paint(canvas, Offset.zero);

        canvas.getDrawRectCalls(0).rect.width.should.be( 500);
        canvas.getDrawRectCalls(0).rect.height.should.be( 300);
        canvas.getDrawRectCalls(0).rect.left.should.be( 50);
        canvas.getDrawRectCalls(0).rect.top.should.be( 10);
      });

      test('Calling a vertical painter on 1 interval '
          '--> Gets called with all the right parameters', () {
        var canvas = _FakeCanvas();
        var cip = ColoredIntervalPainter.createVertical(intervalColorCallback: (idx) => Colors.red);
        cip.data = BackgroundPainterData(
          crossAxisExtend: 300,
          mainAxisExtend: 500,
          mainAxisOffset: 50,
          crossAxisOffset: 10,
          numberOfIntervals: 1,
        );
        cip.paint(canvas, Offset.zero);

        canvas.getDrawRectCalls(0).rect.width.should.be( 300);
        canvas.getDrawRectCalls(0).rect.height.should.be( 500);
        canvas.getDrawRectCalls(0).rect.left.should.be( 10);
        canvas.getDrawRectCalls(0).rect.top.should.be( 50);
        canvas.getDrawRectCalls(0).paint.color.should.be(Colors.red);
      });

      test('Calling a vertical painter on 2 intervals with first blue and second green '
          '--> The paint color should be switched accordingly', () {
        var canvas = _FakeCanvas();
        var cip = ColoredIntervalPainter.createVertical(intervalColorCallback:
            (idx) => [Colors.blue,Colors.green][idx]);
        cip.data = BackgroundPainterData(
          crossAxisExtend: 300,
          mainAxisExtend: 500,
          mainAxisOffset: 50,
          crossAxisOffset: 10,
          numberOfIntervals: 2,
        );
        cip.paint(canvas, Offset.zero);


        canvas.getDrawRectCalls(0).paint.color.should.be(Colors.blue);
        canvas.getDrawRectCalls(1).paint.color.should.be(Colors.green);
      });
    });
  }
}

class _FakeCanvas extends Fake implements Canvas {
  final List<_FakeDrawRectCall> _drawRectCalls = [];

  @override
  void drawRect(Rect rect, Paint paint) => _drawRectCalls.add(_FakeDrawRectCall(rect, paint));

  int get numDrawRectCalls => _drawRectCalls.length;

  _FakeDrawRectCall getDrawRectCalls(int idx) => _drawRectCalls[idx];
}

class _FakeDrawRectCall {
  final Rect rect;
  final Paint paint;

  _FakeDrawRectCall(this.rect, this.paint);
}
