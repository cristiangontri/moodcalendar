import 'package:emotionscalendar/main.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'colors.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  List<String> images = ["assets/moodTitle2.png", "assets/moodTutorial.png"];
  TextEditingController myTextController = TextEditingController();
  bool chosen = false;
  @override
  Widget build(BuildContext context) {
    var maxheight = (MediaQuery.of(context).size.height);
    var maxwidth = (MediaQuery.of(context).size.width);

    return Scaffold(
        backgroundColor: myBackgroundColor,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Center(
                  child: SizedBox(
                    height: maxheight * 0.41,
                    child: PageView.builder(
                        itemCount: images.length,
                        pageSnapping: true,
                        itemBuilder: (context, pagePosition) {
                          return SizedBox(
                              height: maxheight * 0.4,
                              child: Image.asset(images[pagePosition]));
                        }),
                  ),
                ),
                Center(
                  child: Row(
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        decoration: const BoxDecoration(
                            color: Colors.teal,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      )
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLength: 15,
                    controller: myTextController,
                    style: const TextStyle(color: myBackgroundColor),
                    decoration: InputDecoration(
                        labelText: "Your Name Please",
                        labelStyle: const TextStyle(color: Colors.white),
                        floatingLabelStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                        filled: true,
                        fillColor: containerColor,
                        focusColor: myBackgroundColor,
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(15)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.teal, width: 3),
                            borderRadius: BorderRadius.circular(15)),
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
                Container(
                  width: maxwidth * 0.8,
                  clipBehavior: Clip.hardEdge,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(50)),
                  child: ElevatedButton(
                    onPressed: myTextController.text.isNotEmpty
                        ? () {
                            Box userBox = Hive.box("User");
                            userBox.add(myTextController.text);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Home()),
                            );
                          }
                        : null,
                    child: const Text("DONE!"),
                  ),
                ),
                const Spacer(
                  flex: 3,
                ),
              ],
            ),
          ),
        ));
  }
}
