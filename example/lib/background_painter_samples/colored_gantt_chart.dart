import 'package:dynamic_timeline/dynamic_timeline.dart';
import 'package:dynamic_timeline_example/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ColoredGanttChart extends StatefulWidget {
  const ColoredGanttChart({Key? key}) : super(key: key);

  @override
  State<ColoredGanttChart> createState() => _ColoredGanttChartState();
}

class _ColoredGanttChartState extends State<ColoredGanttChart> {
  late final ScrollController scrollController;
  final items = [
    TimelineItem(
      startDateTime: DateTime(2022, 1, 1),
      endDateTime: DateTime(2022, 1, 15),
      child: const Event(title: 'Event 1'),
      position: 0,
    ),
    TimelineItem(
      startDateTime: DateTime(2022, 1, 4),
      endDateTime: DateTime(2022, 1, 15),
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
      startDateTime: DateTime(2022, 2, 1),
      endDateTime: DateTime(2022, 3, 15),
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
      appBar: AppBar(title: const Text('Colored Gantt Chart')),
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
                firstDateTime: DateTime(2022, 1, 1),
                lastDateTime: DateTime(2022, 12, 31),
                labelBuilder: (date) => Column(children: [
                  Expanded(child: Container()),
                  Transform(
                    child: Text(
                      DateFormat('dd').format(date),
                    ),
                    alignment: FractionalOffset.center,
                    transform: new Matrix4.identity()..rotateZ(-70 * 3.1415927 / 180),
                  ),
                  SizedBox(width: double.infinity,height: 3)
                ]),
                axis: Axis.horizontal,
                intervalDuration: const Duration(days: 1),
                minItemDuration: const Duration(days: 1),
                crossAxisCount: 3,
                intervalExtent: 20,
                maxCrossAxisItemExtent: 30,
                crossAxisSpacing: 1,
                intervalPainters: [
                  ColoredIntervalPainter.createVertical(intervalColorCallback: (interval) => interval%2 == 1 ?Colors.blue.withOpacity(0.2):null),

                  ColoredIntervalPainter.createHorizontal()],
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
