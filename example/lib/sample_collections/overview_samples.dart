import '../overview_samples/pages.dart';
import 'package:flutter/material.dart';
import 'sample_collection_card.dart';

class OverviewSamples extends StatelessWidget {

  const OverviewSamples({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SampleCollectionCard(title: 'Timelines overview', sampleSelectionWidgets: [ElevatedButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const DailyTimeline(),
        ),
      ),
      child: const Text('Daily timeline'),
    ),
      const SizedBox(height: 20),
      ElevatedButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const WeeklyTimetable(),
          ),
        ),
        child: const Text('Weekly timeline'),
      ),
      const SizedBox(height: 20),
      ElevatedButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const GanttChart(),
          ),
        ),
        child: const Text('Gantt chart'),
      ),]);
  }
}
