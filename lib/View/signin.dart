import 'package:emotionscalendar/View/cardview.dart';
import 'package:emotionscalendar/View/mainpage.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import 'colors.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  List<String> images = [
    "assets/moodTitle2.png",
    "assets/moodTutorial2.png",
    "assets/DragDown.png",
    "assets/Welcome.png",
  ];
  String descMoodTutorial =
      "Longpress on the current date in order to stablish how you felt that day.";
  String descDragDownTutorial =
      "Drag down on the main page to see the statistics of your emotions. ";
  TextEditingController myTextController = TextEditingController();
  int chosen = 0;
  @override
  Widget build(BuildContext context) {
    var maxheight = (MediaQuery.of(context).size.height);
    var maxwidth = (MediaQuery.of(context).size.width);
    List<String> descriptions = [
      "",
      descMoodTutorial,
      descDragDownTutorial,
      ""
    ];
    return Scaffold(
        backgroundColor: myBackgroundColor,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Center(
            child:
                Stack(alignment: AlignmentDirectional.bottomCenter, children: [
              SizedBox(
                height: maxheight,
                width: maxwidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: SizedBox(
                        height: maxheight * 0.8,
                        child: PageView.builder(
                            onPageChanged: (value) {
                              setState(() {
                                chosen = value;
                              });
                            },
                            itemCount: images.length,
                            pageSnapping: true,
                            itemBuilder: (context, pagePosition) {
                              return Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: pagePosition == 0
                                    ? MyCard(
                                        maxheight * 0.7,
                                        maxwidth * 0.95,
                                        images[pagePosition],
                                        false,
                                        null,
                                        false,
                                        null)
                                    : pagePosition != images.length - 1
                                        ? MyCard(
                                            maxheight * 0.7,
                                            maxwidth * 0.95,
                                            images[pagePosition],
                                            true,
                                            descriptions[pagePosition],
                                            false,
                                            null)
                                        : MyCard(
                                            maxheight * 0.7,
                                            maxwidth * 0.95,
                                            images[pagePosition],
                                            true,
                                            null,
                                            true,
                                            myTextController),
                              );
                            }),
                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                color: (chosen == 0)
                                    ? Colors.teal
                                    : const Color.fromARGB(108, 0, 92, 82),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15))),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                color: (chosen == 1)
                                    ? Colors.teal
                                    : const Color.fromARGB(108, 0, 92, 82),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15))),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                color: (chosen == 2)
                                    ? Colors.teal
                                    : const Color.fromARGB(108, 0, 92, 82),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15))),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                color: (chosen == 3)
                                    ? Colors.teal
                                    : const Color.fromARGB(108, 0, 92, 82),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15))),
                          )
                        ],
                      ),
                    ),

                    /**/
                    const Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: maxwidth * 0.95,
                  height: maxheight * 0.1,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.white, width: 1.5),
                    color:
                        myTextController.text.isNotEmpty ? Colors.teal : null,
                  ),
                  child: TextButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.transparent)),
                    onPressed: myTextController.text.isNotEmpty
                        ? () {
                            Box userBox = Hive.box("User");
                            userBox.put(0, myTextController.text);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainPage()),
                            );
                          }
                        : null,
                    child: Text(
                      "DONE!",
                      style: GoogleFonts.aboreto(
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ));
  }
}
