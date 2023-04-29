// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars, always_use_package_imports
import 'package:flutter/material.dart';
import 'interval_painter/background_painter_data.dart';

abstract class BackgroundPainter {
  BackgroundPainter();

  BackgroundPainterData data = BackgroundPainterData();

  Axis get painterDirection;

  void paint(
      Canvas canvas,
      Offset canvasOffset,
      );

  void setLayout({required BackgroundPainterData data}) => this.data = data;
}
