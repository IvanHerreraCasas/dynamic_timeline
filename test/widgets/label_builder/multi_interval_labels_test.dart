// ignore_for_file: unused_local_variable, avoid_redundant_argument_values, lines_longer_than_80_chars

import 'package:dynamic_timeline/dynamic_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shouldly/shouldly.dart';

void main() {
  group('Testing multi-interval labels', () {
    test(
      'Creating a 2 days timeline with iterval 1D and label spred 2D '
      '--> should create one label',
      () {
        var calls = 0;
        final timelines = DynamicTimeline(
          firstDateTime: DateTime(2023),
          lastDateTime: DateTime(2023, 1, 3),
          labelBuilder: LabelBuilder(
            intervalExtend: 2,
            builder: (labelDate) {
              calls++;
              return const Text('date');
            },
          ),
          items: const [],
          intervalDuration: const Duration(days: 1),
        );

        expect(calls, 1);
      },
    );

    test(
      'Creating a 4 days timeline with iterval 1D and label spred 2D '
      '--> should create two labels',
      () {
        var calls = 0;
        final timelines = DynamicTimeline(
          firstDateTime: DateTime(2023, 1, 1),
          lastDateTime: DateTime(2023, 1, 5),
          labelBuilder: LabelBuilder(
            intervalExtend: 2,
            builder: (labelDate) {
              calls++;
              return const Text('date');
            },
          ),
          items: const [],
          intervalDuration: const Duration(days: 1),
        );

        expect(calls, 2);
      },
    );

    test(
      'Creating a 4 days timeline with iterval 1D and label spred 2D '
      '--> the second interval should be 2 days after the first',
      () {
        final dates = <DateTime>[];
        final startDate = DateTime(2023, 1, 1);
        final timelines = DynamicTimeline(
          firstDateTime: startDate,
          lastDateTime: DateTime(2023, 1, 5),
          labelBuilder: LabelBuilder(
            intervalExtend: 2,
            builder: (labelDate) {
              dates.add(labelDate);
              return const Text('date');
            },
          ),
          items: const [],
          intervalDuration: const Duration(days: 1),
        );

        const twoDays = Duration(days: 2);
        dates[0].toIso8601String().should.be(startDate.toIso8601String());
        dates[1]
            .toIso8601String()
            .should
            .be(startDate.add(twoDays).toIso8601String());
      },
    );

    test(
      'Creating a 4 days timeline with iterval 1D and label spred 2D '
      '--> the two child item should have a duration of 2 days',
      () {
        final dates = <DateTime>[];
        final startDate = DateTime(2023, 1, 1);
        final timelines = DynamicTimeline(
          firstDateTime: startDate,
          lastDateTime: DateTime(2023, 1, 5),
          labelBuilder: LabelBuilder(
            intervalExtend: 2,
            builder: (labelDate) {
              dates.add(labelDate);
              return const Text('date');
            },
          ),
          items: const [],
          intervalDuration: const Duration(days: 1),
        );

        const twoDays = Duration(days: 2);
        final item1 = timelines.children[0] as TimelineItem;
        final item2 = timelines.children[1] as TimelineItem;

        final item1Duration = item1.endDateTime.difference(item1.startDateTime);
        final item2Duration = item2.endDateTime.difference(item2.startDateTime);

        item1Duration.should.be(twoDays);
        item2Duration.should.be(twoDays);
      },
    );

    test(
      'Creating a 3 days timeline with iterval 1D and label extend 2D '
      '-->  Should still ceil to the upper limit, since the last header gets'
      ' cropped by the bounding box ',
      () {
        final dates = <DateTime>[];
        final startDate = DateTime(2023, 1, 1);
        final timelines = DynamicTimeline(
          firstDateTime: startDate,
          lastDateTime: DateTime(2023, 1, 4),
          labelBuilder: LabelBuilder(
            intervalExtend: 2,
            builder: (labelDate) {
              dates.add(labelDate);
              return const Text('date');
            },
          ),
          items: const [],
          intervalDuration: const Duration(days: 1),
        );

        final item1 = timelines.children[0] as TimelineItem;
        final item2 = timelines.children[1] as TimelineItem;

        final item1Duration = item1.endDateTime.difference(item1.startDateTime);
        final item2Duration = item2.endDateTime.difference(item2.startDateTime);

        item1Duration.should.be(const Duration(days: 2));
        item2Duration.should.be(const Duration(days: 2));
      },
    );
  });
}
