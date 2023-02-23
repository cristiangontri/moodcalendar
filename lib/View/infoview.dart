import 'package:emotionscalendar/Controller/controller.dart';
import 'package:emotionscalendar/View/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class InfoView extends StatefulWidget {
  final TextEditingController myEditingController = TextEditingController();
  InfoView({Key? key}) : super(key: key);

  @override
  State<InfoView> createState() => _InfoViewState();
}

class _InfoViewState extends State<InfoView> {
  bool changedTime = false;
  @override
  Widget build(BuildContext context) {
    var maxheight = (MediaQuery.of(context).size.height);
    var maxwidth = (MediaQuery.of(context).size.width);

    SettingsController sc = SettingsController();
    String notificationTime = sc.getCurrentNotificationTime(context);
    String userName = sc.getUserName(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: myBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Configuration",
            style: GoogleFonts.aboreto(
                textStyle: const TextStyle(
                    fontWeight: FontWeight.bold, letterSpacing: 1)),
          ),
          backgroundColor: myBackgroundColor,
          bottom: const TabBar(
              unselectedLabelColor: containerColor,
              indicatorColor: Colors.transparent,
              tabs: [
                Tab(
                  icon: Icon(Icons.settings),
                  text: "Settings",
                ),
                Tab(
                  icon: Icon(Icons.person_2_rounded),
                  text: "Author",
                )
              ]),
        ),
        body: TabBarView(children: [
          //SETTINGS
          Container(
            height: maxheight,
            width: maxwidth,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(25)),
            ),
            child: ListView(
              padding: const EdgeInsets.all(25.0),
              children: [
                Text(
                  "USERNAME:",
                  style: GoogleFonts.aboreto(
                      textStyle: const TextStyle(
                          fontSize: 22,
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1)),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: maxwidth * 0.7,
                      child: TextFormField(
                        textAlign: TextAlign.start,
                        maxLength: 15,
                        controller: widget.myEditingController,
                        style: GoogleFonts.aboreto(
                            textStyle: const TextStyle(
                                color: Colors.teal, fontSize: 25)),
                        decoration: InputDecoration(
                            counterText: '',
                            labelText: sc.getUserName(context),
                            labelStyle: const TextStyle(color: Colors.teal),
                            floatingLabelStyle: const TextStyle(
                                color: Colors.teal,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                            focusColor: myBackgroundColor,
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: myBackgroundColor, width: 2),
                                borderRadius: BorderRadius.circular(15)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.teal, width: 3),
                                borderRadius: BorderRadius.circular(15)),
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(15))),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: maxwidth * 0.14,
                      height: maxwidth * 0.14,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: myBackgroundColor, width: 2),
                        color: widget.myEditingController.text.isNotEmpty
                            ? Colors.teal
                            : containerColor,
                      ),
                      child: TextButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.transparent)),
                          onPressed: widget.myEditingController.text.isNotEmpty
                              ? () {
                                  sc.changeUserName(
                                      context, widget.myEditingController.text);
                                  widget.myEditingController.text = "";
                                }
                              : null,
                          child: const Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 100,
                ),
                Text(
                  "NOTIFICATIONS:",
                  style: GoogleFonts.aboreto(
                      textStyle: const TextStyle(
                          fontSize: 22,
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1)),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: maxwidth * 0.7,
                      child: OutlinedButton(
                          onPressed: () async {
                            var newTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay(
                                  hour:
                                      int.parse(notificationTime.split(":")[0]),
                                  minute:
                                      int.parse(notificationTime.split(":")[1]),
                                ),
                                initialEntryMode: TimePickerEntryMode.dialOnly);
                            if (newTime != null) {
                              sc.changeTime(context,
                                  "${newTime.hour.toString().padLeft(2, '0')}:${newTime.minute.toString().padLeft(2, '0')}");
                              setState(() {
                                changedTime = true;
                              });
                            }
                          },
                          style: OutlinedButton.styleFrom(
                              alignment: Alignment.centerLeft,
                              side: const BorderSide(
                                  width: 2.0, color: myBackgroundColor),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)))),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 18.0, bottom: 18.0),
                            child: Text(notificationTime,
                                style: GoogleFonts.aboreto(
                                    textStyle: const TextStyle(
                                        fontSize: 25,
                                        color: myBackgroundColor,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1))),
                          )),
                    ),
                    const Spacer(),
                    Container(
                      width: maxwidth * 0.14,
                      height: maxwidth * 0.14,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: myBackgroundColor, width: 2),
                        color: changedTime ? Colors.teal : containerColor,
                      ),
                      child: TextButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.transparent)),
                          onPressed: changedTime
                              ? () {
                                  sc.changeNotification(context);
                                  setState(() {
                                    changedTime = false;
                                  });
                                }
                              : null,
                          child: const Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
          //AUTHOR
          Container(
            width: maxwidth,
            height: maxheight,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(25)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: maxheight * 0.77,
                    child: Stack(children: [
                      Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            ListView(
                              //TEXT IS CONTAINED IN THIS LISTVIEW ALLOWING THE USER TO SCROLL.

                              children: [
                                SizedBox(
                                  height: maxheight * 0.23,
                                ),
                                SizedBox(
                                  width: maxwidth,
                                  child: const Text(
                                    " Note from the author:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: Colors.teal),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                RichText(
                                  textAlign: TextAlign.justify,
                                  text: const TextSpan(
                                      style: TextStyle(
                                          color: textColor,
                                          fontSize: 18,
                                          height: 1.8),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                "Thank you very much for trying MOOD. This is a"),
                                        TextSpan(
                                            text: " NON PROFIT PROJECT.",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text:
                                                " The purpose of it is to make it easier for people "
                                                "to detect issues related to mental health by monitoring their mood.")
                                      ]),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: maxwidth,
                                  child: const Text(
                                    " The Author:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: Colors.teal),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                RichText(
                                  textAlign: TextAlign.justify,
                                  text: const TextSpan(
                                      style: TextStyle(
                                          color: textColor,
                                          fontSize: 18,
                                          height: 1.8),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                "Nice to meet you! I am a software engineer student "),
                                        TextSpan(
                                            text: "(at the moment)",
                                            style: TextStyle(
                                                color: containerColor)),
                                        TextSpan(
                                            text:
                                                " based in A Coruña, a small city in north-west Spain.")
                                      ]),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                RichText(
                                  textAlign: TextAlign.justify,
                                  text: const TextSpan(
                                      style: TextStyle(
                                          color: textColor,
                                          fontSize: 18,
                                          height: 1.8),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                "I am currently creating my portfolio and MOOD. is actually my first ever project."),
                                        TextSpan(
                                            text:
                                                "I hope you are enjoying my app and that most of your days are HappyDays!"),
                                      ]),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                RichText(
                                  textAlign: TextAlign.justify,
                                  text: const TextSpan(
                                      style: TextStyle(
                                          color: textColor,
                                          fontSize: 18,
                                          height: 1.8),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                "As I mentioned before, I am not aiming to make money with this project, "),
                                        TextSpan(
                                            text:
                                                "but, if you want to contribute to my future projects, theres a button down this paragraph "
                                                "that will allow you to donate the amount of money you want."),
                                      ]),
                                ),
                                SizedBox(
                                  height: maxheight * 0.15,
                                )
                              ],
                            ),
                            Container(
                                height: maxheight * 0.1,
                                width: maxwidth,
                                clipBehavior: Clip.hardEdge,
                                decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        myBackgroundColor,
                                        Colors.teal,
                                        Colors.teal,
                                        myBackgroundColor,
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.white,
                                          blurRadius: 100.0,
                                          spreadRadius: 30),
                                    ],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25),
                                    )),
                                child: TextButton(
                                  onPressed: () {},
                                  style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.transparent)),
                                  child: const Text(
                                    "Buy me a Coffee",
                                    style: TextStyle(
                                        fontSize: 22, color: Colors.white),
                                  ),
                                ))
                          ]),
                      Container(
                        height: maxheight * 0.10,
                        color: Colors.white,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        height: maxheight * 0.22,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: containerColor, width: 2),
                            borderRadius: BorderRadius.circular(25)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const CircleAvatar(
                                radius: 75,
                                backgroundImage: AssetImage(
                                  "assets/myFace.png",
                                )),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "CRISTIAN",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.teal),
                                ),
                                Text(
                                  "GONZÁLEZ TRILLO",
                                  style:
                                      TextStyle(fontSize: 20, color: textColor),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  //HIDES SCROLL GLOW
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
