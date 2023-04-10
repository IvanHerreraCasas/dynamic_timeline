import 'package:dynamic_timeline/dynamic_timeline.dart';
import 'package:flutter/material.dart';

import '../rendering/painter/interval_painter/interval_painter.dart';
import 'timeline_label_container.dart';

/// {@template dynamic_timeline}
/// A widget that displays a timeline and positions its children using their
/// start and end date times.
///
/// Each child must be a [TimelineItem] that represents an event.
///
/// Each item must have a key in case of displaying dynamic data.
///
/// This widget has a fixed size, calculated using the extent properties.
/// {@endtemplate}
class DynamicTimeline extends MultiChildRenderObjectWidget {
  /// {@macro dynamic_timeline}
  DynamicTimeline({
    Key? key,
    required this.firstDateTime,
    required this.lastDateTime,
    required Widget Function(DateTime labelDate) labelBuilder,
    this.axis = Axis.vertical,
    this.intervalDuration,
    this.intervalExtent = 100,
    this.crossAxisCount = 1,
    this.maxCrossAxisIndicatorExtent = 80,
    this.maxCrossAxisItemExtent,
    this.minItemDuration,
    this.crossAxisSpacing = 20,
    this.color = Colors.black,
    this.strokeWidth = 2,
    this.strokeCap = StrokeCap.round,
    this.resizable = true,
    this.paint,
    this.textStyle,
    this.intervalPainters = const [],
    required List<TimelineItem> items,
  })
      : assert(
  maxCrossAxisItemExtent != double.infinity,
  "max cross axis item extent can't be infinite. ",
  ),
        assert(
        firstDateTime.isBefore(lastDateTime),
        'firstDateTime must be before lastDateTime:   '
            'firstDateTime: $firstDateTime --- lastDateTime: $lastDateTime',
        ),
        super(key: key, children: _buildAllChildren(items, firstDateTime,
          lastDateTime, intervalDuration, labelBuilder));

  static List<TimelineItem> _buildAllChildren(List<TimelineItem> items,
      DateTime firstDateTime, DateTime lastDateTime, Duration? intervalDuration,
      Widget Function(DateTime labelDate) labelBuilder) {
    var interval = intervalDuration ??
        _getDefaultIntervalDuration(firstDateTime, lastDateTime);
    List<TimelineItem> toAdd = _buildAllLabels(firstDateTime, lastDateTime, interval, labelBuilder);
    items.addAll(toAdd);
    return items;
  }

  static List<TimelineItem> _buildAllLabels(DateTime firstDateTime,DateTime lastDateTime,
      Duration interval, Widget Function(DateTime labelDate) labelBuilder,) {
    var numberOfIntervals = (lastDateTime.difference(firstDateTime).inMinutes / interval.inMinutes).floor();
     var toAdd = List<TimelineItem>.generate(numberOfIntervals, (index)
    => TimelineLabelContainer(
        startDateTime: firstDateTime.add(interval * index),interval: interval,
        child: labelBuilder(firstDateTime.add(interval * index)))
    );
    return toAdd;
  }

  /// The axis of the line.
  final Axis axis;

  /// The first date time in the timeline.
  final DateTime firstDateTime;

  /// The last datetime in the timeline.
  final DateTime lastDateTime;

  /// The lenght of time between each mark.
  final Duration? intervalDuration;

  /// The number of logical pixels between each mark.
  final double intervalExtent;

  /// Interval painter are used to color the background of the timeline.
  /// intervals can be along the items direction (cross axis)
  /// or the time direction (main axis).
  final List<IntervalPainter> intervalPainters;

  /// If true the items can be resized, dragging in the main axis extremes.
  final bool resizable;

  /// The number of items in the cross axis.
  ///
  /// If a child has a position greater than or equal [crossAxisCount]
  /// it will not be shown.
  final int crossAxisCount;

  /// The extent of the label and line.
  final double maxCrossAxisIndicatorExtent;

  /// It is used to calculate the cross axis extent of the timeline.
  final double? maxCrossAxisItemExtent;

  /// The minimun duration that the item can be resized.
  final Duration? minItemDuration;

  /// The number of logical pixels between each item along the cross axis.
  final double crossAxisSpacing;

  /// The paint used to draw the line.
  final Paint? paint;

  /// The color of the line and labels.
  ///
  /// Used if [paint] or [textStyle] are null.
  final Color color;

  /// The stroke width of the line.
  ///
  /// Used if [paint] is null.
  final double strokeWidth;

  /// The stroke cap of the line
  ///
  /// Used if [paint] is null.
  final StrokeCap strokeCap;

  /// The text style of the labels.
  final TextStyle? textStyle;

  @override
  RenderObject createRenderObject(BuildContext context) {
    Duration defaultIntervalDuration = _getDefaultIntervalDuration(firstDateTime, lastDateTime);

    final defaultLinePaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = strokeCap;

    final defaultLabelTextStyle = Theme
        .of(context)
        .textTheme
        .bodyText1!;

    return RenderDynamicTimeline(
      firstDateTime: firstDateTime,
      lastDateTime: lastDateTime,
      axis: axis,
      intervalDuration: intervalDuration ?? defaultIntervalDuration,
      intervalExtent: intervalExtent,
      intervalPainters: intervalPainters,
      crossAxisCount: crossAxisCount,
      maxCrossAxisIndicatorExtent: maxCrossAxisIndicatorExtent,
      maxCrossAxisItemExtent: maxCrossAxisItemExtent??double.infinity,
      minItemDuration: minItemDuration ?? defaultIntervalDuration,
      crossAxisSpacing: crossAxisSpacing,
      resizable: resizable,
      linePaint: paint ?? defaultLinePaint,
      labelTextStyle: textStyle ?? defaultLabelTextStyle,
    );
  }

  static Duration _getDefaultIntervalDuration(DateTime firstDateTime, DateTime lastDateTime) =>
      lastDateTime.difference(firstDateTime) ~/ 20;

  @override
  void updateRenderObject(BuildContext context,
      covariant RenderDynamicTimeline renderObject,) {
    var defaultIntervalDuration = _getDefaultIntervalDuration(firstDateTime, lastDateTime);

    final defaultLinePaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = strokeCap;

    final defaultLabelTextStyle = Theme
        .of(context)
        .textTheme
        .bodyText1!;

    renderObject
      ..firstDateTime = firstDateTime
      ..lastDateTime = lastDateTime
      ..axis = axis
      ..intervalDuration = intervalDuration ?? defaultIntervalDuration
      ..intervalExtent = intervalExtent
      ..intervalPainters = intervalPainters
      ..crossAxisCount = crossAxisCount
      ..maxCrossAxisIndicatorExtent = maxCrossAxisIndicatorExtent
      ..maxCrossAxisItemExtent = maxCrossAxisItemExtent??double.infinity
      ..minItemDuration = minItemDuration ?? defaultIntervalDuration
      ..crossAxisSpacing = crossAxisSpacing
      ..resizable = resizable
      ..linePaint = paint ?? defaultLinePaint
      ..labelTextStyle = textStyle ?? defaultLabelTextStyle;
  }
}
