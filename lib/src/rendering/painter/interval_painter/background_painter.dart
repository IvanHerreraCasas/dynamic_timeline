import 'package:flutter/material.dart';
import 'background_painter_data.dart';

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
