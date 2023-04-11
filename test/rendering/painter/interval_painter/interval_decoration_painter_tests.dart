import 'package:dynamic_timeline/src/rendering/painter/interval_painter/background_painter_data.dart';
import 'package:dynamic_timeline/dynamic_timeline.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:shouldly/shouldly.dart';

class IntervalDecorationPainterTests {
  static void run() {
    group('Interval painter decoration tests', () {
      test('Vertical decoration line gets painted correctly '
          '--> coordinates as expected from the painter data', () {
        var canvas = _FakeCanvas();
        var idp = IntervalDecorationPainter.createVertical();

        idp.data = BackgroundPainterData(
          crossAxisExtend: 300,
          mainAxisExtend: 500,
          mainAxisOffset: 50,
          crossAxisOffset: 10,
          numberOfIntervals: 1,
        );
        idp.paint(canvas, Offset.zero);

        canvas.getDrawLineCalls(0).p1.dx.should.be( 10);
        canvas.getDrawLineCalls(0).p1.dy.should.be( 550);

        canvas.getDrawLineCalls(0).p2.dx.should.be( 310);
        canvas.getDrawLineCalls(0).p2.dy.should.be( 550);

      });


      test('Horizontal decoration line gets painted correctly '
          '--> coordinates as expected from the painter data', () {
        var canvas = _FakeCanvas();
        var idp = IntervalDecorationPainter.createHorizontal();

        idp.data = BackgroundPainterData(
          crossAxisExtend: 300,
          mainAxisExtend: 500,
          mainAxisOffset: 50,
          crossAxisOffset: 10,
          numberOfIntervals: 1,
        );
        idp.paint(canvas, Offset.zero);

        canvas.getDrawLineCalls(0).p1.dx.should.be( 550);
        canvas.getDrawLineCalls(0).p1.dy.should.be( 10);

        canvas.getDrawLineCalls(0).p2.dx.should.be( 550);
        canvas.getDrawLineCalls(0).p2.dy.should.be( 310);

      });
    });
  }
}

class _FakeCanvas extends Fake implements Canvas {
  final List<_FakeDrawLineCall> _drawLineCalls = [];

  @override
  void drawLine(Offset p1, Offset p2, Paint paint) =>
      _drawLineCalls.add(_FakeDrawLineCall(p1, p2, paint));

  int get numDrawRectCalls => _drawLineCalls.length;

  _FakeDrawLineCall getDrawLineCalls(int idx) => _drawLineCalls[idx];
}

class _FakeDrawLineCall {
  final Offset p1;
  final Offset p2;
  final Paint paint;

  _FakeDrawLineCall(this.p1, this.p2, this.paint);
}
