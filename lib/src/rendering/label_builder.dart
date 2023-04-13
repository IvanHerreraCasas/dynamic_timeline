import 'package:flutter/material.dart';

import '../../dynamic_timeline.dart';
import '../widgets/timeline_label_container.dart';

class LabelBuilder {

  static LabelBuilder fromString(String Function(DateTime date) converter) =>
      LabelBuilder(labelIntervalSpread: 1, builder: (labelDate) {
        return Text(converter(labelDate));
      });

  LabelBuilder({
    this.labelIntervalSpread = 1,
    required this.builder,
  });

  /// The number of intervals a label will cover (e.g. 7 to spread over a week with day intervalls). (default 1)
  final int labelIntervalSpread;

  final Widget Function(DateTime labelDate) builder;

  List<TimelineItem> Create(DateTime firstDateTime, DateTime lastDateTime,
      Duration intervalDuration) {
    List<TimelineItem> toAdd = _buildAllLabels(
      firstDateTime,
      lastDateTime,
      intervalDuration,
      labelIntervalSpread,
      builder,
    );
    return toAdd;
  }

  List<TimelineItem> _buildAllLabels(DateTime firstDateTime,
      DateTime lastDateTime,
      Duration interval,
      int labelIntervalSpread,
      Widget Function(DateTime labelDate) labelBuilder,) {
    var numberOfIntervals =
    ((lastDateTime
        .difference(firstDateTime)
        .inMinutes / interval.inMinutes).floor() / labelIntervalSpread).ceil();
    var toAdd = List<TimelineItem>.generate(
        numberOfIntervals,
            (index) =>
            TimelineLabelContainer(
                startDateTime: firstDateTime.add(interval * labelIntervalSpread * index),
                interval: interval * labelIntervalSpread,
                child: labelBuilder(firstDateTime.add(interval * index * labelIntervalSpread))));
    return toAdd;
  }
}

