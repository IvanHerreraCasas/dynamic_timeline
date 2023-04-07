import 'package:dynamic_timeline/src/rendering/painter/dynamic_timeline_painter.dart';
import 'package:dynamic_timeline/src/rendering/dynamic_timeline_layouter.dart';
import 'painter/horizontal_timeline_painter.dart';
import 'painter/vertical_timeline_painter.dart';
import 'package:flutter/rendering.dart';

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
    required String? Function(DateTime) labelBuilder,
    required Axis axis,
    required Duration intervalDuration,
    required double intervalExtent,
    required int crossAxisCount,
    required double maxCrossAxisIndicatorExtent,
    required double? maxCrossAxisItemExtent,
    required Duration minItemDuration,
    required double crossAxisSpacing,
    required bool resizable,
    required Paint linePaint,
    required TextStyle labelTextStyle,
  })  : _layouter = DynamicTimelineLayouter(
            axis: axis,
            maxCrossAxisItemExtent: maxCrossAxisItemExtent,
            intervalExtent: intervalExtent,
            maxCrossAxisIndicatorExtent: maxCrossAxisIndicatorExtent,
            crossAxisSpacing: crossAxisSpacing,
            crossAxisCount: crossAxisCount,
            firstDateTime: firstDateTime,
            lastDateTime: lastDateTime,
            intervalDuration: intervalDuration,),

        _maxCrossAxisIndicatorExtent = maxCrossAxisIndicatorExtent,
        _minItemDuration = minItemDuration,
        _resizable = resizable
  {
    _painter = axis == Axis.vertical?VerticalTimelinePainter(layouter: _layouter,
      linePaint: linePaint,labelBuilder: labelBuilder,labelTextStyle: labelTextStyle ):
    HorizontalTimelinePainter(layouter: _layouter,
        linePaint: linePaint,labelBuilder: labelBuilder,labelTextStyle: labelTextStyle );
  }

  late final DynamicTimelinePainter _painter;
  final DynamicTimelineLayouter _layouter;

  DateTime get firstDateTime => _layouter.firstDateTime;

  set firstDateTime(DateTime value) {
    if (value == _layouter.firstDateTime) return;

    _layouter.firstDateTime = value;
    markNeedsLayout();
  }

  DateTime get lastDateTime => _layouter.lastDateTime;

  set lastDateTime(DateTime value) {
    if (value == _layouter.lastDateTime) return;

    _layouter.lastDateTime = value;
    markNeedsLayout();
  }


  String? Function(DateTime dateTime) get labelBuilder => _painter.labelBuilder;

  set labelBuilder(String? Function(DateTime dateTime) value) {
    if (value == _painter.labelBuilder) return;

    _painter.labelBuilder = value;
    markNeedsLayout();
  }


  TextStyle get labelTextStyle => _painter.labelTextStyle;

  set labelTextStyle(TextStyle value) {
    if (value == _painter.labelTextStyle) return;

    _painter.labelTextStyle = value;
    markNeedsLayout();
  }

  Axis get axis => _layouter.axis;
  set axis(Axis value) {
    if (value == _layouter.axis) return;

    _layouter.axis = value;
    markNeedsLayout();
  }

  Duration get intervalDuration => _layouter.intervalDuration;

  set intervalDuration(Duration value) {
    if (value == _layouter.intervalDuration) return;

    _layouter.intervalDuration = value;
    markNeedsLayout();
  }


  double get intervalExtent => _layouter.intervalExtent;

  set intervalExtent(double value) {
    if (value == _layouter.intervalExtent) return;

    _layouter.intervalExtent = value;
    markNeedsLayout();
  }

  int get crossAxisCount => _layouter.crossAxisCount;

  set crossAxisCount(int value) {
    if (value == _layouter.crossAxisCount) return;

    _layouter.crossAxisCount = value;
    markNeedsLayout();
  }

  double _maxCrossAxisIndicatorExtent;

  double get maxCrossAxisIndicatorExtent => _maxCrossAxisIndicatorExtent;

  set maxCrossAxisIndicatorExtent(double value) {
    if (value == _maxCrossAxisIndicatorExtent) return;

    _maxCrossAxisIndicatorExtent = value;
    markNeedsLayout();
  }

  double? get maxCrossAxisItemExtent => _layouter.maxCrossAxisItemExtent;

  set maxCrossAxisItemExtent(double? value) {
    if (value == _layouter.maxCrossAxisItemExtent) return;

    _layouter.maxCrossAxisItemExtent = value;
    markNeedsLayout();
  }

  Duration _minItemDuration;

  Duration get minItemDuration => _minItemDuration;

  set minItemDuration(Duration value) {
    if (value == _minItemDuration) return;

    _minItemDuration = value;
  }

  double get crossAxisSpacing => _layouter.crossAxisSpacing;

  set crossAxisSpacing(double value) {
    if (value == _layouter.crossAxisSpacing) return;

    _layouter.crossAxisSpacing = value;
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
    return _layouter.computeSize(constraints: constraints);
  }

  @override
  void performLayout() {
    size = _layouter.computeSize(constraints: constraints);
    final maxCrossAxisItemExtent = _layouter.getMaxCrossAxisItemExtent(constraints: constraints);

    var child = firstChild;

    // define children layout and position
    while (child != null) {
      final childParentData = child.parentData! as DynamicTimelineParentData;

      late final DateTime startDateTime;
      late final DateTime endDateTime;
      late final int position;

      startDateTime = childParentData.startDateTime!;
      endDateTime = childParentData.endDateTime!;
      position = childParentData.position!;

      final childDuration = endDateTime.difference(startDateTime);

      final childMainAxisExtent = _layouter.getExtentSecondRate() * childDuration.inSeconds;

      final differenceFromFirstDate = startDateTime.difference(firstDateTime);

      final mainAxisPosition = _layouter.getExtentSecondRate() * differenceFromFirstDate.inSeconds;

      final crossAxisPosition = maxCrossAxisIndicatorExtent +
          crossAxisSpacing +
          (crossAxisSpacing + maxCrossAxisItemExtent) * position;

      if (axis == Axis.vertical) {
        child.layout(
          BoxConstraints(
            minHeight: childMainAxisExtent,
            maxHeight: childMainAxisExtent,
            maxWidth: maxCrossAxisItemExtent,
          ),
        );

        childParentData.offset = Offset(crossAxisPosition, mainAxisPosition);
      } else {
        child.layout(
          BoxConstraints(
            minWidth: childMainAxisExtent,
            maxWidth: childMainAxisExtent,
            maxHeight: maxCrossAxisItemExtent,
          ),
        );

        childParentData.offset = Offset(mainAxisPosition, crossAxisPosition);
      }

      child = childParentData.nextSibling;
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.pushClipRect(
      needsCompositing,
      offset,
      Offset.zero & size,
      (context, offset) {
        final canvas = context.canvas;

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
