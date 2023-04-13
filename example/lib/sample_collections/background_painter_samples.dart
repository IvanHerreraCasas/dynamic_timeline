import '../background_painter_samples/pages.dart';
import 'package:flutter/material.dart';
import 'sample_collection_card.dart';

class BackgroundPainterSamples extends StatelessWidget {

  const BackgroundPainterSamples({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SampleCollectionCard(title: 'Colored timelines', sampleSelectionWidgets: [
      ElevatedButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const ColoredGanttChart(),
        ),
      ),
      child: const Text('Colored Gantt Chart'),
    ),
      const SizedBox(height: 20),
      ElevatedButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const ColoredWeeklyTimetable(),
          ),
        ),
        child: const Text('Colored Weekly Timeline'),
      ), const SizedBox(height: 20),
      ElevatedButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const WeekHeaderGantt(),
          ),
        ),
        child: const Text('Week header Timeline'),
      ),const SizedBox(height: 20),
      ElevatedButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const FancyGantt(),
          ),
        ),
        child: const Text('Fancy Gantt Chart'),
      ),
      const SizedBox(height: 20),]);
  }
}
