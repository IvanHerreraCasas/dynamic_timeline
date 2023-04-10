import 'package:dynamic_timeline/src/rendering/dynamic_timeline_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_layout_engine_factory.dart';

class DynamicTimelineLayoutTests {
  static void run() {
    group('DynamicTimeline layout tests', () {
      test(
        'Computer size with max cross axis item extent '
        '--> the calculated size should be the same as the constraints',
        () {
          final layoutEngine = TestLayoutEngineFactory.create()
            ..updateConstraints(const BoxConstraints(
              maxHeight: 500,
              minHeight: 500,
              maxWidth: 300,
              minWidth: 300,
            ));
          final newSize = layoutEngine.computeSize();
          expect(newSize.width, 300);
        },
      );
      test(
        'Computer size with fixed cross axis item extent '
        '--> maxCrossAxisIndicatorExtent+ '
        '(crossAxisSpacing+maxCrossAxisItemExtent)*2 = 144',
        () {
          final layoutEngine = TestLayoutEngineFactory.create(maxCrossAxisItemExtent: 40)
            ..updateConstraints(const BoxConstraints(
              maxHeight: 500,
              minHeight: 500,
              maxWidth: 300,
              minWidth: 300,
            ));
          final newSize = layoutEngine.computeSize();
          //
          expect(newSize.width, 144);
        },
      );

      test(
        'Computer size with fixed main axis item extent smaller than constraint'
        '--> chooses the calculated value (smaller than the constraint)',
        () {
          final layoutEngine = TestLayoutEngineFactory.create()
            ..updateConstraints(const BoxConstraints(
              maxHeight: 500,
              minHeight: 500,
              maxWidth: 300,
              minWidth: 300,
            ));
          final newSize = layoutEngine.computeSize();
          //
          expect(newSize.height < 500, true);
        },
      );
      test(
        'Computer size with fixed main axis item extent bigger than constraint'
        '--> chooses the constraint value',
        () {
          final layoutEngine = TestLayoutEngineFactory.create()
            ..updateConstraints(const BoxConstraints(
              maxHeight: 100,
              minHeight: 100,
              maxWidth: 300,
              minWidth: 300,
            ));
          final newSize = layoutEngine.computeSize();
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
              TestLayoutEngineFactory.create(axis: Axis.horizontal, maxCrossAxisItemExtent: 40)
                ..updateConstraints(sizeConstraint);
          final layoutEngineVertical =
              TestLayoutEngineFactory.create(axis: Axis.vertical, maxCrossAxisItemExtent: 40)
                ..updateConstraints(sizeConstraint);

          final newSizeHorizontal = layoutEngineHorizontal.computeSize();
          final newSizeVertical = layoutEngineVertical.computeSize();

          expect(newSizeHorizontal.height, newSizeVertical.width);
          expect(newSizeHorizontal.width, newSizeVertical.height);
        },
      );
    });
  }
}
