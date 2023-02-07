import 'package:emotionscalendar/View/colors.dart';
import 'package:flutter/material.dart';

class MyCard extends StatefulWidget {
  double height;
  double width;
  MyCard(this.height, this.width, {Key? key}) : super(key: key);

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          color: containerColor,
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
