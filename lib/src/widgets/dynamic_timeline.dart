import 'package:dynamic_timeline/dynamic_timeline.dart';
import 'package:flutter/material.dart';

/// {@template dynamic_timeline}
/// A widget that displays a timeline and positions its children using their
/// start and end date times.
///
/// Each child is or not a timeline event.
/// Timeline event widgets are those who are wrapped in a [TimelineItem].
///
/// If a child is not a timeline event widget, the first date time will be used
/// as a start time, the interval duration to set the end time and positon 0.
///
/// This widget has a fixed size, calculated using the extent properties.
/// {@endtemplate}
class DynamicTimeline extends MultiChildRenderObjectWidget {
  /// {@macro dynamic_timeline}
  DynamicTimeline({
    Key? key,
    required List<Widget> children,
    required this.firstDateTime,
    required this.lastDateTime,
    required this.labelBuilder,
    this.axis = Axis.vertical,
    this.intervalDuration,
    this.intervalExtent = 100,
    this.crossAxisCount = 1,
    this.maxCrossAxisIndicatorExtent = 60,
    this.maxCrossAxisItemExtent = 100,
    this.minItemDuration,
    this.crossAxisSpacing = 20,
    this.color = Colors.black,
    this.strokeWidth = 2,
    this.strokeCap = StrokeCap.round,
    this.resizable = true,
    this.paint,
    this.textStyle,
  })  : assert(
          maxCrossAxisItemExtent != double.infinity,
          "max cross axis item extent can't be infinite. ",
        ),
        assert(
          firstDateTime.isBefore(lastDateTime),
          'firstDateTime must be before lastDateTime:   '
          'firstDateTime: $firstDateTime --- lastDateTime: $lastDateTime',
        ),
        super(key: key, children: children);

  /// The axis of the line.
  final Axis axis;

  /// The first date time in the timeline.
  final DateTime firstDateTime;

  /// The last datetime in the timeline.
  final DateTime lastDateTime;

  /// Called to build the label of each mark.
  ///
  /// Note: DateFormat can be used.
  final String? Function(DateTime) labelBuilder;

  /// The lenght of time between each mark.
  final Duration? intervalDuration;

  /// The number of logical pixels between each mark.
  final double intervalExtent;

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
  final double maxCrossAxisItemExtent;

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
    final defaultIntervalDuration =
        lastDateTime.difference(firstDateTime) ~/ 20;

    final defaultLinePaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = strokeCap;

    final defaultLabelTextStyle = Theme.of(context).textTheme.bodyText1 ??
        TextStyle(
          color: color,
        );

    return RenderDynamicTimeline(
      firstDateTime: firstDateTime,
      lastDateTime: lastDateTime,
      labelBuilder: labelBuilder,
      axis: axis,
      intervalDuration: intervalDuration ?? defaultIntervalDuration,
      intervalExtent: intervalExtent,
      crossAxisCount: crossAxisCount,
      maxCrossAxisIndicatorExtent: maxCrossAxisIndicatorExtent,
      maxCrossAxisItemExtent: maxCrossAxisItemExtent,
      minItemDuration: minItemDuration ?? defaultIntervalDuration ~/ 10,
      crossAxisSpacing: crossAxisSpacing,
      resizable: resizable,
      linePaint: paint ?? defaultLinePaint,
      labelTextStyle: textStyle ?? defaultLabelTextStyle,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant RenderDynamicTimeline renderObject,
  ) {
    final defaultIntervalDuration =
        lastDateTime.difference(firstDateTime) ~/ 20;

    final defaultLinePaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = strokeCap;

    final defaultLabelTextStyle = Theme.of(context).textTheme.bodyText1 ??
        TextStyle(
          color: color,
        );

    renderObject
      ..firstDateTime = firstDateTime
      ..lastDateTime = lastDateTime
      ..labelBuilder = labelBuilder
      ..axis = axis
      ..intervalDuration = intervalDuration ?? defaultIntervalDuration
      ..intervalExtent = intervalExtent
      ..crossAxisCount = crossAxisCount
      ..maxCrossAxisIndicatorExtent = maxCrossAxisIndicatorExtent
      ..maxCrossAxisItemExtent = maxCrossAxisItemExtent
      ..minItemDuration = minItemDuration ?? defaultIntervalDuration ~/ 10
      ..crossAxisSpacing = crossAxisSpacing
      ..resizable = resizable
      ..linePaint = paint ?? defaultLinePaint
      ..labelTextStyle = textStyle ?? defaultLabelTextStyle;
  }
}
