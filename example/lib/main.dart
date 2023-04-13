import 'package:dynamic_timeline_example/sample_collections/overview_samples.dart';
import 'package:flutter/material.dart';

import 'sample_collections/background_painter_samples.dart';
import 'sample_collections/customized_header_samples.dart';
import 'sample_collections/sample_collection_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: const [
            Spacer(),
            OverviewSamples(),
            SizedBox(
              width: 40,
            ),
            BackgroundPainterSamples(),
            SizedBox(
              width: 40,
            ),
            CustomizedHeaderSamples(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
