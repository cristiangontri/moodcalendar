import 'package:emotionscalendar/Controller/controller.dart';
import 'package:emotionscalendar/View/colors.dart';
import 'package:emotionscalendar/View/managedate.dart';
import 'package:emotionscalendar/db/datedao.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Model/emotion.dart';

class DayView extends StatefulWidget {
  final DateDao date;
  final double calendarHeight;
  Color emotionColor = Colors.grey.shade400;
  final Color dotsColor;
  String emoji = "";

  DayView(this.date, this.calendarHeight, this.dotsColor, {Key? key})
      : super(key: key) {
    switch (date.getEmotion()) {
      case "HAPPY":
        emotionColor = happyColor;
        emoji = "😊";
        break;
      case "CRYING":
        emotionColor = cryingColor;
        emoji = "😭";
        break;
      case "CALM":
        emotionColor = calmColor;
        emoji = "😴";
        break;
      case "LOVED":
        emotionColor = lovedColor;
        emoji = "🥰";

        break;
      case "ANGRY":
        emotionColor = angryColor;
        emoji = "😡";

        break;
      case "BAD":
        emotionColor = badColor;
        emoji = "😞";

        break;
      case "SICK":
        emotionColor = sickColor;
        emoji = "🤒";
        break;
      case "UNASSIGNED":
        emotionColor = unasignedColor;
        emoji = "😐";

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
    overlay = Overlay.of(context).context.findRenderObject()! as RenderBox;

    return CalendarController()
            .getCurrentDate(context)
            .isequal(widget.date) //IF IT'S THE CURRENT DATE:
        ? GestureDetector(
            onTapDown: getPosition,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ManageDate(widget.date)),
              );
            },
            onLongPress: () => showMenu(
                    context: context,
                    position: relRectSize,
                    color: const Color.fromARGB(255, 229, 245, 234),
                    shape: const RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        )),
                    items: [
                      PopupMenuItem(
                          height: 150,
                          child: Center(
                            child: SizedBox(
                              height: 110,
                              width: 250,
                              child: Center(
                                child: GridView.count(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    crossAxisCount: 4,
                                    crossAxisSpacing: 0,
                                    mainAxisSpacing: 0,
                                    children: [
                                      PopupMenuItem(
                                        onTap: () => CalendarController()
                                            .changeEmotion(
                                                Emotion.happy, context),
                                        value: Emotion.happy,
                                        child: myContainer(happyColor, "😊"),
                                      ),
                                      PopupMenuItem(
                                          onTap: () => CalendarController()
                                              .changeEmotion(
                                                  Emotion.calm, context),
                                          value: Emotion.calm,
                                          child: myContainer(calmColor, "😴")),
                                      PopupMenuItem(
                                          onTap: () => CalendarController()
                                              .changeEmotion(
                                                  Emotion.crying, context),
                                          value: Emotion.crying,
                                          child:
                                              myContainer(cryingColor, "😭")),
                                      PopupMenuItem(
                                          onTap: () => CalendarController()
                                              .changeEmotion(
                                                  Emotion.angry, context),
                                          value: Emotion.angry,
                                          child: myContainer(angryColor, "😡")),
                                      PopupMenuItem(
                                          onTap: () => CalendarController()
                                              .changeEmotion(
                                                  Emotion.bad, context),
                                          value: Emotion.bad,
                                          child: myContainer(badColor, "😞")),
                                      PopupMenuItem(
                                          onTap: () => CalendarController()
                                              .changeEmotion(
                                                  Emotion.loved, context),
                                          value: Emotion.loved,
                                          child: myContainer(lovedColor, "🥰")),
                                      PopupMenuItem(
                                          onTap: () => CalendarController()
                                              .changeEmotion(
                                                  Emotion.sick, context),
                                          value: Emotion.sick,
                                          child: myContainer(sickColor, "🤒")),
                                      PopupMenuItem(
                                          onTap: () => CalendarController()
                                              .changeEmotion(
                                                  Emotion.unassigned, context),
                                          value: Emotion.unassigned,
                                          child:
                                              myContainer(unasignedColor, "😐"))
                                    ]),
                              ),
                            ),
                          )),
                      PopupMenuItem(
                          child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ManageDate(widget.date)),
                          );
                        },
                        child: Container(
                          width: 250,
                          height: widget.date.getNote().length < 25
                              ? 60
                              : widget.date.getNote().length < 100
                                  ? 100
                                  : 200,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.teal, width: 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: Alignment.center,
                          child: ListView(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 5, right: 5),
                              children: [
                                Text(
                                  widget.date.getNote() != ""
                                      ? widget.date.getNote()
                                      : "No notes... (Press here to add a note).",
                                  textAlign: widget.date.getNote().length < 25
                                      ? TextAlign.center
                                      : TextAlign.center,
                                  style: GoogleFonts.aboreto(
                                      textStyle: const TextStyle(
                                    color: Colors.teal,
                                    fontWeight: FontWeight.bold,
                                  )),
                                ),
                              ]),
                        ),
                      ))
                    ]),
            child: Stack(
              alignment: Alignment.topRight,
              fit: StackFit.loose,
              children: [
                const SizedBox(
                  height: 45,
                  width: 45,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5, top: 5),
                  child: AnimatedContainer(
                      //ANIMATE COLOR CHANGE ON CURRENT DATE.
                      duration: const Duration(milliseconds: 800),
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
                            Text(widget.date.getDay().toString(),
                                style: GoogleFonts.aboreto(
                                  textStyle: TextStyle(
                                      color: widget.emotionColor == badColor ||
                                              widget.emotionColor == angryColor
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.bold),
                                )),
                          ])),
                ),
                Container(
                  height: 18,
                  width: 18,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 0.1,
                        blurRadius: 0.7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Text(
                    widget.emoji,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ))
        :
        //IF IT'S NOT THE CURRENT DATE:
        GestureDetector(
            onTapDown: getPosition,
            onLongPress: () => showMenu(
                context: context,
                position: relRectSize,
                color: const Color.fromARGB(255, 229, 245, 234),
                shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    )),
                items: [
                  PopupMenuItem(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        width: 250,
                        height: widget.date.getNote() == ""
                            ? 0
                            : widget.date.getNote().length < 25
                                ? 30
                                : widget.date.getNote().length < 100
                                    ? 100
                                    : 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.teal, width: 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.center,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 10, left: 5, right: 5),
                          child: ListView(children: [
                            Text(
                              widget.date.getNote() != ""
                                  ? widget.date.getNote()
                                  : "",
                              textAlign: widget.date.getNote().length < 25
                                  ? TextAlign.center
                                  : TextAlign.start,
                              style: GoogleFonts.aboreto(
                                  textStyle: const TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold,
                              )),
                            ),
                          ]),
                        ),
                      ))
                ]),
            child: Stack(
                alignment: Alignment.topRight,
                fit: StackFit.loose,
                children: [
                  const SizedBox(
                    height: 45,
                    width: 45,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5, top: 5),
                    child: Container(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: 6,
                                    width: 6,
                                    decoration: BoxDecoration(
                                        color: widget.dotsColor,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                  Container(
                                    height: 6,
                                    width: 6,
                                    decoration: BoxDecoration(
                                        color: widget.dotsColor,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  )
                                ],
                              ),
                              Text(widget.date.getDay().toString(),
                                  style: GoogleFonts.aboreto())
                            ])),
                  ),
                  Container(
                    height: 18,
                    width: 18,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 0.1,
                          blurRadius: 0.7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Text(
                      widget.emoji,
                      textAlign: TextAlign.center,
                    ),
                  )
                ]),
          );
  }

  RelativeRect get relRectSize =>
      RelativeRect.fromSize(tapXY & const Size(40, 40), overlay.size);

  // ↓ get the tap position Offset
  void getPosition(TapDownDetails detail) {
    tapXY = detail.globalPosition;
  }

  Widget myContainer(Color bg, String emoji) {
    //CUSTOM APPBAR / BANNER:
    return Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            color: bg,
            borderRadius: BorderRadius.circular(10)),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 18),
          )
        ]));
  }
}
