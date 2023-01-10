import 'package:emotionscalendar/Model/day.dart';
import 'package:flutter/material.dart';

import '../Model/emotion.dart';

class DayView extends StatefulWidget {
  Day day;
  double calendarHeight;
  late Color emotionColor;
  Color dotsColor;
  DayView(this.day, this.calendarHeight, this.dotsColor, {Key? key})
      : super(key: key) {
    switch (day.getEmotion()) {
      case Emotion.happy:
        emotionColor = Colors.teal;
        break;
      case Emotion.crying:
        emotionColor = Colors.indigo.shade800;
        break;
      case Emotion.calm:
        emotionColor = Colors.yellow.shade200;
        break;
      case Emotion.loved:
        emotionColor = Colors.redAccent.shade400;
        // TODO: Handle this case.
        break;
      case Emotion.angry:
        emotionColor = Colors.purple.shade900;
        // TODO: Handle this case.
        break;
      case Emotion.bad:
        emotionColor = Colors.black45;
        // TODO: Handle this case.
        break;
      case Emotion.unassigned:
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
    return Container(
      width: widget.calendarHeight * 0.08,
      height: widget.calendarHeight * 0.10,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 118, 118),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 3), // changes position of shadow
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
            widget.day.getDay().toString(),
            style: TextStyle(
                color: widget.emotionColor,
                fontSize: 35,
                fontWeight: FontWeight.bold),
          ),
          Text(
            widget.day.getWeekDay(),
            style: TextStyle(
                color: widget.emotionColor, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
