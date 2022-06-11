import 'package:dynamic_timeline/dynamic_timeline.dart';
import 'package:flutter/widgets.dart';


/// {@template raw_timeline_item}
/// A widget that positioned a child in a [DynamicTimeline]
/// and detects drag gestures in the start and end sides.
/// {@endtemplate}
@Deprecated('Use TimelineItem instead.')
class RawTimelineItem extends SingleChildRenderObjectWidget {
  /// {@macro raw_timeline_item}
  @Deprecated('Use TimelineItem instead.')
  RawTimelineItem({
    Key? key,
    required Widget child,
    required this.startDateTime,
    required this.endDateTime,
    this.position = 0,
    this.onStartDateTimeUpdated,
    this.onEndDateTimeUpdated,
    this.onStartDateTimeChanged,
    this.onEndDateTimeChanged,
  })  : assert(
          startDateTime.isBefore(endDateTime),
          'startDateTime must be before endDateTime: '
          'starDateTime: $startDateTime --- endDateTime: $endDateTime',
        ),
        super(key: key, child: child);

  /// The start date time of the event.
  ///
  /// Used to calculate the start of the item.
  final DateTime startDateTime;

  /// The end date time of the event
  ///
  /// Used to calculate the end of the item.
  final DateTime endDateTime;

  /// The position in the cross axis of the item.
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
