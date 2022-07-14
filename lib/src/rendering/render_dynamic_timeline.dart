// ignore_for_file: public_member_api_docs

import 'dart:math';
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
  })  : _firstDateTime = firstDateTime,
        _lastDateTime = lastDateTime,
        _labelBuilder = labelBuilder,
        _axis = axis,
        _intervalDuration = intervalDuration,
        _intervalExtent = intervalExtent,
        _crossAxisCount = crossAxisCount,
        _maxCrossAxisIndicatorExtent = maxCrossAxisIndicatorExtent,
        _maxCrossAxisItemExtent = maxCrossAxisItemExtent,
        _minItemDuration = minItemDuration,
        _crossAxixSpacing = crossAxisSpacing,
        _resizable = resizable,
        _linePaint = linePaint,
        _labelTextStyle = labelTextStyle;

  DateTime _firstDateTime;

  DateTime get firstDateTime => _firstDateTime;

  set firstDateTime(DateTime value) {
    if (value == _firstDateTime) return;

    _firstDateTime = value;
    markNeedsLayout();
  }

  DateTime _lastDateTime;

  DateTime get lastDateTime => _lastDateTime;

  set lastDateTime(DateTime value) {
    if (value == _lastDateTime) return;

    _lastDateTime = value;
    markNeedsLayout();
  }

  String? Function(DateTime dateTime) _labelBuilder;

  String? Function(DateTime dateTime) get labelBuilder => _labelBuilder;

  set labelBuilder(String? Function(DateTime dateTime) value) {
    if (value == _labelBuilder) return;

    _labelBuilder = value;
    markNeedsLayout();
  }

  TextStyle _labelTextStyle;

  TextStyle get labelTextStyle => _labelTextStyle;

  set labelTextStyle(TextStyle value) {
    if (value == _labelTextStyle) return;

    _labelTextStyle = value;
    markNeedsLayout();
  }

  Axis _axis;

  Axis get axis => _axis;

  set axis(Axis value) {
    if (value == _axis) return;

    _axis = value;
    markNeedsLayout();
  }

  Duration _intervalDuration;

  Duration get intervalDuration => _intervalDuration;

  set intervalDuration(Duration value) {
    if (value == _intervalDuration) return;

    _intervalDuration = value;
    markNeedsLayout();
  }

  double _intervalExtent;

  double get intervalExtent => _intervalExtent;

  set intervalExtent(double value) {
    if (value == _intervalExtent) return;

    _intervalExtent = value;
    markNeedsLayout();
  }

  int _crossAxisCount;

  int get crossAxisCount => _crossAxisCount;

  set crossAxisCount(int value) {
    if (value == _crossAxisCount) return;

    _crossAxisCount = value;
    markNeedsLayout();
  }

  double _maxCrossAxisIndicatorExtent;

  double get maxCrossAxisIndicatorExtent => _maxCrossAxisIndicatorExtent;

  set maxCrossAxisIndicatorExtent(double value) {
    if (value == _maxCrossAxisIndicatorExtent) return;

    _maxCrossAxisIndicatorExtent = value;
    markNeedsLayout();
  }

  double? _maxCrossAxisItemExtent;

  double? get maxCrossAxisItemExtent => _maxCrossAxisItemExtent;

  set maxCrossAxisItemExtent(double? value) {
    if (value == _maxCrossAxisItemExtent) return;

    _maxCrossAxisItemExtent = value;
    markNeedsLayout();
  }

  Duration _minItemDuration;

  Duration get minItemDuration => _minItemDuration;

  set minItemDuration(Duration value) {
    if (value == _minItemDuration) return;

    _minItemDuration = value;
  }

  double _crossAxixSpacing;

  double get crossAxisSpacing => _crossAxixSpacing;

  set crossAxisSpacing(double value) {
    if (value == _crossAxixSpacing) return;

    _crossAxixSpacing = value;
    markNeedsLayout();
  }

  bool _resizable;

  bool get resizable => _resizable;

  set resizable(bool value) {
    if (value == _resizable) return;

    _resizable = value;
  }

  Paint _linePaint;

  Paint get linePaint => _linePaint;

  set linePaint(Paint value) {
    if (value == _linePaint) return;

    _linePaint = value;
    markNeedsPaint();
  }

  double _getExtentSecondRate() {
    return intervalExtent / intervalDuration.inSeconds;
  }

  Duration _getTotalDuration() {
    return lastDateTime.difference(firstDateTime);
  }

  double _getCrossAxisSize(Size size) {
    switch (axis) {
      case Axis.vertical:
        return size.width;
      case Axis.horizontal:
        return size.height;
    }
  }

  double _getMainAxisSize(Size size) {
    switch (axis) {
      case Axis.vertical:
        return size.height;
      case Axis.horizontal:
        return size.width;
    }
  }

  double _getCrossAxisExtent({required BoxConstraints constraints}) {
    final crossAxisSize = _getCrossAxisSize(constraints.biggest);

    if (maxCrossAxisItemExtent == null) return crossAxisSize;

    final attemptExtent = maxCrossAxisIndicatorExtent +
        (crossAxisSpacing + maxCrossAxisItemExtent!) * crossAxisCount;

    return min(
      crossAxisSize,
      attemptExtent,
    );
  }

  double _getMainAxisExtent({required BoxConstraints constraints}) {
    final mainAxisSize = _getMainAxisSize(constraints.biggest);
    final attemptExtent =
        _getExtentSecondRate() * _getTotalDuration().inSeconds;

    return min(mainAxisSize, attemptExtent);
  }

  Size _computeSize({required BoxConstraints constraints}) {
    final crossAxisExtent = _getCrossAxisExtent(constraints: constraints);

    final mainAxisExtent = _getMainAxisExtent(constraints: constraints);

    switch (axis) {
      case Axis.vertical:
        return Size(crossAxisExtent, mainAxisExtent);
      case Axis.horizontal:
        return Size(mainAxisExtent, crossAxisExtent);
    }
  }

  double _getMaxCrossAxisItemExtent({required BoxConstraints constraints}) {
    if (maxCrossAxisItemExtent != null) return maxCrossAxisItemExtent!;

    final crosAxisExtent = _getCrossAxisExtent(constraints: constraints);

    final freeSpaceExtent = crosAxisExtent -
        maxCrossAxisIndicatorExtent -
        crossAxisSpacing * crossAxisCount;

    return freeSpaceExtent / crossAxisCount;
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
    return _computeSize(constraints: constraints);
  }

  @override
  void performLayout() {
    size = _computeSize(constraints: constraints);
    final maxCrossAxisItemExtent =
        _getMaxCrossAxisItemExtent(constraints: constraints);

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

      final childMainAxisExtent =
          _getExtentSecondRate() * childDuration.inSeconds;

      final differenceFromFirstDate = startDateTime.difference(firstDateTime);

      final mainAxisPosition =
          _getExtentSecondRate() * differenceFromFirstDate.inSeconds;

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
        if (axis == Axis.vertical) {
          // paint children
          defaultPaint(context, offset);

          // paint line
          canvas.drawLine(
            Offset(
              offset.dx + maxCrossAxisIndicatorExtent,
              offset.dy,
            ),
            Offset(
              offset.dx + maxCrossAxisIndicatorExtent,
              offset.dy + size.height,
            ),
            linePaint,
          );

          // paint labels
          var dateTime = firstDateTime;
          var labelOffset = offset;

          while (dateTime.isBefore(lastDateTime)) {
            final label = labelBuilder(dateTime);

            if (label != null) {
              TextPainter(
                text: TextSpan(
                  text: label,
                  style: labelTextStyle,
                ),
                textDirection: TextDirection.ltr,
                ellipsis: '.',
              )
                // - 10 to have space between the label and the line
                ..layout(maxWidth: size.width - 10)
                ..paint(canvas, labelOffset);
            }
            labelOffset =
                Offset(labelOffset.dx, labelOffset.dy + intervalExtent);
            dateTime = dateTime.add(intervalDuration);
          }
        } else {
          // paint children
          defaultPaint(context, offset);

          // paint line
          canvas.drawLine(
            Offset(
              offset.dx,
              offset.dy + maxCrossAxisIndicatorExtent,
            ),
            Offset(
              offset.dx + size.width,
              offset.dy + maxCrossAxisIndicatorExtent,
            ),
            linePaint,
          );

          // paint labels
          var dateTime = firstDateTime;
          var labelOffset = offset;

          while (dateTime.isBefore(lastDateTime)) {
            final label = labelBuilder(dateTime);

            if (label != null) {
              TextPainter(
                text: TextSpan(
                  text: label,
                  style: labelTextStyle,
                ),
                textDirection: TextDirection.ltr,
                ellipsis: '.',
              )
                // - 10 to have space between the label and the line
                ..layout(maxWidth: size.width - 10)
                ..paint(canvas, labelOffset);
            }
            labelOffset =
                Offset(labelOffset.dx + intervalExtent, labelOffset.dy);
            dateTime = dateTime.add(intervalDuration);
          }
        }
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
