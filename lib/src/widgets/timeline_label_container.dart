import 'package:flutter/src/widgets/framework.dart';
import 'timeline_item.dart';

class TimelineLabelContainer extends TimelineItem {
  TimelineLabelContainer(
      {Key? key,
      required DateTime startDateTime,
      required Duration interval,
      required Widget child})
      : super(
            key: key,
            startDateTime: startDateTime,
            endDateTime: startDateTime.add(interval),
            child: child);
}
