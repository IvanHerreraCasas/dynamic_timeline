import 'package:dynamic_timeline/dynamic_timeline.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

class SimpleLabelTests {
  static void run() {
    group('Simple one interval labels', () {
      test('Creating a 2 days timeline with day interval '
          '--> label build gets called twice',() {
        var calls = 0;
        DynamicTimeline(
          firstDateTime: DateTime(2023,1,1),
          lastDateTime: DateTime(2023,1,3) ,
          labelBuilder: (labelDate)  {
            calls++;
            return Text('date');
          },
          items: [],
          intervalDuration: const Duration(days: 1),
        );

        expect(calls, 2);
      },);

      test('Creating a 2 days timeline with day interval '
          '--> label build gets called with the correct dates',() {
        List<DateTime> callDates = [];
        DynamicTimeline(
          firstDateTime: DateTime(2023,1,1),
          lastDateTime: DateTime(2023,1,3) ,
          labelBuilder: (labelDate)  {
            callDates.add(labelDate);
            return Text('date');
          },
          items: [],
          intervalDuration: const Duration(days: 1),
        );

        expect(callDates[0], DateTime(2023,1,1));
        expect(callDates[1], DateTime(2023,1,2));
      },);

    });
  }
}