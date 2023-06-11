// ignore_for_file: flutter_style_todos, avoid_redundant_argument_values, lines_longer_than_80_chars, cast_nullable_to_non_nullable

import 'package:dynamic_timeline/dynamic_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shouldly/shouldly.dart';

void main() {
  group('label_builder tests', () {
    test(
        'Test creation by factory fromString '
        '--> builder builds a text widget', () async {
      final builder = LabelBuilder.fromString((date) => date.toString());
      final now = DateTime.now();
      builder.builder(now).should.beOfType<Text>();
    });
    test(
        'Test creation by factory fromString '
        '--> the string builder gets called', () async {
      var calls = 0;
      final builder = LabelBuilder.fromString((date) {
        calls++;
        return date.toString();
      });
      builder.builder(DateTime.now());
      calls.should.be(1);
    });
    test(
        'Test creation by factory fromString '
        '--> Text widget contains the exact return string', () async {
      final builder = LabelBuilder.fromString((date) => 'TEST_123');
      final textWidget = builder.builder(DateTime.now()) as Text;
      textWidget.data.should.be('TEST_123');
    });

    test(
        'Test creation of labels by "create" function 2 days with day interval '
        '-->  Array of two text labels', () async {
      // TODO: Last day is not included in the interval. I personally
      // TODO: think it's counterintuitive. Maybe change it?
      // TODO: (this will be not only label builder, but rather the whole timeline)
      final builder = LabelBuilder.fromString((date) => 'TEST_123');
      final labels = builder.create(
        DateTime(2023, 1, 1),
        DateTime(2023, 1, 3),
        const Duration(days: 1),
      );
      labels.length.should.be(2);
    });

    test(
        'Test creation of labels by "create" function 2 days with day interval '
        '-->  Text builder should be called with the correct dates', () async {
      final builder = LabelBuilder.fromString((date) => date.toString());
      final labels = builder.create(
        DateTime(2023, 1, 1),
        DateTime(2023, 1, 3),
        const Duration(days: 1),
      );
      (labels[0].child as Text).data.should.be(DateTime(2023, 1, 1).toString());
      (labels[1].child as Text).data.should.be(DateTime(2023, 1, 2).toString());
    });
  });
}
