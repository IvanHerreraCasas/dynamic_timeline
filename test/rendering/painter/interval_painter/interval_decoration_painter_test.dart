// ignore_for_file: cascade_invocations

import 'package:dynamic_timeline/dynamic_timeline.dart';
import 'package:dynamic_timeline/src/rendering/painter/interval_painter/background_painter_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shouldly/shouldly.dart';

import '../../../helpers/helpers.dart';

void main() {
  group('Interval painter decoration tests', () {
    test(
        'Vertical decoration line gets painted correctly '
        '--> coordinates as expected from the painter data', () {
      final canvas = _FakeCanvas();
      final idp = IntervalDecorationPainter.createVertical();

      idp.data = BackgroundPainterData(
        crossAxisExtend: 300,
        mainAxisExtend: 500,
        mainAxisOffset: 50,
        crossAxisOffset: 10,
        numberOfIntervals: 1,
      );
      idp.paint(canvas, Offset.zero);

      canvas.getDrawLineCalls(0).p1.dx.should.be(10);
      canvas.getDrawLineCalls(0).p1.dy.should.be(550);

      canvas.getDrawLineCalls(0).p2.dx.should.be(310);
      canvas.getDrawLineCalls(0).p2.dy.should.be(550);
    });

    test(
        'Horizontal decoration line gets painted correctly '
        '--> coordinates as expected from the painter data', () {
      final canvas = _FakeCanvas();
      final idp = IntervalDecorationPainter.createHorizontal();

      idp.data = BackgroundPainterData(
        crossAxisExtend: 300,
        mainAxisExtend: 500,
        mainAxisOffset: 50,
        crossAxisOffset: 10,
        numberOfIntervals: 1,
      );
      idp.paint(canvas, Offset.zero);

      canvas.getDrawLineCalls(0).p1.dx.should.be(550);
      canvas.getDrawLineCalls(0).p1.dy.should.be(10);

      canvas.getDrawLineCalls(0).p2.dx.should.be(550);
      canvas.getDrawLineCalls(0).p2.dy.should.be(310);
    });

    test(
        'Interval selector for even index validation for vertical decorator '
        '--> for 3 intervals there are only 2 painted ', () {
      final canvas = _FakeCanvas();
      final idp = IntervalDecorationPainter.createHorizontal(
        intervalSelector: (idx) => idx.isEven,
      );

      idp.data = BackgroundPainterData(
        crossAxisExtend: 300,
        mainAxisExtend: 500,
        mainAxisOffset: 50,
        crossAxisOffset: 10,
        numberOfIntervals: 3,
      );
      idp.paint(canvas, Offset.zero);

      canvas.numDrawRectCalls.should.be(2);
    });

    test(
        'Interval selector for odd index validation for horizontal decorator '
        '--> for 3 intervals there are only 1 painted ', () {
      final canvas = _FakeCanvas();
      final idp = IntervalDecorationPainter.createHorizontal(
        intervalSelector: (idx) => idx % 2 != 0,
      );

      idp.data = BackgroundPainterData(
        crossAxisExtend: 300,
        mainAxisExtend: 500,
        mainAxisOffset: 50,
        crossAxisOffset: 10,
        numberOfIntervals: 3,
      );
      idp.paint(canvas, Offset.zero);

      canvas.numDrawRectCalls.should.be(1);
    });

    test('Changing the decoration color to red on a horizontal decorator', () {
      final canvas = _FakeCanvas();
      final idp = IntervalDecorationPainter.createHorizontal(
        intervalSelector: (idx) => idx % 2 != 0,
        paint: Paint()..color = Colors.red,
      );

      idp.data = BackgroundPainterData(
        crossAxisExtend: 300,
        mainAxisExtend: 500,
        mainAxisOffset: 50,
        crossAxisOffset: 10,
        numberOfIntervals: 3,
      );
      idp.paint(canvas, Offset.zero);

      canvas.getDrawLineCalls(0).paint.color.should.be(Colors.red);
    });

    test('Changing the decoration color to green on a vertical decorator', () {
      final canvas = _FakeCanvas();
      final idp = IntervalDecorationPainter.createVertical(
        paint: Paint()..color = Colors.green,
      );

      idp.data = BackgroundPainterData(
        crossAxisExtend: 300,
        mainAxisExtend: 500,
        mainAxisOffset: 50,
        crossAxisOffset: 10,
        numberOfIntervals: 2,
      );
      idp.paint(canvas, Offset.zero);

      canvas.getDrawLineCalls(0).paint.color.should.be(Colors.green);
      canvas.getDrawLineCalls(1).paint.color.should.be(Colors.green);
    });
  });
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
  _FakeDrawLineCall(this.p1, this.p2, this.paint);
  final Offset p1;
  final Offset p2;
  final Paint paint;
}
