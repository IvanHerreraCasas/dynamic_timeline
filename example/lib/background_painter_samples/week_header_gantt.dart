import 'package:dynamic_timeline/dynamic_timeline.dart';
import 'package:dynamic_timeline_example/widgets/week_header.dart';
import 'package:dynamic_timeline_example/widgets/widgets.dart';
import 'package:flutter/material.dart';

class WeekHeaderGantt extends StatefulWidget {
  const WeekHeaderGantt({Key? key}) : super(key: key);

  @override
  State<WeekHeaderGantt> createState() => _WeekHeaderGanttState();
}

class _WeekHeaderGanttState extends State<WeekHeaderGantt> {
  late final ScrollController scrollController;
  final items = [
    TimelineItem(
      startDateTime: DateTime(2022, 1, 4),
      endDateTime: DateTime(2022, 1, 15),
      child: const Event(title: 'Event 1'),
      position: 0,
    ),
    TimelineItem(
      startDateTime: DateTime(2022, 3, 4),
      endDateTime: DateTime(2022, 3, 15),
      child: const Event(title: 'Event 1'),
      position: 0,
    ),
    TimelineItem(
      startDateTime: DateTime(2022, 1, 20),
      endDateTime: DateTime(2022, 2, 1),
      position: 1,
      child: const Event(title: 'Event 2'),
    ),
    TimelineItem(
      startDateTime: DateTime(2022, 4, 20),
      endDateTime: DateTime(2022, 5, 1),
      position: 1,
      child: const Event(title: 'Event 2'),
    ),
    TimelineItem(
      startDateTime: DateTime(2022, 2, 1),
      endDateTime: DateTime(2022, 3, 15),
      position: 2,
      child: const Event(title: 'Event 3'),
    ),
    TimelineItem(
      startDateTime: DateTime(2022, 5, 1),
      endDateTime: DateTime(2022, 6, 15),
      position: 2,
      child: const Event(title: 'Event 3'),
    ),

  ];

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Week header Gantt Chart')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Scrollbar(
            controller: scrollController,
            thumbVisibility: true,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: scrollController,
              child: DynamicTimeline(
                firstDateTime: DateTime(2022, 1, 3),
                lastDateTime: DateTime(2022, 7, 31),
                labelBuilder: LabelBuilder(
                  intervalExtend: 7,
                  builder: (date) => WeekHeader(date: date),
                ),
                axis: Axis.horizontal,
                intervalDuration: const Duration(days: 1),
                minItemDuration: const Duration(days: 1),
                crossAxisCount: 3,
                intervalExtent: 20,
                maxCrossAxisIndicatorExtent: 50,
                maxCrossAxisItemExtent: 30,
                crossAxisSpacing: 1,
                intervalPainters: [
                  ColoredIntervalPainter.createHorizontal(
                      intervalSelector: (interval) => interval % 7 > 4,
                      paint: Paint()..color = const Color.fromARGB(255, 0xF5, 0xF5, 0xF5)),
                  ColoredIntervalPainter.createHorizontal(
                      intervalSelector: (interval) => interval % 7 < 5,
                      paint: Paint()..color = Colors.white),
                  IntervalDecorationPainter.createHorizontal(
                      intervalSelector: (interval) => interval % 7 == 6 || interval % 7 == 4,
                      paint: Paint()..color = const Color.fromARGB(255, 0xcf, 0xcf, 0xcf)),
                  IntervalDecorationPainter.createVertical(
                      paint: Paint()..color = const Color.fromARGB(255, 0xcf, 0xcf, 0xcf))
                ],
                //intervalPainters: [VerticalIntervalPainter()],
                items: items,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
