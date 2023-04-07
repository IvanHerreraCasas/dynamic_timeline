import '../background_painter_samples/pages.dart';
import 'package:flutter/material.dart';
import 'sample_collection_card.dart';

class BackgroundPainterSamples extends StatelessWidget {

  const BackgroundPainterSamples({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SampleCollectionCard(title: 'Colored timelines', sampleSelectionWidgets: [ElevatedButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const ColoredGanttChart(),
        ),
      ),
      child: const Text('Colored Gantt Chart'),
    ),
      const SizedBox(height: 20),]);
  }
}
