// ignore_for_file: public_member_api_docs
import 'package:flutter/rendering.dart';

class DynamicTimelineParentData extends ContainerBoxParentData<RenderBox> {
  DynamicTimelineParentData({
    required this.secondExtent,
    required this.minItemDuration,
    required this.axis,
    required this.resizable,
  });

  DateTime? startDateTime;
  DateTime? endDateTime;
  int? position;
  double secondExtent;
  Duration minItemDuration;
  Axis axis;
  bool resizable;
}
