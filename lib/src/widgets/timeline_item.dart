import 'package:dynamic_timeline/src/widgets/raw_timeline_item.dart';
import 'package:flutter/widgets.dart';

/// {@template timeline_item}
/// An item that represents and event in a timeline and can be resized.
///
/// Build on the top of the [RawTimelineItem] and handles the update methods
/// to resize the item.
/// 
/// If you want to handle the update methods you can create a stateful widget
/// that returns a [RawTimelineItem]
/// {@endtemplate}
class TimelineItem extends StatefulWidget {
  /// {@macro timeline_item}
  TimelineItem({
    Key? key,
    required this.child,
    required this.startDateTime,
    required this.endDateTime,
    this.position = 0,
    this.onStartDateTimeChanged,
    this.onEndDateTimeChanged,
  })  : assert(
          startDateTime.isBefore(endDateTime),
          'startDateTime must be before endDateTime: '
          'starDateTime: $startDateTime --- endDateTime: $endDateTime',
        ),
        super(key: key);

  /// The widget below this widget in the tree.
  final Widget child;

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

  @override
  State<TimelineItem> createState() => _TimelineItemState();
}

class _TimelineItemState extends State<TimelineItem> {
  late DateTime _startDateTime;
  late DateTime _endDateTime;
  @override
  void initState() {
    super.initState();
    _startDateTime = widget.startDateTime;
    _endDateTime = widget.endDateTime;
  }

  void _onStartDateTimeUpdated(DateTime startDateTime) {
    setState(() {
      _startDateTime = startDateTime;
    });
  }

  void _onEndDateTimeUpdated(DateTime endDateTime) {
    setState(() {
      _endDateTime = endDateTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawTimelineItem(
      startDateTime: _startDateTime,
      endDateTime: _endDateTime,
      position: widget.position,
      onStartDateTimeUpdated: _onStartDateTimeUpdated,
      onEndDateTimeUpdated: _onEndDateTimeUpdated,
      onStartDateTimeChanged: widget.onStartDateTimeChanged,
      onEndDateTimeChanged: widget.onEndDateTimeChanged,
      child: widget.child,
    );
  }
}
