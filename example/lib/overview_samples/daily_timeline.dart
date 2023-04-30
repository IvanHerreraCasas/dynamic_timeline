import 'package:dynamic_timeline/dynamic_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/widgets.dart';

class DailyTimeline extends StatelessWidget {
  const DailyTimeline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = [
      TimelineItem(
        startDateTime: DateTime(1970, 1, 1, 7),
        endDateTime: DateTime(1970, 1, 1, 11),
        child: const Event(title: 'Event 1'),

      ),
      TimelineItem(
        startDateTime: DateTime(1970, 1, 1, 10),
        endDateTime: DateTime(1970, 1, 1, 12),
        child: const Event(title: 'Event 2'),
      ),
      TimelineItem(
        startDateTime: DateTime(1970, 1, 1, 15),
        endDateTime: DateTime(1970, 1, 1, 17),
        child: const Event(title: 'Event 3'),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily timeline'),
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(),
            child: SingleChildScrollView(
          padding: const EdgeInsets.all(40),
          child: DynamicTimeline(
            firstDateTime: DateTime(1970, 1, 1, 7),
            lastDateTime: DateTime(1970, 1, 1, 22),
            labelBuilder: LabelBuilder.fromString( (date) => DateFormat('HH:mm').format(date),),
            intervalDuration: const Duration(hours: 1),
            maxCrossAxisItemExtent: 200,
            intervalExtent: 80,
            minItemDuration: const Duration(minutes: 30),
            items: items,
          ),
        )),
      ),
    );
  }
}
