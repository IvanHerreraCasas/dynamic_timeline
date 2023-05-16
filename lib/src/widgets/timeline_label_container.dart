// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'package:dynamic_timeline/dynamic_timeline.dart';
import 'package:dynamic_timeline/src/rendering/render_timeline_item.dart';
import 'package:dynamic_timeline/src/widgets/timeline_item.dart';
import 'package:flutter/material.dart';

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
            child: child,);

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
