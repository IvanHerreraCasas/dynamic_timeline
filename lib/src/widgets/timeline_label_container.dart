import 'package:flutter/src/widgets/framework.dart';
import '../../dynamic_timeline.dart';
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

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderTimelineItem(
      startDateTime: startDateTime,
      endDateTime: endDateTime,
      position: position,
      isTimelineLabelItem: true,
      onStartDateTimeUpdated: onStartDateTimeUpdated,
      onEndDateTimeUpdated: onEndDateTimeUpdated,
      onStartDateTimeChanged: onStartDateTimeChanged,
      onEndDateTimeChanged: onEndDateTimeChanged,
    );
  }
}
