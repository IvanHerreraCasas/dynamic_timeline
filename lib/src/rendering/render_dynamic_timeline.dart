import 'package:dynamic_timeline/src/rendering/painter/dynamic_timeline_painter.dart';
import 'package:flutter/rendering.dart';
import '../../dynamic_timeline.dart';
import 'painter/horizontal_timeline_painter.dart';
import 'painter/interval_painter/interval_painter.dart';
import 'painter/vertical_timeline_painter.dart';

class DynamicTimelineParentData extends ContainerBoxParentData<RenderBox> {
  DynamicTimelineParentData({
    required this.microsecondExtent,
    required this.minItemDuration,
    required this.axis,
    required this.resizable,
  });

  DateTime? startDateTime;
  DateTime? endDateTime;
  int? position;
  final double microsecondExtent;
  final Duration minItemDuration;
  final Axis axis;
  final bool resizable;
}

class RenderDynamicTimeline extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, DynamicTimelineParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, DynamicTimelineParentData> {
  RenderDynamicTimeline({
    required DateTime firstDateTime,
    required DateTime lastDateTime,
    required Axis axis,
    required Duration intervalDuration,
    required double intervalExtent,
    required int crossAxisCount,
    required double maxCrossAxisIndicatorExtent,
    required double maxCrossAxisItemExtent,
    required Duration minItemDuration,
    required double crossAxisSpacing,
    required bool resizable,
    required Paint linePaint,
    required TextStyle labelTextStyle,
    required List<IntervalPainter> intervalPainters,
  })  : _layoutProcessor = DynamicTimelineLayout(
          axis: axis,
          maxCrossAxisItemExtent: maxCrossAxisItemExtent,
          intervalExtent: intervalExtent,
          maxCrossAxisIndicatorExtent: maxCrossAxisIndicatorExtent,
          crossAxisSpacing: crossAxisSpacing,
          crossAxisCount: crossAxisCount,
          firstDateTime: firstDateTime,
          lastDateTime: lastDateTime,
          intervalDuration: intervalDuration,
        ),
        _maxCrossAxisIndicatorExtent = maxCrossAxisIndicatorExtent,
        _minItemDuration = minItemDuration,
        _intervalPainters= intervalPainters,
        _resizable = resizable {
    _painter = axis == Axis.vertical
        ? VerticalTimelinePainter(
            layouter: _layoutProcessor, linePaint: linePaint, labelTextStyle: labelTextStyle)
        : HorizontalTimelinePainter(
            layouter: _layoutProcessor, linePaint: linePaint, labelTextStyle: labelTextStyle);
  }

  late final DynamicTimelinePainter _painter;
  final DynamicTimelineLayout _layoutProcessor;

  final  List<IntervalPainter> _intervalPainters;
  List<IntervalPainter> get intervalPainters => _intervalPainters;
  set intervalPainters(List<IntervalPainter> value) {
    if (value == _intervalPainters) return;
    _intervalPainters.clear();
    _intervalPainters.addAll(value);
    markNeedsPaint();
  }

  DateTime get firstDateTime => _layoutProcessor.firstDateTime;

  set firstDateTime(DateTime value) {
    if (value == _layoutProcessor.firstDateTime) return;

    _layoutProcessor.firstDateTime = value;
    markNeedsLayout();
  }

  DateTime get lastDateTime => _layoutProcessor.lastDateTime;

  set lastDateTime(DateTime value) {
    if (value == _layoutProcessor.lastDateTime) return;

    _layoutProcessor.lastDateTime = value;
    markNeedsLayout();
  }

  TextStyle get labelTextStyle => _painter.labelTextStyle;

  set labelTextStyle(TextStyle value) {
    if (value == _painter.labelTextStyle) return;

    _painter.labelTextStyle = value;
    markNeedsLayout();
  }

  Axis get axis => _layoutProcessor.axis;

  set axis(Axis value) {
    if (value == _layoutProcessor.axis) return;

    _layoutProcessor.axis = value;
    markNeedsLayout();
  }

  Duration get intervalDuration => _layoutProcessor.intervalDuration;

  set intervalDuration(Duration value) {
    if (value == _layoutProcessor.intervalDuration) return;

    _layoutProcessor.intervalDuration = value;
    markNeedsLayout();
  }

  double get intervalExtent => _layoutProcessor.intervalExtent;

  set intervalExtent(double value) {
    if (value == _layoutProcessor.intervalExtent) return;

    _layoutProcessor.intervalExtent = value;
    markNeedsLayout();
  }

  int get crossAxisCount => _layoutProcessor.crossAxisCount;

  set crossAxisCount(int value) {
    if (value == _layoutProcessor.crossAxisCount) return;

    _layoutProcessor.crossAxisCount = value;
    markNeedsLayout();
  }

  double _maxCrossAxisIndicatorExtent;

  double get maxCrossAxisIndicatorExtent => _maxCrossAxisIndicatorExtent;

  set maxCrossAxisIndicatorExtent(double value) {
    if (value == _maxCrossAxisIndicatorExtent) return;

    _maxCrossAxisIndicatorExtent = value;
    markNeedsLayout();
  }

  double get maxCrossAxisItemExtent => _layoutProcessor.maxCrossAxisItemExtent;

  set maxCrossAxisItemExtent(double value) {
    if (value == _layoutProcessor.maxCrossAxisItemExtent) return;

    _layoutProcessor.maxCrossAxisItemExtent = value;
    markNeedsLayout();
  }

  Duration _minItemDuration;

  Duration get minItemDuration => _minItemDuration;

  set minItemDuration(Duration value) {
    if (value == _minItemDuration) return;

    _minItemDuration = value;
  }

  double get crossAxisSpacing => _layoutProcessor.crossAxisSpacing;

  set crossAxisSpacing(double value) {
    if (value == _layoutProcessor.crossAxisSpacing) return;

    _layoutProcessor.crossAxisSpacing = value;
    markNeedsLayout();
  }

  bool _resizable;

  bool get resizable => _resizable;

  set resizable(bool value) {
    if (value == _resizable) return;

    _resizable = value;
  }

  Paint get linePaint => _painter.linePaint;

  set linePaint(Paint value) {
    if (value == _painter.linePaint) return;
    _painter.linePaint = value;
    markNeedsPaint();
  }

  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! DynamicTimelineParentData) {
      child.parentData = DynamicTimelineParentData(
        microsecondExtent: intervalExtent / intervalDuration.inMicroseconds,
        minItemDuration: minItemDuration,
        axis: axis,
        resizable: resizable,
      );
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    _layoutProcessor.updateConstraints(constraints);
    return _layoutProcessor.computeSize();
  }

  @override
  void performLayout() {
    _layoutProcessor.updateConstraints(constraints);
    size = _layoutProcessor.computeSize();
    final maxCrossAxisItemExtent =
        _layoutProcessor.getMaxCrossAxisItemExtent();

    var child = firstChild;

    // define children layout and position
    while (child != null) {
      if (!(child is RenderTimelineItem)) continue;

      final timeLineChild = child as RenderTimelineItem;
      final childParentData = timeLineChild.parentData!;

      late final DateTime startDateTime;
      late final DateTime endDateTime;
      late final int position;

      startDateTime = childParentData.startDateTime!;
      endDateTime = childParentData.endDateTime!;
      position = childParentData.position!;

      final childDuration = endDateTime.difference(startDateTime);

      final childMainAxisExtent = _layoutProcessor.getExtentSecondRate() * childDuration.inSeconds;

      final differenceFromFirstDate = startDateTime.difference(firstDateTime);

      final mainAxisPosition =
          _layoutProcessor.getExtentSecondRate() * differenceFromFirstDate.inSeconds;

      final crossAxisPosition =
          _getCrossAxisPositionFor(maxCrossAxisItemExtent, position, timeLineChild);

      if (axis == Axis.vertical) {
        child.layout(
          BoxConstraints(
            minHeight: childMainAxisExtent,
            maxHeight: childMainAxisExtent,
            maxWidth: timeLineChild.isTimelineLabelItem
                ? maxCrossAxisIndicatorExtent
                : maxCrossAxisItemExtent,
          ),
        );

        childParentData.offset = Offset(crossAxisPosition, mainAxisPosition);
      } else {
        child.layout(
          BoxConstraints(
            minWidth: childMainAxisExtent,
            maxWidth: childMainAxisExtent,
            maxHeight: timeLineChild.isTimelineLabelItem
                ? maxCrossAxisIndicatorExtent
                : maxCrossAxisItemExtent,
          ),
        );

        childParentData.offset = Offset(mainAxisPosition, crossAxisPosition);
      }

      child = childParentData.nextSibling;
    }
    intervalPainters.forEach(_layoutProcessor.updateLayoutDataFor);
  }

  double _getCrossAxisPositionFor(
      double maxCrossAxisItemExtent, int position, RenderTimelineItem? child) {
    if (child?.isTimelineLabelItem ?? false == true)
      return (crossAxisSpacing + maxCrossAxisItemExtent) * position;
    return maxCrossAxisIndicatorExtent +
        crossAxisSpacing +
        (crossAxisSpacing + maxCrossAxisItemExtent) * position;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.pushClipRect(
      needsCompositing,
      offset,
      Offset.zero & size,
      (context, offset) {
        final canvas = context.canvas;

        intervalPainters.forEach((painter)=> painter.paint(canvas,offset));

        // paint children
        defaultPaint(context, offset);

        _painter.paint(canvas, offset, size);
      },
    );
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    return size.width;
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    return size.width;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return size.height;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    return size.height;
  }
}
