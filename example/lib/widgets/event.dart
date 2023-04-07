import 'package:flutter/material.dart';

class Event extends StatelessWidget {
  const Event({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(5),child: Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        borderRadius: BorderRadius.circular(0),
        border: Border.all(color: Colors.black),
        boxShadow: [BoxShadow(color: Colors.black,blurRadius: 3,offset: Offset(2,2))]
      ),
      child: Text(title),
    ),);
  }
}
