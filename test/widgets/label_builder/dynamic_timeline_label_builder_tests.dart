import 'package:dynamic_timeline/dynamic_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'multi_interval_labels_tests.dart';
import 'simple_label_tests.dart';

class DynamicTimelineLabelBuilderTests {
  static void run() {
    group('DynamicTimeline label builder tests', () {
      SimpleLabelTests.run();
      MultiIntervalLabelsTests.run();
    });
  }
}
