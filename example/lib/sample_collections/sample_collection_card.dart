import 'package:flutter/material.dart';

class SampleCollectionCard extends StatelessWidget {
  const SampleCollectionCard({Key? key, required this.title, required this.sampleSelectionWidgets})
      : super(key: key);

  final String title;
  final List<Widget> sampleSelectionWidgets;

  @override
  Widget build(BuildContext context) {
    var cardContent = [
      Row(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Spacer()
        ],
      ),
      Container(
        margin: const EdgeInsets.all(10),
        height: 1,
        color: Colors.grey,
      ),
      const SizedBox(height: 40),
    ];
    cardContent.addAll(sampleSelectionWidgets);
    return Card(
      child: SizedBox(
        width: 300,
        height: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: cardContent,
        ),
      ),
    );
  }
}
