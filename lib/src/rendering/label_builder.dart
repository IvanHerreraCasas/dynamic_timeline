// ignore_for_file: lines_longer_than_80_chars
import 'package:dynamic_timeline/dynamic_timeline.dart';
import 'package:dynamic_timeline/src/widgets/timeline_label_container.dart';
import 'package:flutter/material.dart';

/// {@template label_builder}
/// The label builder provides the main infrastructure for building the main axis
/// labels. It implements a mechanism to successively call a callback function
/// [builder] for the given intervals determined by the interval size [intervalExtend].
/// It has a default string based implementation [LabelBuilder.fromString] in which
/// a simple string will be converted into text label for the given interval size.
/// {@endtemplate}
class LabelBuilder {
  /// {@macro label_builder}
  LabelBuilder({
    required this.builder,
    this.intervalExtend = 1,
  });

  /// Factory function to create a string based label builder. Parameters are an
  /// interval size [intervalExtend] which determines how many intervals of the timeline
  /// are covered by a single label and a converter function [converter] which converts
  /// the given interval [DateTime] to the output string.
  factory LabelBuilder.fromString(String Function(DateTime date) converter) =>
      LabelBuilder(
        builder: (labelDate) {
          return Text(converter(labelDate));
        },
      );

  /// The number of intervals a label will cover (e.g. 7 to spread over a week with day intervals). (default 1)
  final int intervalExtend;

  /// The builder function which will be called for each label.
  final Widget Function(DateTime labelDate) builder;

  /// Automatically builds a list of labels starting from [firstDateTime] going
  /// to [lastDateTime] with the given [intervalDuration].
  List<TimelineItem> create(
    DateTime firstDateTime,
    DateTime lastDateTime,
    Duration intervalDuration,
  ) {
    final toAdd = _buildAllLabels(
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
    final numberOfIntervals =
        ((lastDateTime.difference(firstDateTime).inMinutes / interval.inMinutes)
                    .floor() /
                intervalExtend)
            .ceil();
    final toAdd = List<TimelineItem>.generate(
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
