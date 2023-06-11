// ignore_for_file: flutter_style_todos, lines_longer_than_80_chars

import 'package:dynamic_timeline/dynamic_timeline.dart';
import 'package:dynamic_timeline/src/rendering/painter/interval_painter/background_painter_data.dart';
import 'package:dynamic_timeline/src/rendering/painter/interval_painter/interval_painter.dart';
import 'package:dynamic_timeline/src/rendering/render_dynamic_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shouldly/shouldly.dart';
import '../helpers/dummy_stateful_wrapper.dart';
import '../helpers/helpers.dart';

void main() {
  group('DynamicTimeline', () {
    final mockItems = [
      TimelineItem(
        key: const Key('1'),
        startDateTime: DateTime(1970, 1, 1, 8),
        endDateTime: DateTime(1970, 1, 1, 9),
        child: const SizedBox(),
      ),
      TimelineItem(
        key: const Key('2'),
        startDateTime: DateTime(1970, 1, 1, 10),
        endDateTime: DateTime(1970, 1, 1, 11, 30),
        position: 1,
        child: const SizedBox(),
      ),
    ];

    Widget buildSubject({
      DateTime? firstDateTime,
      DateTime? lastDateTime,
      String? Function(DateTime)? labelBuilder,
      Axis axis = Axis.vertical,
      Duration? intervalDuration = const Duration(hours: 1),
      double intervalExtent = 100,
      int crossAxisCount = 2,
      double maxCrossAxisIndicatorExtent = 60,
      double maxCrossAxisItemExtent = 100,
      Duration? minItemDuration,
      double crossAxisSpacing = 20,
      Color color = Colors.black,
      double strokeWidth = 2,
      StrokeCap strokeCap = StrokeCap.round,
      bool resizable = true,
      Paint? paint,
      List<IntervalPainter> intervalPainters = const [],
      TextStyle? textStyle,
      List<TimelineItem>? items,
    }) {
      return DynamicTimeline(
        firstDateTime: firstDateTime ?? DateTime(1970, 1, 1, 8),
        lastDateTime: lastDateTime ?? DateTime(1970, 1, 1, 12),
        labelBuilder: LabelBuilder(
          builder: (labelDate) {
            return const Text('date');
          },
        ),
        axis: axis,
        intervalDuration: intervalDuration,
        intervalExtent: intervalExtent,
        crossAxisCount: crossAxisCount,
        maxCrossAxisIndicatorExtent: maxCrossAxisIndicatorExtent,
        maxCrossAxisItemExtent: maxCrossAxisItemExtent,
        minItemDuration: minItemDuration,
        crossAxisSpacing: crossAxisSpacing,
        color: color,
        strokeWidth: strokeWidth,
        strokeCap: strokeCap,
        resizable: resizable,
        intervalPainters: intervalPainters,
        paint: paint,
        textStyle: textStyle,
        items: items ?? mockItems,
      );
    }

    group('createRenderObject', () {
      testWidgets('creates RenderDynamicTimeline properly', (tester) async {
        String? labelBuilder(DateTime dateTime) => 'date';
        final paint = Paint()..color = Colors.blue;
        const textStyle = TextStyle();
        const minItemDuration = Duration(minutes: 10);
        await tester.pumpApp(
          buildSubject(
            labelBuilder: labelBuilder,
            minItemDuration: minItemDuration,
            textStyle: textStyle,
            paint: paint,
          ),
        );

        final renderDynamicTimeline =
            tester.renderObject<RenderDynamicTimeline>(
          find.byType(DynamicTimeline),
        );

        expect(renderDynamicTimeline.firstDateTime, DateTime(1970, 1, 1, 8));
        expect(renderDynamicTimeline.lastDateTime, DateTime(1970, 1, 1, 12));
        expect(renderDynamicTimeline.axis, Axis.vertical);
        expect(
          renderDynamicTimeline.intervalDuration,
          const Duration(hours: 1),
        );
        expect(renderDynamicTimeline.intervalExtent, 100.0);
        expect(renderDynamicTimeline.crossAxisCount, 2);
        expect(renderDynamicTimeline.maxCrossAxisIndicatorExtent, 60.0);
        expect(renderDynamicTimeline.maxCrossAxisItemExtent, 100.0);
        expect(renderDynamicTimeline.crossAxisSpacing, 20.0);
        expect(renderDynamicTimeline.resizable, true);

        expect(renderDynamicTimeline.minItemDuration, minItemDuration);
        expect(renderDynamicTimeline.linePaint, paint);
        expect(renderDynamicTimeline.labelTextStyle, textStyle);
      });

      group('defaults', () {
        testWidgets('intervalDuration takes 1/20 of the total', (tester) async {
          await tester.pumpApp(buildSubject(intervalDuration: null));

          final renderDynamicTimeline =
              tester.renderObject<RenderDynamicTimeline>(
            find.byType(DynamicTimeline),
          );

          expect(
            renderDynamicTimeline.minItemDuration,
            const Duration(hours: 4) ~/ 20,
          );
        });

        testWidgets('minItemDuration takes 1/20 of the total', (tester) async {
          await tester.pumpApp(buildSubject());

          final renderDynamicTimeline =
              tester.renderObject<RenderDynamicTimeline>(
            find.byType(DynamicTimeline),
          );

          expect(
            renderDynamicTimeline.minItemDuration,
            const Duration(hours: 4) ~/ 20,
          );
        });

        testWidgets('linePaint uses the given color, stroke width and cap',
            (tester) async {
          await tester.pumpApp(buildSubject());
          final renderDynamicTimeline =
              tester.renderObject<RenderDynamicTimeline>(
            find.byType(DynamicTimeline),
          );

          expect(renderDynamicTimeline.linePaint.color, Colors.black);
          expect(renderDynamicTimeline.linePaint.strokeWidth, 2.0);
          expect(renderDynamicTimeline.linePaint.strokeCap, StrokeCap.round);
        });

        testWidgets('labelTextStyle uses textTheme bodyText1', (tester) async {
          await tester.pumpApp(
            buildSubject(),
          );
          final renderDynamicTimeline =
              tester.renderObject<RenderDynamicTimeline>(
            find.byType(DynamicTimeline),
          );

          final element = tester.element(find.byType(DynamicTimeline));

          expect(
            renderDynamicTimeline.labelTextStyle,
            Theme.of(element).textTheme.bodyLarge,
          );
        });
      });
    });

    testWidgets('updates its properties correctly', (tester) async {
      await tester.pumpApp(buildSubject());

      String? labelBuilder(DateTime dateTime) => 'label';
      final firstDateTime = DateTime(1970, 1, 1, 7);
      final lastDateTime = DateTime(1970, 1, 1, 13);
      const axis = Axis.horizontal;
      const intervalDuration = Duration(minutes: 30);
      const intervalExtent = 50.0;
      const crossAxisCount = 1;
      const maxCrossAxisIndicatorExtent = 80.0;
      const maxCrossAxisItemExtent = 50.0;
      const minItemDuration = Duration(minutes: 10);
      const crossAxisSpacing = 10.0;
      const color = Colors.red;
      const strokeWidth = 1.0;
      const strokeCap = StrokeCap.square;
      const resizable = false;
      final paint = Paint()..color = Colors.blue;
      const textStyle = TextStyle(color: Colors.blue);
      final items = mockItems.sublist(0, 1);

      await tester.pumpApp(
        buildSubject(
          firstDateTime: firstDateTime,
          lastDateTime: lastDateTime,
          labelBuilder: labelBuilder,
          axis: axis,
          intervalDuration: intervalDuration,
          intervalExtent: intervalExtent,
          crossAxisCount: crossAxisCount,
          maxCrossAxisIndicatorExtent: maxCrossAxisIndicatorExtent,
          maxCrossAxisItemExtent: maxCrossAxisItemExtent,
          minItemDuration: minItemDuration,
          crossAxisSpacing: crossAxisSpacing,
          color: color,
          strokeWidth: strokeWidth,
          strokeCap: strokeCap,
          resizable: resizable,
          paint: paint,
          textStyle: textStyle,
          items: items,
        ),
      );

      final widget = tester.widget<DynamicTimeline>(
        find.byType(DynamicTimeline),
      );

      // TODO: form most complex types e.g. the tests are cheching it the
      // TODO: objects are the same, which is not the same as checking if the
      // TODO: they are equal!!
      expect(widget.firstDateTime, firstDateTime);
      expect(widget.lastDateTime, lastDateTime);
      expect(widget.axis, axis);
      expect(widget.intervalDuration, intervalDuration);
      expect(widget.crossAxisCount, crossAxisCount);
      expect(widget.maxCrossAxisIndicatorExtent, maxCrossAxisIndicatorExtent);
      expect(widget.maxCrossAxisItemExtent, maxCrossAxisItemExtent);
      expect(widget.minItemDuration, minItemDuration);
      expect(widget.crossAxisSpacing, crossAxisSpacing);
      expect(widget.color, color);
      expect(widget.strokeWidth, strokeWidth);
      expect(widget.resizable, resizable);
      expect(widget.paint, paint);
      expect(widget.textStyle, textStyle);
      for (final item in items) {
        expect(widget.children.contains(item), true);
      }
    });

    group('renderObject', () {
      group('items', () {
        group('vertical', () {
          testWidgets(
              'renders items, '
              'positions, and size them correctly', (tester) async {
            await tester.pumpApp(buildSubject());

            // first item: 0/ 8:00 - 9:00
            final firstItemRect = tester.getRect(
              find.byKey(const Key('1')),
            );
            expect(firstItemRect, const Offset(80, 0) & const Size(100, 100));

            // second item: 1/ 10:00 - 11:30
            final secondRect = tester.getRect(
              find.byKey(const Key('2')),
            );
            expect(
              secondRect,
              const Offset(200, 200) & const Size(100, 150),
            );

            expect(find.byType(TimelineItem), findsNWidgets(2));
          });
        });

        group('horizontal', () {
          testWidgets(
              'renders items and '
              'and positions them correctly', (tester) async {
            await tester.pumpApp(buildSubject(axis: Axis.horizontal));

            // first item: 0/ 8:00 - 9:00
            final firstItemRect = tester.getRect(
              find.byKey(const Key('1')),
            );
            expect(firstItemRect, const Offset(0, 80) & const Size(100, 100));

            // second item: 1/ 10:00 - 11:30
            final secondItemRect = tester.getRect(
              find.byKey(const Key('2')),
            );
            expect(
              secondItemRect,
              const Offset(200, 200) & const Size(150, 100),
            );

            expect(find.byType(TimelineItem), findsNWidgets(2));
          });
        });
      });

      testWidgets('computes correct size', (tester) async {
        await tester.pumpApp(buildSubject());

        final size = tester.getSize(find.byType(DynamicTimeline));

        expect(size, const Size(300, 400));
      });

      testWidgets('dryLayout works correctly', (tester) async {
        await tester.pumpApp(buildSubject());

        final renderObject = tester.renderObject<RenderDynamicTimeline>(
          find.byType(DynamicTimeline),
        );

        expect(
          renderObject.getDryLayout(
            const BoxConstraints(maxWidth: 500, maxHeight: 500),
          ),
          const Size(300, 400),
        );

        expect(
          renderObject.getDryLayout(
            const BoxConstraints(maxWidth: 200, maxHeight: 500),
          ),
          const Size(200, 400),
        );

        expect(
          renderObject.getDryLayout(
            const BoxConstraints(maxWidth: 500, maxHeight: 200),
          ),
          const Size(300, 200),
        );
      });

      testWidgets('has correct intrinsic width', (tester) async {
        await tester.pumpApp(buildSubject());

        final renderObject = tester.renderObject<RenderDynamicTimeline>(
          find.byType(DynamicTimeline),
        );

        expect(renderObject.getMaxIntrinsicWidth(100), 300);
        expect(renderObject.getMinIntrinsicWidth(100), 300);
      });

      testWidgets('has correct intrinsics height', (tester) async {
        await tester.pumpApp(buildSubject());

        final renderObject = tester.renderObject<RenderDynamicTimeline>(
          find.byType(DynamicTimeline),
        );

        expect(renderObject.getMaxIntrinsicHeight(100), 400);
        expect(renderObject.getMinIntrinsicHeight(100), 400);
      });

      //Bugfix: Missing layout information for background painter after "setState" call
      testWidgets(
          'Measuring the amount auf paint calls before and after set state '
          '--> Should be same amount of calls', (tester) async {
        final mockPainter = _MockIntervalPainter();
        await tester.pumpApp(
          DummyStatefulWrapper(
            builder: () => buildSubject(intervalPainters: [mockPainter]),
          ),
        );

        final callsBeforeSetState = mockPainter.timesPaintCalled;
        mockPainter.timesPaintCalled = 0;

        // ignore: invalid_use_of_protected_member
        tester.state(find.byType(DummyStatefulWrapper)).setState(() {});

        await tester.pump();
        final callsAfterSetState = mockPainter.timesPaintCalled;
        callsBeforeSetState.should.beGreaterThan(0);
        callsAfterSetState.should.be(callsBeforeSetState);
      });

      testWidgets(
          'Measuring the amount auf layout after set state with a new painter list '
          '--> Should be called at least once', (tester) async {
        final mockPainter = _MockIntervalPainter();
        await tester.pumpApp(
          DummyStatefulWrapper(
            builder: () => buildSubject(intervalPainters: [mockPainter]),
          ),
        );

        mockPainter.timesSetLayoutCalled = 0;

        // ignore: invalid_use_of_protected_member
        tester.state(find.byType(DummyStatefulWrapper)).setState(() {});

        await tester.pump();
        mockPainter.timesSetLayoutCalled.should.beGreaterOrEqualThan(1);
      });

      testWidgets(
          'Measuring the amount auf layout after set state with a old painter list '
          '--> Should not be called', (tester) async {
        final mockPainter = _MockIntervalPainter();
        final painters = [mockPainter];
        await tester.pumpApp(
          DummyStatefulWrapper(
            builder: () => buildSubject(intervalPainters: painters),
          ),
        );

        mockPainter.timesSetLayoutCalled = 0;

        // ignore: invalid_use_of_protected_member
        tester.state(find.byType(DummyStatefulWrapper)).setState(() {});

        await tester.pump();
        mockPainter.timesSetLayoutCalled.should.be(0);
      });
    });
  });
}

class _MockIntervalPainter extends IntervalPainter {
  _MockIntervalPainter()
      : super(
          drawingAxis: Axis.vertical,
          intervalSelector: (interval) => true,
        );

  int timesPaintCalled = 0;
  int timesSetLayoutCalled = 0;

  @override
  void setLayout({required BackgroundPainterData data}) {
    super.setLayout(data: data);
    timesSetLayoutCalled++;
  }

  @override
  void paintCallback(Canvas canvas, Rect drawingRegion, int intervalIdx) {
    timesPaintCalled++;
  }
}
