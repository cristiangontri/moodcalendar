import 'package:emotionscalendar/Model/year.dart';
import 'package:flutter/material.dart';

class YearView extends StatefulWidget {
  Year year;
  Color colorYear;
  YearView(this.year, this.colorYear, {Key? key}) : super(key: key);

  @override
  State<YearView> createState() => _YearViewState();
}

class _YearViewState extends State<YearView> {
  @override
  Widget build(BuildContext context) {
    return widget.year.isSelected()
        ? Text(
            "-- " + widget.year.getYearNumber().toString() + " --",
            style: TextStyle(
                color: widget.colorYear,
                fontWeight: FontWeight.bold,
                fontSize: 25,
                fontStyle: FontStyle.italic),
          )
        : Text(
            "-- " + widget.year.getYearNumber().toString() + " --",
            style: TextStyle(
                color: widget.colorYear,
                fontSize: 15,
                fontStyle: FontStyle.italic),
          );
  }
}
