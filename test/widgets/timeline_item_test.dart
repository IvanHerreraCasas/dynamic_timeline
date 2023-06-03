// ignore_for_file: lines_longer_than_80_chars

import 'package:dynamic_timeline/dynamic_timeline.dart';
import 'package:dynamic_timeline/src/rendering/render_timeline_item.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/helpers.dart';

void main() {
  group('TimelineItem', () {
    Widget buildSubject({
      Axis axis = Axis.vertical,
      DateTime? startDateTime,
      DateTime? endDateTime,
      int position = 0,
      void Function(DateTime)? onStartDateTimeChanged,
      void Function(DateTime)? onEndDateTimeChanged,
      void Function(DateTime)? onStartDateTimeUpdated,
      void Function(DateTime)? onEndDateTimeUpdated,
    }) {
      return DynamicTimeline(
        firstDateTime: DateTime(1970, 1, 1, 8),
        lastDateTime: DateTime(1970, 1, 1, 12),
        labelBuilder: LabelBuilder(
          builder: (labelDate) {
            return const Text('date');
          },
        ),
        axis: axis,
        intervalDuration: const Duration(hours: 1),
        crossAxisCount: 2,
        items: [
          TimelineItem(
            key: const Key('key'),
            startDateTime: startDateTime ?? DateTime(1970, 1, 1, 9),
            endDateTime: endDateTime ?? DateTime(1970, 1, 1, 10),
            position: position,
            onStartDateTimeChanged: onStartDateTimeChanged,
            onEndDateTimeChanged: onEndDateTimeChanged,
            onStartDateTimeUpdated: onStartDateTimeUpdated,
            onEndDateTimeUpdated: onEndDateTimeUpdated,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                color: Colors.red,
              ),
            ),
          ),
        ],
      );
    }

    group('createRenderObject', () {
      testWidgets('creates RenderTimelineItem properly', (tester) async {
        await tester.pumpApp(buildSubject());

        final renderTimelineItem = tester.renderObject<RenderTimelineItem>(
          find.byType(TimelineItem),
        );

        expect(renderTimelineItem.startDateTime, DateTime(1970, 1, 1, 9));
        expect(renderTimelineItem.endDateTime, DateTime(1970, 1, 1, 10));
        expect(renderTimelineItem.position, 0);
        expect(renderTimelineItem.onStartDateTimeChanged, null);
        expect(renderTimelineItem.onEndDateTimeChanged, null);
        expect(renderTimelineItem.onStartDateTimeUpdated, null);
        expect(renderTimelineItem.onEndDateTimeUpdated, null);
      });
    });

    group('updateRenderObject', () {
      testWidgets('updates RenderTimelineItem properly', (tester) async {
        await tester.pumpApp(buildSubject());

        void mockFunction(DateTime dateTime) {}

        await tester.pumpApp(
          buildSubject(
            startDateTime: DateTime(1970, 1, 1, 8),
            endDateTime: DateTime(1970, 1, 1, 9),
            position: 1,
            onStartDateTimeChanged: mockFunction,
            onEndDateTimeChanged: mockFunction,
            onStartDateTimeUpdated: mockFunction,
            onEndDateTimeUpdated: mockFunction,
          ),
        );

        final renderTimelineItem = tester.renderObject<RenderTimelineItem>(
          find.byType(TimelineItem),
        );

        expect(renderTimelineItem.startDateTime, DateTime(1970, 1, 1, 8));
        expect(renderTimelineItem.endDateTime, DateTime(1970, 1, 1, 9));
        expect(renderTimelineItem.position, 1);
        expect(renderTimelineItem.onStartDateTimeChanged, mockFunction);
        expect(renderTimelineItem.onEndDateTimeChanged, mockFunction);
        expect(renderTimelineItem.onStartDateTimeUpdated, mockFunction);
        expect(renderTimelineItem.onEndDateTimeUpdated, mockFunction);
      });
    });

    group('renderObject', () {
      group('mouse coursor', () {
        group('vertical', () {
          testWidgets(
              'renders SystemMouseCursors.resizeUp '
              'when is in the top', (tester) async {
            await tester.pumpApp(buildSubject());

            final gesture = await tester.createGesture(
              kind: PointerDeviceKind.mouse,
            );

            addTearDown(() async => gesture.removePointer());

            final centerLocation = tester.getCenter(find.byType(TimelineItem));
            final topLocation = centerLocation.translate(0, -50);

            await gesture.moveTo(topLocation);

            await tester.pump();

            expect(
              RendererBinding.instance.mouseTracker.debugDeviceActiveCursor(1),
              SystemMouseCursors.resizeUp,
            );
          });

          testWidgets(
              'renders SystemMouseCursors.resizeDown '
              'when is in the bottom', (tester) async {
            await tester.pumpApp(buildSubject());

            final gesture = await tester.createGesture(
              kind: PointerDeviceKind.mouse,
            );

            addTearDown(() async => gesture.removePointer());

            final centerLocation = tester.getCenter(find.byType(TimelineItem));
            final bottomLocation = centerLocation.translate(0, 49);

            await gesture.moveTo(bottomLocation);

            await tester.pump();

            expect(
              RendererBinding.instance.mouseTracker.debugDeviceActiveCursor(1),
              SystemMouseCursors.resizeDown,
            );
          });

          testWidgets(
              'renders SystemMouseCursors.basic '
              'when is not in any border', (tester) async {
            await tester.pumpApp(buildSubject());

            final gesture = await tester.createGesture(
              kind: PointerDeviceKind.mouse,
            );

            addTearDown(() async => gesture.removePointer());

            final centerLocation = tester.getCenter(find.byType(TimelineItem));

            await gesture.moveTo(centerLocation);

            await tester.pump();

            expect(
              RendererBinding.instance.mouseTracker.debugDeviceActiveCursor(1),
              SystemMouseCursors.basic,
            );
          });
        });

        group('horizontal', () {
          testWidgets(
              'renders SystemMouseCursors.resizeLeft '
              'when is in the left', (tester) async {
            await tester.pumpApp(buildSubject(axis: Axis.horizontal));

            final gesture = await tester.createGesture(
              kind: PointerDeviceKind.mouse,
            );

            addTearDown(() async => gesture.removePointer());

            final centerLocation = tester.getCenter(find.byType(TimelineItem));
            final leftLocation = centerLocation.translate(-50, 0);

            await gesture.moveTo(leftLocation);

            await tester.pump();

            expect(
              RendererBinding.instance.mouseTracker.debugDeviceActiveCursor(1),
              SystemMouseCursors.resizeLeft,
            );
          });

          testWidgets(
              'renders SystemMouseCursors.resizeRight '
              'when is in the right', (tester) async {
            await tester.pumpApp(buildSubject(axis: Axis.horizontal));

            final gesture = await tester.createGesture(
              kind: PointerDeviceKind.mouse,
            );

            addTearDown(() async => gesture.removePointer());

            final centerLocation = tester.getCenter(find.byType(TimelineItem));
            final rightLocation = centerLocation.translate(49, 0);

            await gesture.moveTo(rightLocation);

            await tester.pump();

            expect(
              RendererBinding.instance.mouseTracker.debugDeviceActiveCursor(1),
              SystemMouseCursors.resizeRight,
            );
          });

          testWidgets(
              'renders SystemMouseCursors.basic '
              'when is not in any border', (tester) async {
            await tester.pumpApp(buildSubject(axis: Axis.horizontal));

            final gesture = await tester.createGesture(
              kind: PointerDeviceKind.mouse,
            );

            addTearDown(() async => gesture.removePointer());

            final centerLocation = tester.getCenter(find.byType(TimelineItem));

            await gesture.moveTo(centerLocation);

            await tester.pump();

            expect(
              RendererBinding.instance.mouseTracker.debugDeviceActiveCursor(1),
              SystemMouseCursors.basic,
            );
          });
        });
      });

      group('resize', () {
        group('vertical', () {
          testWidgets(
              'when is dragging on the top '
              'change top location, '
              'call startTimeUpdated, '
              'and call startTimeChanged at the end', (tester) async {
            DateTime? finalStartTime;
            DateTime? startTime;

            await tester.pumpApp(
              buildSubject(
                onStartDateTimeChanged: (dateTime) => finalStartTime = dateTime,
                onStartDateTimeUpdated: (dateTime) => startTime = dateTime,
              ),
            );

            final gesture = await tester.createGesture(
              kind: PointerDeviceKind.mouse,
            );

            addTearDown(() async => gesture.removePointer());

            final centerLocation = tester.getCenter(find.byType(TimelineItem));

            final topLocation = centerLocation.translate(0, -50);

            final expectedTopLocation = topLocation.translate(0, -50);

            await gesture.down(topLocation);

            // move to arbitrary location
            await gesture.moveTo(expectedTopLocation.translate(0, 25));

            // 100 pixels = 1 hour => 25 pixels 15mins
            expect(startTime, DateTime(1970, 1, 1, 8, 45));
            expect(finalStartTime, null);

            // move to expected location
            await gesture.moveTo(expectedTopLocation);

            await gesture.up();

            await tester.pump();

            final newTopLocation = tester.getTopLeft(find.byType(TimelineItem));

            expect(newTopLocation.dy, expectedTopLocation.dy);

            // 100 pixels = 1 hour => 50 pixels 30mins
            expect(finalStartTime, DateTime(1970, 1, 1, 8, 30));
          });

          testWidgets(
              'when dragging on the bottom '
              'change bottom location '
              'call endTimeUpdated, '
              'and call endTimeChanged at the end', (tester) async {
            DateTime? endTime;
            DateTime? finalEndTime;

            await tester.pumpApp(
              buildSubject(
                onEndDateTimeChanged: (dateTime) => finalEndTime = dateTime,
                onEndDateTimeUpdated: (dateTime) => endTime = dateTime,
              ),
            );

            final gesture = await tester.createGesture(
              kind: PointerDeviceKind.mouse,
            );

            addTearDown(() async => gesture.removePointer());

            final centerLocation = tester.getCenter(find.byType(TimelineItem));

            final bottomLocation = centerLocation.translate(0, 49);
            final expectedBottomLocation = bottomLocation.translate(0, 49);

            await gesture.down(bottomLocation);

            // move to arbitrary location
            await gesture.moveTo(expectedBottomLocation.translate(0, -25));

            // 100 pixels = 1 hour => 25 pixels 15mins
            expect(
              endTime?.difference(DateTime(1970, 1, 1, 10, 15)),
              lessThan(const Duration(minutes: 1)),
            );
            expect(finalEndTime, null);

            /// move to expeted location
            await gesture.moveTo(expectedBottomLocation);

            await gesture.up();

            await tester.pump();

            final newBottomLocation = tester
                .getBottomLeft(
                  find.byType(TimelineItem),
                )
                .translate(0, -1);

            expect(newBottomLocation.dy, expectedBottomLocation.dy);

            // 100 pixels = 1 hour => 50 pixels 30mins

            // since is not exactly, here the error is tested.
            expect(
              finalEndTime?.difference(DateTime(1970, 1, 1, 10, 30)),
              lessThan(const Duration(minutes: 1)),
            );
          });
        });

        group('horizontal', () {
          testWidgets(
              'when dragging on the left '
              'change left location '
              'call startTimeUpdated, '
              'and call startTimeChanged at the end', (tester) async {
            DateTime? startTime;
            DateTime? finalStartTime;

            await tester.pumpApp(
              buildSubject(
                axis: Axis.horizontal,
                onStartDateTimeChanged: (dateTime) => finalStartTime = dateTime,
                onStartDateTimeUpdated: (dateTime) => startTime = dateTime,
              ),
            );

            final gesture = await tester.createGesture(
              kind: PointerDeviceKind.mouse,
            );

            addTearDown(() async => gesture.removePointer());

            final centerLocation = tester.getCenter(find.byType(TimelineItem));

            final leftLocation = centerLocation.translate(-50, 0);

            final expectedLeftLocation = leftLocation.translate(-50, 0);

            await gesture.down(leftLocation);

            // move to arbitrary location
            await gesture.moveTo(expectedLeftLocation.translate(25, 0));

            // 100 pixels = 1 hour => 25 pixels 15mins
            expect(startTime, DateTime(1970, 1, 1, 8, 45));
            expect(finalStartTime, null);

            await gesture.moveTo(expectedLeftLocation);

            await gesture.up();

            await tester.pump();

            final newLeftLocation =
                tester.getTopLeft(find.byType(TimelineItem));

            expect(newLeftLocation.dx, expectedLeftLocation.dx);

            // 100 pixels = 1 hour => 50 pixels 30mins
            expect(finalStartTime, DateTime(1970, 1, 1, 8, 30));
          });

          testWidgets(
              'when dragging on the bottom '
              'change bottom location '
              'call endTimeUpdated, '
              'and call endTimeChanged at the end', (tester) async {
            DateTime? endTime;
            DateTime? finalEndTime;

            await tester.pumpApp(
              buildSubject(
                axis: Axis.horizontal,
                onEndDateTimeChanged: (dateTime) => finalEndTime = dateTime,
                onEndDateTimeUpdated: (dateTime) => endTime = dateTime,
              ),
            );

            final gesture = await tester.createGesture(
              kind: PointerDeviceKind.mouse,
            );

            addTearDown(() async => gesture.removePointer());

            final centerLocation = tester.getCenter(find.byType(TimelineItem));

            final rightLocation = centerLocation.translate(49, 0);
            final expectedRightLocation = rightLocation.translate(49, 0);

            await gesture.down(rightLocation);
            // move to arbitrary location
            await gesture.moveTo(expectedRightLocation.translate(-25, 0));

            // 100 pixels = 1 hour => 25 pixels 15mins
            expect(
              endTime?.difference(DateTime(1970, 1, 1, 10, 15)),
              lessThan(const Duration(minutes: 1)),
            );
            expect(finalEndTime, null);

            // move to expected location
            await gesture.moveTo(expectedRightLocation);

            await gesture.up();

            await tester.pump();

            final newBottomLocation = tester
                .getBottomRight(
                  find.byType(TimelineItem),
                )
                .translate(-1, 0);

            expect(newBottomLocation.dx, expectedRightLocation.dx);

            // 100 pixels = 1 hour => 50 pixels 30mins

            // since is not exactly, here the error is tested.
            expect(
              finalEndTime?.difference(DateTime(1970, 1, 1, 10, 30)),
              lessThan(const Duration(minutes: 1)),
            );
          });
        });
      });

      testWidgets(
        'throws assertion error '
        'when is not a direct child of DynamicTimeline',
        (tester) async {
          await tester.pumpApp(
            TimelineItem(
              startDateTime: DateTime(1970, 1, 1, 9),
              endDateTime: DateTime(1970, 1, 1, 10),
              child: Container(color: Colors.red),
            ),
          );

          expect(
            TestWidgetsFlutterBinding.instance.takeException(),
            isA<AssertionError>(),
          );
        },
      );
    });
  });
}
