import 'package:dynamic_timeline/dynamic_timeline.dart';
import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import 'package:intl/intl.dart';

class ColoredWeeklyTimetable extends StatefulWidget {
  const ColoredWeeklyTimetable({Key? key}) : super(key: key);

  @override
  _ColoredWeeklyTimetableState createState() => _ColoredWeeklyTimetableState();
}

class _ColoredWeeklyTimetableState extends State<ColoredWeeklyTimetable> {
  late final ScrollController verticalController;
  late final ScrollController horizontalController;

  @override
  void initState() {
    super.initState();
    verticalController = ScrollController();
    horizontalController = ScrollController();
  }

  @override
  void dispose() {
    verticalController.dispose();
    horizontalController.dispose();
    super.dispose();
  }

  final items = <TimelineItem>[
    TimelineItem(
      startDateTime: DateTime(1970, 1, 1, 7),
      endDateTime: DateTime(1970, 1, 1, 8, 0),
      position: 0,
      child: const Event(title: 'Event Monday'),
    ),
    TimelineItem(
      startDateTime: DateTime(1970, 1, 1, 10),
      endDateTime: DateTime(1970, 1, 1, 12),
      position: 2,
      child: const Event(title: 'Event Wednesday'),
    ),
    TimelineItem(
      startDateTime: DateTime(1970, 1, 1, 15),
      endDateTime: DateTime(1970, 1, 1, 17),
      position: 6,
      child: const Event(title: 'Event Friday'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weekly timetable'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Scrollbar(
            controller: verticalController,
            child: SingleChildScrollView(
              controller: verticalController,
              child: Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 60),
                      ...List.generate(
                        7,
                        (index) => Expanded(child: DayHeader(day: index)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  DynamicTimeline(
                    firstDateTime: DateTime(1970, 01, 01, 7),
                    lastDateTime: DateTime(1970, 01, 01, 22),
                    labelBuilder: LabelBuilder.fromString( (date) =>
                      DateFormat('HH:mm').format(date)
                    ),
                    intervalDuration: const Duration(hours: 1),
                    crossAxisCount: 7,
                    intervalExtent: 50,
                    intervalPainters: [
                      ColoredIntervalPainter.createVertical(),
                      IntervalDecorationPainter.createHorizontal(
                        intervalSelector: (intervalIdx) => intervalIdx % 2 == 0 ,
                      )
                    ],
                    //intervalPainters: [HorizontalIntervalPainter()],
                    items: items,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
