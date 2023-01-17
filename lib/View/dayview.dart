import 'package:emotionscalendar/Controller/controller.dart';
import 'package:emotionscalendar/db/datedao.dart';

import 'package:flutter/material.dart';

import '../Model/emotion.dart';

class DayView extends StatefulWidget {
  final DateDao date;
  final double calendarHeight;
  late Color emotionColor;
  final Color dotsColor;

  DayView(this.date, this.calendarHeight, this.dotsColor, {Key? key})
      : super(key: key) {
    switch (date.getEmotion()) {
      case "HAPPY":
        emotionColor = Colors.teal;
        break;
      case "CRYING":
        emotionColor = const Color.fromARGB(255, 71, 92, 255);
        break;
      case "CALM":
        emotionColor = Colors.yellow.shade200;
        break;
      case "LOVED":
        emotionColor = Colors.redAccent.shade400;

        break;
      case "ANGRY":
        emotionColor = Color.fromARGB(255, 133, 30, 30);

        break;
      case "BAD":
        emotionColor = Colors.black45;

        break;
      case "UNASSIGNED":
        emotionColor = Colors.grey.shade400;
        // TODO: Handle this case.
        break;
      default:
        break;
    }
  }

  @override
  State<DayView> createState() => _DayViewState();
}

class _DayViewState extends State<DayView> {
  @override
  Widget build(BuildContext context) {
    var maxwidth = (MediaQuery.of(context).size.width);

    return CalendarController().getCurrentDate(context).getDay ==
            widget.date.getDay
        ? Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.orange.shade800, width: 3),
                color: widget.emotionColor,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 6,
                        width: 6,
                        decoration: BoxDecoration(
                            color: widget.dotsColor,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      Container(
                        height: 6,
                        width: 6,
                        decoration: BoxDecoration(
                            color: widget.dotsColor,
                            borderRadius: BorderRadius.circular(20)),
                      )
                    ],
                  ),
                  Text(widget.date.getDay().toString())
                ]))
        : Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
                color: widget.emotionColor,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 6,
                        width: 6,
                        decoration: BoxDecoration(
                            color: widget.dotsColor,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      Container(
                        height: 6,
                        width: 6,
                        decoration: BoxDecoration(
                            color: widget.dotsColor,
                            borderRadius: BorderRadius.circular(20)),
                      )
                    ],
                  ),
                  Text(widget.date.getDay().toString())
                ]));

    /*if (CalendarController().getCurrentDate(context).equals(widget.date)) {
      return GestureDetector(
        onTap: () => CalendarController().setCurrentDate(widget.date, context),
        child: Container(
          width: widget.calendarHeight * 0.3,
          height: widget.calendarHeight * 0.4,
          decoration: BoxDecoration(
            color: widget.emotionColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 10,

                offset: const Offset(0, 5), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 6,
                    width: 6,
                    decoration: BoxDecoration(
                        color: widget.dotsColor,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  Container(
                    height: 6,
                    width: 6,
                    decoration: BoxDecoration(
                        color: widget.dotsColor,
                        borderRadius: BorderRadius.circular(20)),
                  )
                ],
              ),
              Text(
                widget.date.getDay().toString(),
                style: TextStyle(
                    color: widget.dotsColor,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () => CalendarController().setCurrentDate(widget.date, context),
        child: SizedBox(
          width: widget.calendarHeight * 0.3,
          height: widget.calendarHeight * 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 6,
                    width: 6,
                    decoration: BoxDecoration(
                        color: widget.dotsColor,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  Container(
                    height: 6,
                    width: 6,
                    decoration: BoxDecoration(
                        color: widget.dotsColor,
                        borderRadius: BorderRadius.circular(20)),
                  )
                ],
              ),
              Text(
                widget.date.getDay().toString(),
                style: TextStyle(
                    color: widget.emotionColor,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
    }*/
  }
}
