import 'package:dynamic_timeline/dynamic_timeline.dart';
import 'package:dynamic_timeline_example/background_painter_samples/fancy_gantt_item.dart';
import 'package:dynamic_timeline_example/widgets/week_header.dart';
import 'package:dynamic_timeline_example/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FancyGantt extends StatefulWidget {
  const FancyGantt({Key? key}) : super(key: key);

  @override
  State<FancyGantt> createState() => _FancyGantt();
}

class _FancyGantt extends State<FancyGantt> {
  late final ScrollController scrollController;
  final items = [
    TimelineItem(
      startDateTime: DateTime(2022, 1, 4),
      endDateTime: DateTime(2022, 1, 15),
      child: _createFancyItem('04.01-15.1.2022'),
      position: 0,
    ),
    TimelineItem(
      startDateTime: DateTime(2022, 3, 4),
      endDateTime: DateTime(2022, 3, 15),
      child: _createFancyItem('04.03-15.3.2022'),
      position: 0,
    ),
    TimelineItem(
      startDateTime: DateTime(2022, 1, 20),
      endDateTime: DateTime(2022, 2, 1),
      position: 1,
      child: _createFancyItem('20.01-01.2.2022'),
    ),
    TimelineItem(
      startDateTime: DateTime(2022, 4, 20),
      endDateTime: DateTime(2022, 5, 1),
      position: 1,
      child: _createFancyItem('20.04-01.5.2022'),
    ),
    TimelineItem(
      startDateTime: DateTime(2022, 2, 1),
      endDateTime: DateTime(2022, 3, 15),
      position: 2,
      child: _createFancyItem('01.02-15.3.2022'),
    ),
    TimelineItem(
      startDateTime: DateTime(2022, 5, 1),
      endDateTime: DateTime(2022, 6, 15),
      position: 2,
      child: _createFancyItem('01.05-15.06.2022'),
    ),
  ];

  static Widget _createFancyItem(String dateCaption) {
    return Column(children: [
      SizedBox(
          width: double.infinity,
          child: Text(dateCaption,
              textAlign: TextAlign.left, style: TextStyle(color: Colors.black54))),
      SizedBox(height: 20, child: FancyGanttItem(color: Colors.indigo))
    ]);
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fancy Gantt Chart ')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(200, 0, 200, 0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black87),
            ),
            child: Scrollbar(
              controller: scrollController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: scrollController,
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: DynamicTimeline(
                    firstDateTime: DateTime(2022, 1, 3),
                    lastDateTime: DateTime(2022, 7, 31),
                    labelBuilder: LabelBuilder(
                      intervalExtend: 7,
                      builder: (date) => WeekHeader(date: date),
                    ),
                    axis: Axis.horizontal,
                    intervalDuration: const Duration(days: 1),
                    minItemDuration: const Duration(days: 1),
                    crossAxisCount: 6,
                    intervalExtent: 20,
                    maxCrossAxisIndicatorExtent: 50,
                    maxCrossAxisItemExtent: 40,
                    crossAxisSpacing: 1,
                    intervalPainters: [
                      ColoredIntervalPainter.createHorizontal(
                          intervalSelector: (interval) => interval % 7 > 4,
                          paint: Paint()..color = Color.fromARGB(255, 0xF5, 0xF5, 0xF5)),
                      ColoredIntervalPainter.createHorizontal(
                          intervalSelector: (interval) => interval % 7 < 5,
                          paint: Paint()..color = Colors.white),
                      IntervalDecorationPainter.createHorizontal(
                          intervalSelector: (interval) => interval % 7 == 6 || interval % 7 == 4,
                          paint: Paint()..color = Color.fromARGB(255, 0xcf, 0xcf, 0xcf)),
                      IntervalDecorationPainter.createVertical(
                          paint: Paint()..color = Color.fromARGB(255, 0xcf, 0xcf, 0xcf))
                    ],
                    //intervalPainters: [VerticalIntervalPainter()],
                    items: items,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
