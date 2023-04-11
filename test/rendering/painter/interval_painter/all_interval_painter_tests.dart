import 'package:flutter_test/flutter_test.dart';

import 'colored_interval_painter_tests.dart';

class AllIntervalPainterTests{
  static void run(){
    group("Interval-Painter tests", (){
      ColoredIntervalPainterTests.run();
    });
  }
}