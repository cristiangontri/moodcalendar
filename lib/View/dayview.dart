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
        emoji = Emotion.happy.getEmoji();
        break;
      case "CRYING":
        emotionColor = cryingColor;
        emoji = Emotion.crying.getEmoji();
        break;
      case "CALM":
        emotionColor = calmColor;
        emoji = Emotion.calm.getEmoji();
        break;
      case "LOVED":
        emotionColor = lovedColor;
        emoji = Emotion.loved.getEmoji();

        break;
      case "ANGRY":
        emotionColor = angryColor;
        emoji = Emotion.angry.getEmoji();

        break;
      case "BAD":
        emotionColor = badColor;
        emoji = Emotion.bad.getEmoji();

        break;
      case "SICK":
        emotionColor = sickColor;
        emoji = Emotion.sick.getEmoji();
        break;
      case "UNASSIGNED":
        emotionColor = unasignedColor;
        emoji = "";
        break;
      case "DEVIL":
        emotionColor = devilColor;
        emoji = Emotion.devil.getEmoji();

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
                                        child: myContainer(happyColor,
                                            Emotion.happy.getEmoji()),
                                      ),
                                      PopupMenuItem(
                                          onTap: () => CalendarController()
                                              .changeEmotion(
                                                  Emotion.calm, context),
                                          value: Emotion.calm,
                                          child: myContainer(calmColor,
                                              Emotion.calm.getEmoji())),
                                      PopupMenuItem(
                                          onTap: () => CalendarController()
                                              .changeEmotion(
                                                  Emotion.crying, context),
                                          value: Emotion.crying,
                                          child: myContainer(cryingColor,
                                              Emotion.crying.getEmoji())),
                                      PopupMenuItem(
                                          onTap: () => CalendarController()
                                              .changeEmotion(
                                                  Emotion.angry, context),
                                          value: Emotion.angry,
                                          child: myContainer(angryColor,
                                              Emotion.angry.getEmoji())),
                                      PopupMenuItem(
                                          onTap: () => CalendarController()
                                              .changeEmotion(
                                                  Emotion.bad, context),
                                          value: Emotion.bad,
                                          child: myContainer(badColor,
                                              Emotion.bad.getEmoji())),
                                      PopupMenuItem(
                                          onTap: () => CalendarController()
                                              .changeEmotion(
                                                  Emotion.loved, context),
                                          value: Emotion.loved,
                                          child: myContainer(lovedColor,
                                              Emotion.loved.getEmoji())),
                                      PopupMenuItem(
                                          onTap: () => CalendarController()
                                              .changeEmotion(
                                                  Emotion.sick, context),
                                          value: Emotion.sick,
                                          child: myContainer(sickColor,
                                              Emotion.sick.getEmoji())),
                                      PopupMenuItem(
                                          onTap: () => CalendarController()
                                              .changeEmotion(
                                                  Emotion.devil, context),
                                          value: Emotion.devil,
                                          child: myContainer(devilColor,
                                              Emotion.devil.getEmoji()))
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
                          height: widget.date.getNote().length < 25 ? 60 : 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.teal, width: 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: AlignmentDirectional.center,
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
            child: widget.date.getEmotion() != Emotion.unassigned.getName()
                ? Stack(
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
                                border:
                                    Border.all(color: Colors.white, width: 4),
                                color: widget.emotionColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                      style: GoogleFonts.aboreto(
                                        textStyle: TextStyle(
                                            color: widget.emotionColor ==
                                                        badColor ||
                                                    widget.emotionColor ==
                                                        angryColor
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 0.1,
                              blurRadius: 0.7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Text(
                          widget.emoji,
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  )
                : Stack(
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
                                  border:
                                      Border.all(color: Colors.teal, width: 4),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                      ]))
        :
        //IF IT'S NOT THE CURRENT DATE:
        GestureDetector(
            onTapDown: getPosition,
            onLongPress: () => showMenu(
                    context: context,
                    position: relRectSize,
                    color: const Color.fromARGB(255, 229, 245, 234),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: widget.emotionColor, width: 2),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20.0),
                        )),
                    items: [
                      PopupMenuItem(
                          padding: const EdgeInsets.all(15),
                          child: Container(
                            width: 250,
                            height: widget.date.getNote().length < 25
                                ? 40
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
                              padding: const EdgeInsets.only(
                                  top: 10, left: 5, right: 5),
                              child: ListView(children: [
                                Text(
                                  widget.date.getNote() != ""
                                      ? widget.date.getNote()
                                      : "No notes this day :(",
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
            child: widget.date.getEmotion() != Emotion.unassigned.getName()
                ? Stack(
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
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  color: widget.emotionColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 0.1,
                                blurRadius: 0.7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Text(
                            widget.emoji,
                            textAlign: TextAlign.center,
                          ),
                        )
                      ])
                : Stack(
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
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  color: containerColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                      ]));
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
          emoji != Emotion.devil.getEmoji()
              ? Container(
                  width: 22,
                  height: 22,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  alignment: Alignment.center,
                  child: Center(
                    child: Text(
                      emoji,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                )
              : Text(emoji, style: const TextStyle(fontSize: 18)),
        ]));
  }
}
