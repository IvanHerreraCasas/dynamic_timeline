// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars, always_use_package_imports
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'painter/painter.dart';
import 'rendering.dart';

class RenderDynamicTimeline extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, DynamicTimelineParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, DynamicTimelineParentData> {
  @protected
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
        _intervalPainters = intervalPainters,
        _resizable = resizable {
    _painter = axis == Axis.vertical
        ? VerticalTimelinePainter(
            layouter: _layoutProcessor, linePaint: linePaint, labelTextStyle: labelTextStyle)
        : HorizontalTimelinePainter(
            layouter: _layoutProcessor, linePaint: linePaint, labelTextStyle: labelTextStyle);
  }

  late final DynamicTimelinePainter _painter;
  final DynamicTimelineLayout _layoutProcessor;

  final List<IntervalPainter> _intervalPainters;

  @protected
  List<IntervalPainter> get intervalPainters => _intervalPainters;

  set intervalPainters(List<IntervalPainter> value) {
    if (value == _intervalPainters) return;
    _intervalPainters.clear();
    _intervalPainters.addAll(value);
    markNeedsPaint();
  }

  @protected
  DateTime get firstDateTime => _layoutProcessor.firstDateTime;

  @protected
  set firstDateTime(DateTime value) {
    if (value == _layoutProcessor.firstDateTime) return;

    _layoutProcessor.firstDateTime = value;
    markNeedsLayout();
  }

  @protected
  DateTime get lastDateTime => _layoutProcessor.lastDateTime;

  @protected
  set lastDateTime(DateTime value) {
    if (value == _layoutProcessor.lastDateTime) return;

    _layoutProcessor.lastDateTime = value;
    markNeedsLayout();
  }

  @protected
  TextStyle get labelTextStyle => _painter.labelTextStyle;

  @protected
  set labelTextStyle(TextStyle value) {
    if (value == _painter.labelTextStyle) return;

    _painter.labelTextStyle = value;
    markNeedsLayout();
  }

  Axis get axis => _layoutProcessor.axis;

  @protected
  set axis(Axis value) {
    if (value == _layoutProcessor.axis) return;

    _layoutProcessor.axis = value;
    markNeedsLayout();
  }

  @protected
  Duration get intervalDuration => _layoutProcessor.intervalDuration;

  @protected
  set intervalDuration(Duration value) {
    if (value == _layoutProcessor.intervalDuration) return;

    _layoutProcessor.intervalDuration = value;
    markNeedsLayout();
  }

  @protected
  double get intervalExtent => _layoutProcessor.intervalExtent;

  @protected
  set intervalExtent(double value) {
    if (value == _layoutProcessor.intervalExtent) return;

    _layoutProcessor.intervalExtent = value;
    markNeedsLayout();
  }

  @protected
  int get crossAxisCount => _layoutProcessor.crossAxisCount;

  @protected
  set crossAxisCount(int value) {
    if (value == _layoutProcessor.crossAxisCount) return;

    _layoutProcessor.crossAxisCount = value;
    markNeedsLayout();
  }

  @protected
  double _maxCrossAxisIndicatorExtent;

  @protected
  double get maxCrossAxisIndicatorExtent => _maxCrossAxisIndicatorExtent;

  @protected
  set maxCrossAxisIndicatorExtent(double value) {
    if (value == _maxCrossAxisIndicatorExtent) return;

    _maxCrossAxisIndicatorExtent = value;
    markNeedsLayout();
  }

  @protected
  double get maxCrossAxisItemExtent => _layoutProcessor.maxCrossAxisItemExtent;

  @protected
  set maxCrossAxisItemExtent(double value) {
    if (value == _layoutProcessor.maxCrossAxisItemExtent) return;

    _layoutProcessor.maxCrossAxisItemExtent = value;
    markNeedsLayout();
  }

  @protected
  Duration _minItemDuration;

  @protected
  Duration get minItemDuration => _minItemDuration;

  @protected
  set minItemDuration(Duration value) {
    if (value == _minItemDuration) return;

    _minItemDuration = value;
  }

  @protected
  double get crossAxisSpacing => _layoutProcessor.crossAxisSpacing;

  @protected
  @protected
  set crossAxisSpacing(double value) {
    if (value == _layoutProcessor.crossAxisSpacing) return;

    _layoutProcessor.crossAxisSpacing = value;
    markNeedsLayout();
  }

  bool _resizable;

  @protected
  bool get resizable => _resizable;

  @protected
  set resizable(bool value) {
    if (value == _resizable) return;

    _resizable = value;
  }

  Paint get linePaint => _painter.linePaint;

  @protected
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
    final maxCrossAxisItemExtent = _layoutProcessor.getMaxCrossAxisItemExtent();

    var child = firstChild;

    // define children layout and position
    while (child != null) {
      if (child is! RenderTimelineItem) continue;

      final timeLineChild = child;
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

        intervalPainters.forEach((painter) => painter.paint(canvas, offset));

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
