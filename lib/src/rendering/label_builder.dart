import 'package:flutter/material.dart';
import '../../dynamic_timeline.dart';
import '../widgets/timeline_label_container.dart';

class LabelBuilder {
  static LabelBuilder fromString(String Function(DateTime date) converter) => LabelBuilder(
      intervalExtend: 1,
      builder: (labelDate) {
        return Text(converter(labelDate));
      });

  LabelBuilder({
    this.intervalExtend = 1,
    required this.builder,
  });

  /// The number of intervals a label will cover (e.g. 7 to spread over a week with day intervals). (default 1)
  final int intervalExtend;

  final Widget Function(DateTime labelDate) builder;

  List<TimelineItem> Create(
      DateTime firstDateTime, DateTime lastDateTime, Duration intervalDuration) {
    List<TimelineItem> toAdd = _buildAllLabels(
      firstDateTime,
      lastDateTime,
      intervalDuration,
    );
    return toAdd;
  }

  List<TimelineItem> _buildAllLabels(
    DateTime firstDateTime,
    DateTime lastDateTime,
    Duration interval,
  ) {
    var numberOfIntervals =
        ((lastDateTime.difference(firstDateTime).inMinutes / interval.inMinutes).floor() /
                intervalExtend)
            .ceil();
    var toAdd = List<TimelineItem>.generate(
      numberOfIntervals,
      (index) => TimelineLabelContainer(
        startDateTime: firstDateTime.add(interval * intervalExtend * index),
        interval: interval * intervalExtend,
        child: builder(
          firstDateTime.add(interval * index * intervalExtend),
        ),
      ),
    );
    return toAdd;
  }
}
