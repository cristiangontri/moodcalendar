import 'package:emotionscalendar/Controller/controller.dart';
import 'package:emotionscalendar/db/datedao.dart';

import 'package:flutter/material.dart';

import '../Model/emotion.dart';

class DayView extends StatefulWidget {
  final DateDao date;
  final double calendarHeight;
  Color emotionColor = Colors.grey.shade400;
  final Color dotsColor;

  DayView(this.date, this.calendarHeight, this.dotsColor, {Key? key})
      : super(key: key) {
    switch (date.getEmotion()) {
      case "HAPPY":
        emotionColor = Color.fromARGB(255, 160, 255, 246);
        break;
      case "CRYING":
        emotionColor = Color.fromARGB(255, 153, 165, 255);
        break;
      case "CALM":
        emotionColor = Colors.yellow.shade200;
        break;
      case "LOVED":
        emotionColor = Color.fromARGB(255, 255, 207, 217);

        break;
      case "ANGRY":
        emotionColor = Color.fromARGB(255, 129, 85, 85);

        break;
      case "BAD":
        emotionColor = Color.fromARGB(255, 34, 34, 34);

        break;
      case "SICK":
        emotionColor = Color.fromARGB(255, 243, 177, 255);
        break;
      case "UNASSIGNED":
        emotionColor = Color.fromARGB(255, 255, 255, 255);
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
  late Offset tapXY;
  // ↓ hold screen size, using first line in build() method
  late RenderBox overlay;

  @override
  Widget build(BuildContext context) {
    overlay = Overlay.of(context)!.context.findRenderObject()! as RenderBox;
    var maxwidth = (MediaQuery.of(context).size.width);
    bool popupshowing = false;

    return CalendarController().getCurrentDate(context).isequal(widget.date)
        ? GestureDetector(
            onTapDown: getPosition,
            onLongPress: () => showMenu(
                context: context,
                position: relRectSize,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                )),
                items: [
                  PopupMenuItem(
                      height: 150,
                      child: Center(
                        child: SizedBox(
                          height: 125,
                          width: 250,
                          child: Center(
                            child: GridView.count(
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisCount: 4,
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 0,
                                children: [
                                  PopupMenuItem(
                                    onTap: () => CalendarController()
                                        .changeEmotion(Emotion.happy, context),
                                    value: Emotion.happy,
                                    child: Center(child: Text("😊")),
                                  ),
                                  PopupMenuItem(
                                      onTap: () => CalendarController()
                                          .changeEmotion(Emotion.calm, context),
                                      value: Emotion.calm,
                                      child: Center(child: Text("😴"))),
                                  PopupMenuItem(
                                      onTap: () => CalendarController()
                                          .changeEmotion(
                                              Emotion.crying, context),
                                      value: Emotion.crying,
                                      child: Center(child: Text("😭"))),
                                  PopupMenuItem(
                                      onTap: () => CalendarController()
                                          .changeEmotion(
                                              Emotion.angry, context),
                                      value: Emotion.angry,
                                      child: Center(child: Text("😡"))),
                                  PopupMenuItem(
                                      onTap: () => CalendarController()
                                          .changeEmotion(Emotion.bad, context),
                                      value: Emotion.bad,
                                      child: Center(child: Text("😞"))),
                                  PopupMenuItem(
                                      onTap: () => CalendarController()
                                          .changeEmotion(
                                              Emotion.loved, context),
                                      value: Emotion.loved,
                                      child: Center(child: Text("🥰"))),
                                  PopupMenuItem(
                                      onTap: () => CalendarController()
                                          .changeEmotion(Emotion.sick, context),
                                      value: Emotion.sick,
                                      child: Center(child: Text("🤒"))),
                                  PopupMenuItem(
                                      onTap: () => CalendarController()
                                          .changeEmotion(
                                              Emotion.unassigned, context),
                                      value: Emotion.unassigned,
                                      child: Center(child: Text("😐")))
                                ]),
                          ),
                        ),
                      ))
                ]),
            child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 4),
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
                      Text(widget.date.getDay().toString()),
                    ])),
          )
        : Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
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

  RelativeRect get relRectSize =>
      RelativeRect.fromSize(tapXY & const Size(40, 40), overlay.size);

  // ↓ get the tap position Offset
  void getPosition(TapDownDetails detail) {
    tapXY = detail.globalPosition;
  }
}
