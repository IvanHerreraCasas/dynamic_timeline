import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GanttRowHeader extends StatelessWidget {
  static const double headerWidth = 150;
  static const boxDecoration = BoxDecoration(
    border: Border(
      top: BorderSide(
        color: Color.fromARGB(255, 0xcf, 0xcf, 0xcf),
      ),
    ),
  );

  GanttRowHeader(
      {Key? key,
      required this.rowHeaderHeight,
      required this.rowHeight,
      required this.axisSpacing,
      required this.crossAxisCount,
      required List<EmployeeInfo> employeeInformation})
      : employeeInfoHeaders = _createHeaders(employeeInformation, rowHeight + axisSpacing),
        super(key: key);

  final double rowHeaderHeight;
  final double crossAxisCount;
  final double rowHeight;
  final double axisSpacing;
  final List<Widget> employeeInfoHeaders;

  static List<Widget> _createHeaders(List<EmployeeInfo> employeeInformation, double height) =>
      employeeInformation
          .map((e) => Container(
                padding: const EdgeInsets.only(left: 5, right: 5),
                decoration: boxDecoration,
                height: height,
                width: headerWidth,
                child: Column(
                  children: [
                    const Spacer(),
                    Text(e.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    const Spacer(),
                    Text(e.position, style: const TextStyle(fontSize: 10, fontStyle: FontStyle.italic)),
                    const Spacer(),
                  ],
                ),
              ))
          .toList();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
            right: BorderSide(
          color: Color.fromARGB(255, 0xcf, 0xcf, 0xcf),
        )),
      ),
      child: Column(
        children: <Widget>[
              SizedBox(
                height: rowHeaderHeight,
              )
            ] +
            employeeInfoHeaders +
            <Widget>[const Spacer()],
      ),
      height: (rowHeaderHeight + crossAxisCount * (rowHeight + axisSpacing) + 10),
    );
  }
}

class EmployeeInfo {
  const EmployeeInfo({required this.name, required this.position});

  final String name;
  final String position;
}
