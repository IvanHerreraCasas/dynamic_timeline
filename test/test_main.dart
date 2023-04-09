import 'rendering/painter/interval_painter_layout_tests.dart';
import 'widgets/dynamic_timeline_label_builder_tests.dart';
import 'rendering/painter/dynamic_timeline_layout.dart';
import 'widgets/dynamic_timeline_tests.dart';
import 'widgets/timeline_item_tests.dart';

void main(){
  DynamicTimelineTests.run();
  DynamicTimelineLabelBuilderTests.run();
  DynamicTimelineLayoutTests.run();
  IntervalPainterLayoutTests.run();
  TimelineItemTests.run();
}