import 'interval_painter/all_interval_painter_tests.dart';
import 'package:flutter_test/flutter_test.dart';
import 'interval_painter_layout_tests.dart';
import 'dynamic_timeline_layout.dart';

class AllPainterTests{
  static void run(){
    group("Painter tests", (){
      DynamicTimelineLayoutTests.run();
      IntervalPainterLayoutTests.run();
      AllIntervalPainterTests.run();
    });
  }
}