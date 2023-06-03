import 'package:dynamic_timeline_example/sample_collections/overview_samples.dart';
import 'package:flutter/material.dart';

import 'sample_collections/background_painter_samples.dart';

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
    return const Scaffold(
      body: Center(
        child: Row(
          children: [
            Spacer(),
            OverviewSamples(),
            SizedBox(
              width: 40,
            ),
            BackgroundPainterSamples(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
