import 'package:emotionscalendar/Model/day.dart';
import 'package:emotionscalendar/Model/month.dart';
import 'package:emotionscalendar/Model/year.dart';
import 'package:emotionscalendar/View/colors.dart';
import 'package:emotionscalendar/View/dayview.dart';
import 'package:emotionscalendar/View/monthview.dart';
import 'package:emotionscalendar/View/yearview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Model/calendar.dart';

class CalendarView extends StatefulWidget {
  final Color backgroundColor;
  final Color dotsColor;
  final Color monthColor;
  final double calendarHeight;
  const CalendarView(this.backgroundColor, this.dotsColor, this.monthColor,
      this.calendarHeight,
      {Key? key})
      : super(key: key);

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  @override
  Widget build(BuildContext context) {
    var maxwidth = (MediaQuery.of(context).size.width);
    ScrollController _scrollController =
        ScrollController(initialScrollOffset: 13, keepScrollOffset: true);
    return Container(
      width: maxwidth,
      height: widget.calendarHeight,
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 49, 44, 70),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12))),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Padding(
            padding: EdgeInsets.only(top: 8.0, left: 8.0),
            child: Text(
              "Calendar",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: maxwidth,
            height: 50,
            child: ListView.separated(
                controller: _scrollController,
                separatorBuilder: (context, index) => const SizedBox(
                      width: 10,
                    ),
                scrollDirection: Axis.horizontal,
                itemCount:
                    Provider.of<Calendar>(context).getPrintableListYaM().length,
                itemBuilder: (context, index) {
                  List<Object> printable =
                      Provider.of<Calendar>(context).getPrintableListYaM();
                  if (printable[index] is Month) {
                    return Center(
                        child: MonthView(
                            printable[index] as Month, widget.monthColor));
                  } else {
                    Year yr = printable[index] as Year;
                    return Center(child: YearView(yr, widget.monthColor));
                  }
                }),
          ),
          SizedBox(
            width: maxwidth,
            height: widget.calendarHeight * 0.5,
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: Provider.of<Calendar>(context)
                  .getCurrentMonth()
                  .getNumberOfDays(),
              itemBuilder: (context, index) {
                List<Day> days =
                    Provider.of<Calendar>(context).getCurrentMonth().getDays();
                return Center(
                  child: DayView(
                      days[index], widget.calendarHeight, widget.dotsColor),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
