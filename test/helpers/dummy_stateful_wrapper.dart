import 'package:flutter/material.dart';

class DummyStatefulWrapper extends StatefulWidget {
  const DummyStatefulWrapper({super.key, required this.builder});

  final Widget Function() builder;

  @override
  State<StatefulWidget> createState() => DummyStatefulWrapperState();
}

class DummyStatefulWrapperState extends State<DummyStatefulWrapper> {
  @override
  Widget build(BuildContext context) {
    return widget.builder();
  }
}
