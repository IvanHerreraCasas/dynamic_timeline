// ignore_for_file: public_member_api_docs
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
