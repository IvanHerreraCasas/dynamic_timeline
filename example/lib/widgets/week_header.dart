import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeekHeader extends StatelessWidget {
  const WeekHeader({Key? key, required this.date}) : super(key: key);

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    var backgroundGray = Color.fromARGB(255, 0xF5, 0xF5, 0xF5);
    var separatorGray = Color.fromARGB(255, 0xcf, 0xcf, 0xcf);
    return Container(
      decoration: BoxDecoration(
          border: Border(right: BorderSide(color: separatorGray)),
          color: backgroundGray),
      child: Center(
        child: Column(
          children: [
            Spacer(),
            Text(
              '${DateFormat('dd').format(date)} - '
              '${DateFormat('dd. MMM').format(date.add(Duration(days: 6)))}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text('Week ${weekNumber(date.add(Duration(days: 3)))}',style: TextStyle(fontSize: 11)),
            Spacer(),
          ],
        ),
      ),
    );
  }

  //ISO calculation taken from --> https://stackoverflow.com/a/54129275/4014430
  int weekNumber(DateTime date) {
    int dayOfYear = int.parse(DateFormat("D").format(date));
    int woy = ((dayOfYear - date.weekday + 10) / 7).floor();
    if (woy < 1) {
      woy = numOfWeeks(date.year - 1);
    } else if (woy > numOfWeeks(date.year)) {
      woy = 1;
    }
    return woy;
  }

  int numOfWeeks(int year) {
    DateTime dec28 = DateTime(year, 12, 28);
    int dayOfDec28 = int.parse(DateFormat("D").format(dec28));
    return ((dayOfDec28 - dec28.weekday + 10) / 7).floor();
  }
}
