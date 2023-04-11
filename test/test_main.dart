import 'rendering/painter/all_painter_tests.dart';
import 'widgets/dynamic_timeline_label_builder_tests.dart';
import 'widgets/dynamic_timeline_tests.dart';
import 'widgets/timeline_item_tests.dart';

void main(){
  DynamicTimelineTests.run();
  DynamicTimelineLabelBuilderTests.run();
  TimelineItemTests.run();
  AllPainterTests.run();
}