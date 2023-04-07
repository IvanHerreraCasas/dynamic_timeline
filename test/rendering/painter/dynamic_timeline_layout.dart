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
          final layoutEngine = _produceLayoutEngine();
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
      test(
        'Computer size with fixed cross axis item extent '
        '--> maxCrossAxisIndicatorExtent+ '
        '(crossAxisSpacing+maxCrossAxisItemExtent)*2 = 144',
        () {
          final layoutEngine = _produceLayoutEngine(maxCrossAxisItemExtent: 40);
          final newSize = layoutEngine.computeSize(
            constraints: const BoxConstraints(
              maxHeight: 500,
              minHeight: 500,
              maxWidth: 300,
              minWidth: 300,
            ),
          );
          //
          expect(newSize.width, 144);
        },
      );

      test(
        'Computer size with fixed main axis item extent smaller than constraint'
        '--> chooses the calculated value (smaller than the constraint)',
        () {
          final layoutEngine = _produceLayoutEngine();
          final newSize = layoutEngine.computeSize(
            constraints: const BoxConstraints(
              maxHeight: 500,
              minHeight: 500,
              maxWidth: 300,
              minWidth: 300,
            ),
          );
          //
          expect(newSize.height < 500, true);
        },
      );
      test(
        'Computer size with fixed main axis item extent bigger than constraint'
        '--> chooses the constraint value',
        () {
          final layoutEngine = _produceLayoutEngine();
          final newSize = layoutEngine.computeSize(
            constraints: const BoxConstraints(
              maxHeight: 100,
              minHeight: 100,
              maxWidth: 300,
              minWidth: 300,
            ),
          );
          expect(newSize.height, 100);
        },
      );

      test(
        'Switching the axis from horizontal to vertical '
        '--> size width and height are getting also switched',
        () {
          const sizeConstraint = BoxConstraints(
            maxHeight: 500,
            minHeight: 500,
            maxWidth: 300,
            minWidth: 300,
          );
          final layoutEngineHorizontal =
              _produceLayoutEngine(axis: Axis.horizontal, maxCrossAxisItemExtent: 40);
          final layoutEngineVertical =
              _produceLayoutEngine(axis: Axis.vertical, maxCrossAxisItemExtent: 40);

          final newSizeHorizontal = layoutEngineHorizontal.computeSize(
            constraints: sizeConstraint,
          );
          final newSizeVertical = layoutEngineVertical.computeSize(
            constraints: sizeConstraint,
          );

          expect(newSizeHorizontal.height, newSizeVertical.width);
          expect(newSizeHorizontal.width, newSizeVertical.height);
        },
      );
    });
  }

  static DynamicTimelineLayout _produceLayoutEngine(
      {double maxCrossAxisItemExtent = double.infinity, Axis axis = Axis.vertical}) {
    return DynamicTimelineLayout(
      intervalExtent: 50,
      crossAxisCount: 2,
      crossAxisSpacing: 2,
      maxCrossAxisIndicatorExtent: 60,
      maxCrossAxisItemExtent: maxCrossAxisItemExtent,
      axis: axis,
      firstDateTime: DateTime(2023, 1, 1, 7),
      lastDateTime: DateTime(2023, 1, 1, 7 + 3),
      intervalDuration: const Duration(hours: 1),
    );
  }
}
