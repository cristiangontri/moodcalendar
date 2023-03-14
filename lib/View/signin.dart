import 'package:emotionscalendar/View/cardview.dart';
import 'package:emotionscalendar/View/mainpage.dart';
import 'package:emotionscalendar/main.dart';

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
    "assets/Notes.png",
    "assets/moodTutorial2.png",
    "assets/DragDown.png",
    "assets/Welcome.png",
  ];
  String descMoodTutorial = systemLocales.first.toString() == "es_ES"
      ? "Mantén pulsado en una fecha para visualizar tus notas y abrir las acciones rápidas."
      : "Longpress on a date in orther to check your notes or enable quick actions.";
  String descDragDownTutorial = systemLocales.first.toString() == "es_ES"
      ? "Arrastra hacia abajo en la página principal para ver las estadísticas de tus emociones"
      : "Drag down on the main page to see the statistics of your emotions. ";
  String descNotesTutorial = systemLocales.first.toString() == "es_ES"
      ? "Pulsa en el día actual para editar su emoción y añadir una nota"
      : "Tap on the current day to edit it's emotion and add a note.";
  TextEditingController myTextController = TextEditingController();
  int chosen = 0;
  @override
  Widget build(BuildContext context) {
    var maxheight = (MediaQuery.of(context).size.height);
    var maxwidth = (MediaQuery.of(context).size.width);
    List<String> descriptions = [
      "",
      descNotesTutorial,
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
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                border: chosen == 0
                                    ? Border.all(
                                        color: Colors.white, width: 1.5)
                                    : Border.all(
                                        color: myBackgroundColor, width: 0),
                                color: (chosen == 0)
                                    ? Colors.teal
                                    : const Color.fromARGB(108, 0, 92, 82),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15))),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                border: chosen == 1
                                    ? Border.all(
                                        color: Colors.white, width: 1.5)
                                    : Border.all(
                                        color: myBackgroundColor, width: 0),
                                color: (chosen == 1)
                                    ? Colors.teal
                                    : const Color.fromARGB(108, 0, 92, 82),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15))),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                border: chosen == 2
                                    ? Border.all(
                                        color: Colors.white, width: 1.5)
                                    : Border.all(
                                        color: myBackgroundColor, width: 0),
                                color: (chosen == 2)
                                    ? Colors.teal
                                    : const Color.fromARGB(108, 0, 92, 82),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15))),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                border: chosen == 3
                                    ? Border.all(
                                        color: Colors.white, width: 1.5)
                                    : Border.all(
                                        color: myBackgroundColor, width: 0),
                                color: (chosen == 3)
                                    ? Colors.teal
                                    : const Color.fromARGB(108, 0, 92, 82),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15))),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                border: chosen == 4
                                    ? Border.all(
                                        color: Colors.white, width: 1.5)
                                    : Border.all(
                                        color: myBackgroundColor, width: 0),
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
                      systemLocales.first.toString() == "es_ES"
                          ? "HECHO!"
                          : "DONE!",
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
