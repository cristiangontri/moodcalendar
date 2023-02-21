import 'package:emotionscalendar/Controller/controller.dart';
import 'package:emotionscalendar/Model/emotion.dart';
import 'package:emotionscalendar/db/datedao.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class ManageDate extends StatefulWidget {
  DateDao date;
  Emotion chosen = Emotion.unassigned;

  ManageDate(this.date, {Key? key}) : super(key: key) {
    chosen = EmotionExtension.parse(date.getEmotion());
  }

  @override
  State<ManageDate> createState() => _ManageDateState();
}

class _ManageDateState extends State<ManageDate> {
  var controller = CalendarController();
  TextEditingController myTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DateDao date = controller.getSelectedDate(context);
    final String year = date.getYear().toString();
    final String month = date.getMonth().toString();
    final String day = date.getDay().toString();
    var maxheight = (MediaQuery.of(context).size.height);
    var maxwidth = (MediaQuery.of(context).size.width);

    return Scaffold(
      backgroundColor: myBackgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "$day/$month/$year",
          style: GoogleFonts.aboreto(
              textStyle: const TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          )),
        ),
        backgroundColor: myBackgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
          child: Container(
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 229, 245, 234),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        height: maxheight,
        width: maxwidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            SizedBox(
                height: maxheight * 0.65,
                width: maxwidth * 0.91,
                child: TextField(
                    controller: myTextController,
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.top,
                    expands: true,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: GoogleFonts.aboreto(
                        textStyle: const TextStyle(
                            fontSize: 13,
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            height: 2)),
                    decoration: InputDecoration(
                      hintText: widget.date.getNote() == ""
                          ? "Anything to highlight about your day?"
                          : widget.date.getNote(),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: myBackgroundColor, width: 2),
                          borderRadius: BorderRadius.circular(25)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: myBackgroundColor, width: 4),
                          borderRadius: BorderRadius.circular(25)),
                      hintStyle: GoogleFonts.aboreto(
                          textStyle: const TextStyle(
                              fontSize: 13,
                              color: Colors.teal,
                              fontWeight: FontWeight.bold)),
                    ))),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                myContainer(happyColor, "😊", Emotion.happy),
                myContainer(calmColor, "😴", Emotion.calm),
                myContainer(cryingColor, "😭", Emotion.crying),
                myContainer(angryColor, "😡", Emotion.angry),
                myContainer(badColor, "😞", Emotion.bad),
                myContainer(lovedColor, "🥰", Emotion.loved),
                myContainer(sickColor, "🤒", Emotion.sick),
                myContainer(unasignedColor, "😐", Emotion.unassigned)
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: maxwidth * 0.95,
                height: maxheight * 0.1,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.white, width: 1.5),
                  color: Colors.teal,
                ),
                child: TextButton(
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.transparent)),
                  onPressed: () {
                    controller.changeEmotion(widget.chosen, context);

                    controller.addNote(context, myTextController.text);

                    Navigator.pop(context);
                  },
                  child: Text(
                    "SAVE!",
                    style: GoogleFonts.aboreto(
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget myContainer(Color bg, String emoji, Emotion e) {
    //CUSTOM APPBAR / BANNER:

    return GestureDetector(
      onTap: () {
        setState(() {
          widget.chosen = e;
        });
      },
      child: Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            border: widget.chosen != e
                ? Border.all(color: Colors.white, width: 2)
                : Border.all(color: Colors.teal, width: 4),
            color: bg,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  emoji,
                  style: const TextStyle(fontSize: 20),
                )
              ])),
    );
  }
}
