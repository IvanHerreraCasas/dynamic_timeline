import 'dart:math';
import 'package:flutter/material.dart';

class FancyGanttItem extends LeafRenderObjectWidget{

  const FancyGanttItem({Key? key,
    this.color = Colors.blue,
  this.height = 3,
    this.triangleSize = 15}):super(key:key);

  final double triangleSize;
  final double height;
  final Color color;

  @override
  RenderObject createRenderObject(BuildContext context)
    => GanttEntryRenderer(color,triangleSize,height);


  @override
  void updateRenderObject(BuildContext context,covariant GanttEntryRenderer renderObject) {
    renderObject.color = color;
  }
}

class GanttEntryRenderer extends RenderBox{

  GanttEntryRenderer(this._color, this._triangleSize, this._height);

  Color _color;
  double _triangleSize;
  double _height;

  @override
  bool get sizedByParent => true;

  set color(color) {
    if(_color == color) return;
    _color=color;
    markNeedsPaint();
  }

  set triangleSize(value) {
    if(_triangleSize == value) return;
    _triangleSize=max(value,_height);
    markNeedsPaint();
  }

  set height(value) {
    if(_height == value) return;
    _height=value;
    _triangleSize=max(value,_height);
    markNeedsPaint();
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return constraints.biggest;
  }

  @override
  void paint(PaintingContext context, Offset offset){
    var paint = Paint()..color=_color..style=PaintingStyle.fill;
    final path = Path();
    path.moveTo(offset.dx+constraints.maxWidth, offset.dy);
    path.relativeLineTo(0, _triangleSize);
    path.relativeLineTo(-_triangleSize,-_triangleSize);

    path.moveTo(offset.dx+_triangleSize, offset.dy);
    path.relativeLineTo(-_triangleSize, _triangleSize);
    path.relativeLineTo(0, -_triangleSize);

    path.relativeLineTo(constraints.maxWidth, 0);
    path.relativeLineTo(0, _height);
    path.relativeLineTo(-constraints.maxWidth, 0);

    path.close();
    context.canvas.drawPath(path, paint);

  }
}


