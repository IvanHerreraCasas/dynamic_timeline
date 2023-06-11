// ignore_for_file: lines_longer_than_80_chars

import 'package:dynamic_timeline/src/rendering/dynamic_timeline_layout.dart';
import 'package:flutter/material.dart';

class TestLayoutEngineFactory {
  static DynamicTimelineLayout create({
    double maxCrossAxisItemExtent = double.infinity,
    Axis axis = Axis.vertical,
  }) {
    return DynamicTimelineLayout(
      intervalExtent: 50,
      crossAxisCount: 2,
      crossAxisSpacing: 2,
      maxCrossAxisIndicatorExtent: 60,
      maxCrossAxisItemExtent: maxCrossAxisItemExtent,
      axis: axis,
      firstDateTime: DateTime(2023, 1, 1, 7),
      lastDateTime: DateTime(2023, 1, 1, 7 + 3),
      intervalDuration: const Duration(hours: 1),
    );
  }
}
