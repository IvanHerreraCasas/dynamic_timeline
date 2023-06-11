// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'package:dynamic_timeline/src/rendering/painter/interval_painter/background_painter_data.dart';
import 'package:flutter/material.dart';

abstract class BackgroundPainter {
  BackgroundPainter();

  BackgroundPainterData data = BackgroundPainterData();

  Axis get painterDirection;

  void paint(
    Canvas canvas,
    Offset canvasOffset,
  );

  // ignore: use_setters_to_change_properties
  void setLayout({required BackgroundPainterData data}) => this.data = data;
}
