import 'package:dynamic_timeline/dynamic_timeline.dart';
import 'package:dynamic_timeline/src/rendering/render_timeline_item.dart';
import 'package:flutter/widgets.dart';

/// {@template timeline_item}
/// A widget that positions a child in a [DynamicTimeline]
/// and can be resized with drag gestures on the start and end sides.
/// {@endtemplate}
class TimelineItem extends SingleChildRenderObjectWidget {
  /// {@macro timeline_item}
  TimelineItem({
    required this.startDateTime,
    required this.endDateTime,
    required Widget super.child,
    super.key,
    this.position = 0,
    this.onStartDateTimeChanged,
    this.onEndDateTimeChanged,
    this.onStartDateTimeUpdated,
    this.onEndDateTimeUpdated,
  }) : assert(
          startDateTime.isBefore(endDateTime),
          'startDateTime must be before endDateTime: '
          'starDateTime: $startDateTime --- endDateTime: $endDateTime',
        );

  /// The start date time of the event.
  ///
  /// Used to calculate the start of the item.
  final DateTime startDateTime;

  /// The end date time of the event
  ///
  /// Used to calculate the end of the item.
  final DateTime endDateTime;

  /// The position in the cross axis of the item.
  ///
  /// Must be less that crossAxisCount.
  final int position;

  /// Called when the user has ended dragging the start side.
  final void Function(DateTime)? onStartDateTimeChanged;

  /// Called when the user has ended dragging the end side.
  final void Function(DateTime)? onEndDateTimeChanged;

  /// Called when the user is dragging the start side.
  final void Function(DateTime)? onStartDateTimeUpdated;

  /// Called when the user is dragging the end side.
  final void Function(DateTime)? onEndDateTimeUpdated;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderTimelineItem(
      startDateTime: startDateTime,
      endDateTime: endDateTime,
      position: position,
      onStartDateTimeUpdated: onStartDateTimeUpdated,
      onEndDateTimeUpdated: onEndDateTimeUpdated,
      onStartDateTimeChanged: onStartDateTimeChanged,
      onEndDateTimeChanged: onEndDateTimeChanged,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant RenderTimelineItem renderObject,
  ) {
    renderObject
      ..startDateTime = startDateTime
      ..endDateTime = endDateTime
      ..position = position
      ..onStartDateTimeUpdated = onStartDateTimeUpdated
      ..onEndDateTimeUpdated = onEndDateTimeUpdated
      ..onStartDateTimeChanged = onStartDateTimeChanged
      ..onEndDateTimeChanged = onEndDateTimeChanged;
  }
}
