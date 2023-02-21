import 'package:emotionscalendar/View/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCard extends StatefulWidget {
  double height;
  double width;
  String img;
  bool hasDescription;
  String? description;
  bool end;
  TextEditingController? myTextController;
  MyCard(this.height, this.width, this.img, this.hasDescription,
      this.description, this.end, this.myTextController,
      {Key? key})
      : super(key: key);

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          color: containerColor,
          borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: !widget.hasDescription
            ? Image.asset(widget.img)
            : !widget.end
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Image.asset(
                        widget.img,
                        height: widget.height * 0.8,
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.all(10),
                        height: widget.height * 0.2,
                        width: widget.width,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 3),
                            color: Colors.teal,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25))),
                        child: Center(
                          child: Text(
                            widget.description!,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.aboreto(
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      )
                    ],
                  )
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 10, right: 10),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          maxLength: 15,
                          controller: widget.myTextController,
                          style: GoogleFonts.aboreto(
                              textStyle: const TextStyle(
                                  color: Colors.teal, fontSize: 30)),
                          decoration: InputDecoration(
                              labelText: "Your Name Please",
                              labelStyle: const TextStyle(color: Colors.teal),
                              floatingLabelStyle: const TextStyle(
                                  color: Colors.teal,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                              focusColor: myBackgroundColor,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.teal, width: 2),
                                  borderRadius: BorderRadius.circular(15)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 5),
                                  borderRadius: BorderRadius.circular(15)),
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                      ),
                      const Spacer(),
                      Image.asset(widget.img),
                      const Spacer(
                        flex: 2,
                      )
                    ],
                  ),
      ),
    );
  }
}
