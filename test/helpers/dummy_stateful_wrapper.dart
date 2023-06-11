import 'package:flutter/material.dart';

class DummyStatefulWrapper extends StatefulWidget {
  const DummyStatefulWrapper({required this.builder, super.key});

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
