// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'package:dynamic_timeline/dynamic_timeline.dart';
import 'package:dynamic_timeline/src/rendering/dynamic_timeline_parent_data.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class RenderTimelineItem extends RenderProxyBox
    implements MouseTrackerAnnotation {
  RenderTimelineItem({
    required DateTime startDateTime,
    required DateTime endDateTime,
    required int position,
    required void Function(DateTime)? onStartDateTimeUpdated,
    required void Function(DateTime)? onEndDateTimeUpdated,
    required void Function(DateTime)? onStartDateTimeChanged,
    required void Function(DateTime)? onEndDateTimeChanged,
    bool? isTimelineLabelItem,
  })  : _startDateTime = startDateTime,
        _endDateTime = endDateTime,
        _position = position,
        _isTimelineLabelItem = isTimelineLabelItem ?? false,
        _onStartDateTimeUpdated = onStartDateTimeUpdated,
        _onEndDateTimeUpdated = onEndDateTimeUpdated,
        _onStartDateTimeChanged = onStartDateTimeChanged,
        _onEndDateTimeChanged = onEndDateTimeChanged;

  DateTime _startDateTime;

  DateTime get startDateTime => _startDateTime;

  set startDateTime(DateTime value) {
    if (value.isAtSameMomentAs(_startDateTime)) return;

    _startDateTime = value;
    parentData!.startDateTime = _startDateTime;
    markParentNeedsLayout();
  }

  final bool _isTimelineLabelItem;
  bool get isTimelineLabelItem => _isTimelineLabelItem;

  DateTime _endDateTime;

  DateTime get endDateTime => _endDateTime;

  set endDateTime(DateTime value) {
    if (value.isAtSameMomentAs(_endDateTime)) return;

    _endDateTime = value;
    parentData!.endDateTime = _endDateTime;
    markParentNeedsLayout();
  }

  int _position;

  int get position => _position;

  set position(int value) {
    if (value == _position) return;

    _position = value;
    markParentNeedsLayout();
  }

  void Function(DateTime)? _onStartDateTimeUpdated;

  void Function(DateTime)? get onStartDateTimeUpdated =>
      _onStartDateTimeUpdated;

  set onStartDateTimeUpdated(void Function(DateTime)? value) {
    if (value == _onStartDateTimeUpdated) return;

    _onStartDateTimeUpdated = value;
  }

  void Function(DateTime)? _onEndDateTimeUpdated;

  void Function(DateTime)? get onEndDateTimeUpdated => _onEndDateTimeUpdated;

  set onEndDateTimeUpdated(void Function(DateTime)? value) {
    if (value == _onEndDateTimeUpdated) return;

    _onEndDateTimeUpdated = value;
  }

  void Function(DateTime)? _onStartDateTimeChanged;

  void Function(DateTime)? get onStartDateTimeChanged =>
      _onStartDateTimeChanged;

  set onStartDateTimeChanged(void Function(DateTime)? value) {
    if (value == _onStartDateTimeChanged) return;

    _onStartDateTimeChanged = value;
  }

  void Function(DateTime)? _onEndDateTimeChanged;

  void Function(DateTime)? get onEndDateTimeChanged => _onEndDateTimeChanged;

  set onEndDateTimeChanged(void Function(DateTime)? value) {
    if (value == _onEndDateTimeChanged) return;

    _onEndDateTimeChanged = value;
  }

  late double _secondExtent;

  late Duration _minItemDuration;

  late Axis _axis;

  late bool _resizable;

  late double _minItemExtent;

  late VerticalDragGestureRecognizer _topDragGestureRecognizer;

  late VerticalDragGestureRecognizer _bottomDragGestureRecognizer;

  late HorizontalDragGestureRecognizer _leftDragGestureRecognizer;

  late HorizontalDragGestureRecognizer _rightDragGestureRecognizer;

  void _onUpdateTopOrLeft(DragUpdateDetails details) {
    var duration = Duration.zero;

    final globalDragPosition = details.globalPosition;

    if (_axis == Axis.vertical) {
      final globalBottomPosition = localToGlobal(paintBounds.bottomCenter).dy;

      if (details.delta.dy >= 0 ||
          globalDragPosition.dy <= globalBottomPosition - _minItemExtent) {
        duration = Duration(
          seconds: details.delta.dy ~/ _secondExtent,
        );
      }
    } else {
      final globalRightPosition = localToGlobal(paintBounds.centerRight).dx;
      if (details.delta.dx >= 0 ||
          globalDragPosition.dx <= globalRightPosition - _minItemExtent) {
        duration = Duration(
          seconds: details.delta.dx ~/ _secondExtent,
        );
      }
    }

    final possibleStartDateTime = startDateTime.add(duration);

    if (endDateTime.difference(possibleStartDateTime) > _minItemDuration) {
      onStartDateTimeUpdated?.call(possibleStartDateTime);
      startDateTime = possibleStartDateTime;
    }
  }

  void _onUpdateBottomOrRight(DragUpdateDetails details) {
    var duration = Duration.zero;

    final globalDragPosition = details.globalPosition;

    if (_axis == Axis.vertical) {
      final globalTopPosition = localToGlobal(paintBounds.topCenter).dy;
      if (details.delta.dy <= 0 ||
          globalDragPosition.dy >= globalTopPosition + _minItemExtent) {
        duration = Duration(
          seconds: details.delta.dy ~/ _secondExtent,
        );
      }
    } else {
      final globalLeftPosition = localToGlobal(paintBounds.centerLeft).dx;
      if (details.delta.dx <= 0 ||
          globalDragPosition.dx >= globalLeftPosition + _minItemExtent) {
        duration = Duration(
          seconds: details.delta.dx ~/ _secondExtent,
        );
      }
    }

    final possibleEndDateTime = endDateTime.add(duration);

    if (possibleEndDateTime.difference(startDateTime) > _minItemDuration) {
      onEndDateTimeUpdated?.call(possibleEndDateTime);
      endDateTime = possibleEndDateTime;
    }
  }

  void _onEndTopOrLeft(DragEndDetails details) {
    onStartDateTimeChanged?.call(startDateTime);
  }

  void _onEndBottomOrLeft(DragEndDetails details) {
    onEndDateTimeChanged?.call(endDateTime);
  }

  void _updateGestureRecognizers() {
    if (_axis == Axis.vertical) {
      _topDragGestureRecognizer = VerticalDragGestureRecognizer()
        ..onUpdate = _onUpdateTopOrLeft
        ..onEnd = _onEndTopOrLeft
        ..dragStartBehavior = DragStartBehavior.down;

      _bottomDragGestureRecognizer = VerticalDragGestureRecognizer()
        ..onUpdate = _onUpdateBottomOrRight
        ..onEnd = _onEndBottomOrLeft
        ..dragStartBehavior = DragStartBehavior.down;
    } else {
      _leftDragGestureRecognizer = HorizontalDragGestureRecognizer()
        ..onUpdate = _onUpdateTopOrLeft
        ..onEnd = _onEndTopOrLeft
        ..dragStartBehavior = DragStartBehavior.down;

      _rightDragGestureRecognizer = HorizontalDragGestureRecognizer()
        ..onUpdate = _onUpdateBottomOrRight
        ..onEnd = _onEndBottomOrLeft
        ..dragStartBehavior = DragStartBehavior.down;
    }
  }

  void _checkGestureProps() {
    _axis = parentData!.axis;

    _secondExtent = parentData!.secondExtent;

    _minItemDuration = parentData!.minItemDuration;

    _minItemExtent = _minItemDuration.inSeconds * _secondExtent;

    _resizable = parentData!.resizable;

    assert(
      !_resizable || endDateTime.difference(startDateTime) >= _minItemDuration,
      'resizable widgets can not have a duration less than minItemDuration',
    );

    _updateGestureRecognizers();
  }

  @override
  DynamicTimelineParentData? get parentData {
    if (super.parentData == null) return null;
    assert(
      super.parentData is DynamicTimelineParentData,
      '$TimelineItem can only be direct child of $DynamicTimeline',
    );
    return super.parentData! as DynamicTimelineParentData;
  }

  @override
  void attach(covariant PipelineOwner owner) {
    super.attach(owner);
    parentData!.startDateTime = startDateTime;
    parentData!.endDateTime = endDateTime;
    parentData!.position = position;

    _checkGestureProps();
  }

  @override
  void handleEvent(PointerEvent event, covariant HitTestEntry entry) {
    assert(debugHandleEvent(event, entry), '');

    _checkGestureProps();

    if (_resizable) {
      if (_axis == Axis.vertical) {
        if (event.localPosition.dy < 5) {
          if (event is PointerDownEvent) {
            _topDragGestureRecognizer.addPointer(event);
          } else if (event is PointerHoverEvent) {
            _cursor = SystemMouseCursors.resizeUp;
          }
        } else if (size.height - 5 < event.localPosition.dy) {
          if (event is PointerDownEvent) {
            _bottomDragGestureRecognizer.addPointer(event);
          } else if (event is PointerHoverEvent) {
            _cursor = SystemMouseCursors.resizeDown;
          }
        } else {
          if (event is PointerHoverEvent) {
            _cursor = SystemMouseCursors.basic;
          }
        }
      } else {
        if (event.localPosition.dx < 5) {
          if (event is PointerDownEvent) {
            _leftDragGestureRecognizer.addPointer(event);
          } else if (event is PointerHoverEvent) {
            _cursor = SystemMouseCursors.resizeLeft;
          }
        } else if (size.width - 5 < event.localPosition.dx) {
          if (event is PointerDownEvent) {
            _rightDragGestureRecognizer.addPointer(event);
          } else if (event is PointerHoverEvent) {
            _cursor = SystemMouseCursors.resizeRight;
          }
        } else {
          if (event is PointerHoverEvent) {
            _cursor = SystemMouseCursors.basic;
          }
        }
      }
    }
  }

  @override
  bool get sizedByParent => true;

  @override
  void performLayout() {
    _axis = parentData!.axis;
    _secondExtent = parentData!.secondExtent;
    _minItemExtent = _minItemDuration.inSeconds * _secondExtent;
    child!.layout(constraints);
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return constraints.biggest;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.pushClipRect(
      needsCompositing,
      offset,
      Offset.zero & size,
      (context, offset) {
        context.paintChild(child!, offset);
      },
    );
  }

  MouseCursor _cursor = SystemMouseCursors.basic;

  @override
  MouseCursor get cursor => _cursor;

  @override
  PointerEnterEventListener? get onEnter => null;

  @override
  PointerExitEventListener? get onExit => null;

  @override
  bool get validForMouseTracker => true;
}
