import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shouldly/shouldly.dart';
import 'test_layout_engine_factory.dart';

void main() {
  group('DynamicTimeline layout tests', () {
    test(
      'Computer size with max cross axis item extent '
      '--> the calculated size should be the same as the constraints',
      () {
        final layoutEngine = TestLayoutEngineFactory.create()
          ..updateConstraints(
            const BoxConstraints(
              maxHeight: 500,
              minHeight: 500,
              maxWidth: 300,
              minWidth: 300,
            ),
          );
        final newSize = layoutEngine.computeSize();
        newSize.width.should.be(300);
      },
    );
    test(
      'Computer size with fixed cross axis item extent '
      '--> maxCrossAxisIndicatorExtent+ '
      '(crossAxisSpacing+maxCrossAxisItemExtent)*2 = 144',
      () {
        final layoutEngine =
            TestLayoutEngineFactory.create(maxCrossAxisItemExtent: 40)
              ..updateConstraints(
                const BoxConstraints(
                  maxHeight: 500,
                  minHeight: 500,
                  maxWidth: 300,
                  minWidth: 300,
                ),
              );
        final newSize = layoutEngine.computeSize();

        newSize.width.should.be(144);
      },
    );

    test(
      'Computer size with fixed main axis item extent smaller than constraint '
      '--> chooses the calculated value (smaller than the constraint)',
      () {
        final layoutEngine = TestLayoutEngineFactory.create()
          ..updateConstraints(
            const BoxConstraints(
              maxHeight: 500,
              minHeight: 500,
              maxWidth: 300,
              minWidth: 300,
            ),
          );
        final newSize = layoutEngine.computeSize();

        newSize.height.should.beLessThan(500);
      },
    );
    test(
      'Computer size with fixed main axis item extent bigger than constraint '
      '--> chooses the constraint value',
      () {
        final layoutEngine = TestLayoutEngineFactory.create()
          ..updateConstraints(
            const BoxConstraints(
              maxHeight: 100,
              minHeight: 100,
              maxWidth: 300,
              minWidth: 300,
            ),
          );
        final newSize = layoutEngine.computeSize();
        newSize.height.should.be(100);
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
        final layoutEngineHorizontal = TestLayoutEngineFactory.create(
          axis: Axis.horizontal,
          maxCrossAxisItemExtent: 40,
        )..updateConstraints(sizeConstraint);
        final layoutEngineVertical = TestLayoutEngineFactory.create(
          maxCrossAxisItemExtent: 40,
        )..updateConstraints(sizeConstraint);

        final newSizeHorizontal = layoutEngineHorizontal.computeSize();
        final newSizeVertical = layoutEngineVertical.computeSize();

        newSizeHorizontal.height.should.be(newSizeVertical.width);
        newSizeHorizontal.width.should.be(newSizeVertical.height);
      },
    );
  });
}
