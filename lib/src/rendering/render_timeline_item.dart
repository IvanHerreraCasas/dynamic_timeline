// ignore_for_file: public_member_api_docs

import 'package:dynamic_timeline/dynamic_timeline.dart';
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
  })  : _startDateTime = startDateTime,
        _endDateTime = endDateTime,
        _position = position,
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
    if (value == _onStartDateTimeChanged) return;

    _onEndDateTimeChanged = value;
  }

  late final double _secondExtent;

  late final Duration _minItemDuration;

  late final Axis _axis;

  late final bool _resizable;

  late final VerticalDragGestureRecognizer _topDragGestureRecognizer;

  late final VerticalDragGestureRecognizer _bottomDragGestureRecognizer;

  late final HorizontalDragGestureRecognizer _leftDragGestureRecognizer;

  late final HorizontalDragGestureRecognizer _rightDragGestureRecognizer;

  void _onUpdateStartDateTime(DragUpdateDetails details) {
    late final Duration duration;
    if (_axis == Axis.vertical) {
      duration = Duration(seconds: details.delta.dy ~/ _secondExtent);
    } else {
      duration = Duration(seconds: details.delta.dx ~/ _secondExtent);
    }

    final possibleStartDateTime = startDateTime.add(duration);

    if (endDateTime.difference(possibleStartDateTime) > _minItemDuration) {
      onStartDateTimeUpdated?.call(possibleStartDateTime);
    }
  }

  void _onUpdateEndDateTime(DragUpdateDetails details) {
    late final Duration duration;

    if (_axis == Axis.vertical) {
      duration = Duration(seconds: details.delta.dy ~/ _secondExtent);
    } else {
      duration = Duration(seconds: details.delta.dx ~/ _secondExtent);
    }

    final possibleEndDateTime = endDateTime.add(duration);

    if (possibleEndDateTime.difference(startDateTime) > _minItemDuration) {
      onEndDateTimeUpdated?.call(possibleEndDateTime);
    }
  }

  void _onChangeStartDateTime(DragEndDetails details) {
    onStartDateTimeChanged?.call(startDateTime);
  }

  void _onChangeEndDateTime(DragEndDetails details) {
    onEndDateTimeChanged?.call(endDateTime);
  }

  @override
  DynamicTimelineParentData? get parentData {
    if (super.parentData == null) return null;
    assert(
      super.parentData is DynamicTimelineParentData,
      '$RawTimelineItem can only be direct child of $DynamicTimeline',
    );
    return super.parentData! as DynamicTimelineParentData;
  }

  @override
  void attach(covariant PipelineOwner owner) {
    super.attach(owner);
    parentData!.startDateTime = startDateTime;
    parentData!.endDateTime = endDateTime;
    parentData!.position = position;

    _secondExtent = parentData!.secondExtent;

    _minItemDuration = parentData!.minItemDuration;

    _axis = parentData!.axis;

    _resizable = parentData!.resizable;

    if (_resizable) {
      if (_axis == Axis.vertical) {
        _topDragGestureRecognizer = VerticalDragGestureRecognizer()
          ..onUpdate = _onUpdateStartDateTime
          ..onEnd = _onChangeStartDateTime;

        _bottomDragGestureRecognizer = VerticalDragGestureRecognizer()
          ..onUpdate = _onUpdateEndDateTime
          ..onEnd = _onChangeEndDateTime;
      } else {
        _leftDragGestureRecognizer = HorizontalDragGestureRecognizer()
          ..onUpdate = _onUpdateStartDateTime
          ..onEnd = _onChangeStartDateTime;

        _rightDragGestureRecognizer = HorizontalDragGestureRecognizer()
          ..onUpdate = _onUpdateEndDateTime
          ..onEnd = _onChangeEndDateTime;
      }
    }
  }

  @override
  bool hitTestSelf(Offset position) {
    return position.dy < 10 ||
        (position.dy < size.height && position.dy > size.height - 10);
  }

  @override
  void handleEvent(PointerEvent event, covariant HitTestEntry entry) {
    assert(debugHandleEvent(event, entry), '');
    if (_resizable) {
      if (_axis == Axis.vertical) {
        if (event.localPosition.dy < 10) {
          if (event is PointerDownEvent) {
            _topDragGestureRecognizer.addPointer(event);
          } else if (event is PointerHoverEvent) {
            _cursor = SystemMouseCursors.resizeUp;
          }
        } else if (size.height - 10 < event.localPosition.dy &&
            event.localPosition.dy < size.height) {
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
        if (event.localPosition.dx < 10) {
          if (event is PointerDownEvent) {
            _leftDragGestureRecognizer.addPointer(event);
          } else if (event is PointerHoverEvent) {
            _cursor = SystemMouseCursors.resizeLeft;
          }
        } else if (size.width - 10 < event.localPosition.dx &&
            event.localPosition.dx < size.width) {
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
