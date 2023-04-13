import '../customized_header_samples/pages.dart';
import 'package:flutter/material.dart';
import 'sample_collection_card.dart';

class CustomizedHeaderSamples extends StatelessWidget {

  const CustomizedHeaderSamples({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SampleCollectionCard(title: 'Customized header', sampleSelectionWidgets: [
      ElevatedButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const WeekHeaderGantt(),
          ),
        ),
        child: const Text('Week header Gantt Chart'),
      ),
      const SizedBox(height: 20),]);
  }
}
