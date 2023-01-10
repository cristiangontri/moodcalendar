import 'package:emotionscalendar/Model/month.dart';
import 'package:flutter/material.dart';

class MonthView extends StatefulWidget {
  Month month;
  Color monthColor;
  MonthView(this.month, this.monthColor, {Key? key}) : super(key: key);

  @override
  State<MonthView> createState() => _MonthViewState();
}

class _MonthViewState extends State<MonthView> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.month.getMonthName(),
      style: TextStyle(color: widget.monthColor),
    );
  }
}
