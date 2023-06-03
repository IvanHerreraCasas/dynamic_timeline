// ignore_for_file: lines_longer_than_80_chars, cascade_invocations

import 'package:dynamic_timeline/dynamic_timeline.dart';
import 'package:dynamic_timeline/src/rendering/painter/interval_painter/background_painter_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shouldly/shouldly.dart';

import '../../../helpers/helpers.dart';

void main() {
  group('Colored interval painter tests', () {
    test(
        'Calling the painter on 3 intervals and a callback always returning a color '
        '--> The fake canvas gets called all 3 times', () {
      final canvas = _FakeCanvas();
      final cip = ColoredIntervalPainter.createHorizontal(
        paint: Paint()..color = Colors.red,
        intervalSelector: (idx) => true,
      );
      cip.data = BackgroundPainterData(
        crossAxisExtend: 300,
        mainAxisExtend: 500,
        numberOfIntervals: 3,
      );
      cip.paint(canvas, Offset.zero);
      canvas.numDrawRectCalls.should.be(3);
    });

    test(
        'Calling the painter on 3 intervals and default interval selector '
        '--> only even intervals get painted so there should be only to calls to draw rect',
        () {
      final canvas = _FakeCanvas();
      final cip = ColoredIntervalPainter.createHorizontal(
        paint: Paint()..color = Colors.yellow,
      );
      cip.data = BackgroundPainterData(
        crossAxisExtend: 300,
        mainAxisExtend: 500,
        numberOfIntervals: 3,
      );
      cip.paint(canvas, Offset.zero);
      canvas.numDrawRectCalls.should.be(2);
      canvas.getDrawRectCalls(1).paint.color.should.be(Colors.yellow);
    });

    test(
        'Calling the painter on 3 intervals with default callback '
        '--> The fake canvas gets called all 2 times since the default only triggers '
        ' on even elements', () {
      final canvas = _FakeCanvas();
      final cip = ColoredIntervalPainter.createHorizontal();
      cip.data = BackgroundPainterData(
        crossAxisExtend: 300,
        mainAxisExtend: 500,
        numberOfIntervals: 3,
      );
      cip.paint(canvas, Offset.zero);
      canvas.numDrawRectCalls.should.be(2);
    });

    test(
        'Calling a horizontal painter on 1 interval '
        '--> Gets called with all the right parameters', () {
      final canvas = _FakeCanvas();
      final cip = ColoredIntervalPainter.createHorizontal(
        paint: Paint()..color = Colors.red,
      );
      cip.data = BackgroundPainterData(
        crossAxisExtend: 300,
        mainAxisExtend: 500,
        mainAxisOffset: 50,
        crossAxisOffset: 10,
        numberOfIntervals: 1,
      );
      cip.paint(canvas, Offset.zero);

      canvas.getDrawRectCalls(0).rect.width.should.be(500);
      canvas.getDrawRectCalls(0).rect.height.should.be(300);
      canvas.getDrawRectCalls(0).rect.left.should.be(50);
      canvas.getDrawRectCalls(0).rect.top.should.be(10);
    });

    test(
        'Calling a vertical painter on 1 interval '
        '--> Gets called with all the right parameters', () {
      final canvas = _FakeCanvas();
      final cip = ColoredIntervalPainter.createVertical(
        paint: Paint()..color = Colors.green,
      );
      cip.data = BackgroundPainterData(
        crossAxisExtend: 300,
        mainAxisExtend: 500,
        mainAxisOffset: 50,
        crossAxisOffset: 10,
        numberOfIntervals: 1,
      );
      cip.paint(canvas, Offset.zero);

      canvas.getDrawRectCalls(0).rect.width.should.be(300);
      canvas.getDrawRectCalls(0).rect.height.should.be(500);
      canvas.getDrawRectCalls(0).rect.left.should.be(10);
      canvas.getDrawRectCalls(0).rect.top.should.be(50);
      canvas.getDrawRectCalls(0).paint.color.should.be(Colors.green);
    });

    test(
        'Calling a vertical painter on 2 intervals with always true selector '
        '--> Draw rect should be called twice', () {
      final canvas = _FakeCanvas();
      final cip = ColoredIntervalPainter.createVertical(
        intervalSelector: (idx) => true,
      );
      cip.data = BackgroundPainterData(
        crossAxisExtend: 300,
        mainAxisExtend: 500,
        mainAxisOffset: 50,
        crossAxisOffset: 10,
        numberOfIntervals: 2,
      );
      cip.paint(canvas, Offset.zero);

      canvas.numDrawRectCalls.should.be(2);
    });
  });
}

class _FakeCanvas extends Fake implements Canvas {
  final List<_FakeDrawRectCall> _drawRectCalls = [];

  @override
  void drawRect(Rect rect, Paint paint) =>
      _drawRectCalls.add(_FakeDrawRectCall(rect, paint));

  int get numDrawRectCalls => _drawRectCalls.length;

  _FakeDrawRectCall getDrawRectCalls(int idx) => _drawRectCalls[idx];
}

class _FakeDrawRectCall {
  _FakeDrawRectCall(this.rect, this.paint);
  final Rect rect;
  final Paint paint;
}
