import 'package:dynamic_timeline/dynamic_timeline.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:shouldly/shouldly.dart';

class MultiIntervalLabelsTests {
  static void run() {
    group('Testing multi-interval labels', () {
      test('Creating a 2 days timeline with iterval 1D and label spred 2D'
        '--> should create one label',
        () {
          var calls = 0;
          final timelines = DynamicTimeline(
            firstDateTime: DateTime(2023,1,1),
            lastDateTime: DateTime(2023,1,3) ,
            labelIntervalSpread: 2,
            labelBuilder: (labelDate)  {
              calls++;
              return Text('date');
            },
            items: [],
            intervalDuration: const Duration(days: 1),
          );

          expect(calls, 1 );
        },
      );

      test('Creating a 4 days timeline with iterval 1D and label spred 2D'
          '--> should create two labels',
            () {
          var calls = 0;
          final timelines = DynamicTimeline(
            firstDateTime: DateTime(2023,1,1),
            lastDateTime: DateTime(2023,1,5) ,
            labelIntervalSpread: 2,
            labelBuilder: (labelDate)  {
              calls++;
              return Text('date');
            },
            items: [],
            intervalDuration: const Duration(days: 1),
          );

          expect(calls, 2 );
        },
      );

      test('Creating a 4 days timeline with iterval 1D and label spred 2D'
          '--> the second interval should be 2 days after the first',
            () {
          final List<DateTime> dates = [];
          final startDate = DateTime(2023,1,1);
          final timelines = DynamicTimeline(
            firstDateTime: startDate,
            lastDateTime: DateTime(2023,1,5) ,
            labelIntervalSpread: 2,
            labelBuilder: (labelDate)  {
              dates.add(labelDate);
              return Text('date');
            },
            items: [],
            intervalDuration: const Duration(days: 1),
          );

          final twoDays = Duration(days: 2);
          dates[0].toIso8601String().should.be(startDate.toIso8601String());
          dates[1].toIso8601String().should.be(startDate.add(twoDays).toIso8601String());
        },
      );

      test('Creating a 4 days timeline with iterval 1D and label spred 2D'
          '--> the two child item should have a duration of 2 days',
            () {
          final List<DateTime> dates = [];
          final startDate = DateTime(2023,1,1);
          final timelines = DynamicTimeline(
            firstDateTime: startDate,
            lastDateTime: DateTime(2023,1,5) ,
            labelIntervalSpread: 2,
            labelBuilder: (labelDate)  {
              dates.add(labelDate);
              return Text('date');
            },
            items: [],
            intervalDuration: const Duration(days: 1),
          );

          final twoDays = Duration(days: 2);
          final item1= (timelines.children[0] as TimelineItem);
          final item2= (timelines.children[1] as TimelineItem);

          final item1Duration = item1.endDateTime.difference(item1.startDateTime);
          final item2Duration = item2.endDateTime.difference(item2.startDateTime);

          item1Duration.should.be(twoDays);
          item2Duration.should.be(twoDays);
        },
      );

    });
  }
}
