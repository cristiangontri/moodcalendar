import 'package:emotionscalendar/Model/month.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthView extends StatefulWidget {
  final Month month;
  final Color monthColor;
  const MonthView(this.month, this.monthColor, {Key? key}) : super(key: key);

  @override
  State<MonthView> createState() => _MonthViewState();
}

class _MonthViewState extends State<MonthView> {
  @override
  Widget build(BuildContext context) {
    return widget.month.isSelected()
        ? Text(
            widget.month.getMonthName(),
            style: TextStyle(
                color: widget.monthColor,
                fontWeight: FontWeight.bold,
                fontSize: 25),
          )
        : Text(
            widget.month.getMonthName(),
            style: TextStyle(color: widget.monthColor, fontSize: 20),
          );
  }
}
