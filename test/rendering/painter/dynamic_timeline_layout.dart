import 'package:dynamic_timeline/src/rendering/dynamic_timeline_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class DynamicTimelineLayoutTests {
  static void run() {
    group('DynamicTimeline layout tests', () {

      test(
        'Computer size with max cross axis item extent '
            '--> the calculated size should be the same as the constraints',
            () {
          final layoutEngine = DynamicTimelineLayout(
            intervalExtent: 50,
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            maxCrossAxisIndicatorExtent: 20,
            maxCrossAxisItemExtent: double.infinity,
            axis: Axis.vertical,
            firstDateTime: DateTime(2023, 1, 1, 7),
            lastDateTime: DateTime(2023, 1, 1, 7 + 3),
            intervalDuration: const Duration(hours: 1),
          );
          final newSize = layoutEngine.computeSize(
            constraints: const BoxConstraints(
              maxHeight: 500,
              minHeight: 500,
              maxWidth: 300,
              minWidth: 300,
            ),
          );
          expect(newSize.width, 300);
        },

      );
    });
  }
}
