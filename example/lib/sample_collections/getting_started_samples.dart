import '../getting_started_samples/weekly_timetable.dart';
import '../getting_started_samples/daily_timeline.dart';
import '../getting_started_samples/gantt_chart.dart';
import 'package:flutter/material.dart';
import 'sample_collection_card.dart';

class GettingStartedSamples extends StatelessWidget {

  const GettingStartedSamples({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SampleCollectionCard(sampleSelectionWidgets: [ElevatedButton(
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
