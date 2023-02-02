import 'package:emotionscalendar/Controller/controller.dart';
import 'package:emotionscalendar/View/colors.dart';
import 'package:emotionscalendar/View/dayview.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CalendarView extends StatefulWidget {
  //MAIN VIEW OF APPLICATION
  final Color backgroundColor;
  final Color dotsColor;
  final Color monthColor;
  final double calendarMinimizedHeight;

  const CalendarView(this.backgroundColor, this.dotsColor, this.monthColor,
      this.calendarMinimizedHeight,
      {Key? key})
      : super(key: key);

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  Box? box;
  @override
  void initState() {
    super.initState();
    box = Hive.box("Dates");
  }

  Widget myGrid(
      int monthDays, int lastDays, double maxwidth, double maxheight) {
    return SizedBox(
      width: maxwidth,
      height: maxheight,
      child: ValueListenableBuilder(
        valueListenable: box!.listenable(),
        builder: (context, box, child) {
          return GridView.count(
            crossAxisCount: 7,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1 / 1,
            shrinkWrap: true,
            children: List.generate(
              monthDays,
              (index) => Center(
                child: box.get(index + lastDays + 1) != null
                    ? DayView(box.get(index + 1 + lastDays),
                        widget.calendarMinimizedHeight, widget.dotsColor)
                    : CalendarController().getCurrentDate(context).getDay() ==
                            index + 1
                        ? Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                color: const Color.fromARGB(255, 210, 227, 215),
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
                                Text(
                                  (index + 1).toString(),
                                )
                              ],
                            ),
                          )
                        : Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                color: containerColor,
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
                                    ),
                                  ],
                                ),
                                Text(
                                  (index + 1).toString(),
                                )
                              ],
                            ),
                          ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    CalendarController controller = CalendarController();
    var maxwidth = (MediaQuery.of(context).size.width);
    var maxheight = (MediaQuery.of(context).size.height);
    var expandedHeight = (MediaQuery.of(context).size.height) * 0.8;

    return Container(
        clipBehavior: Clip.hardEdge,
        width: maxwidth,
        height: maxheight * 0.42,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
        ),
        child: ListView(
          padding: const EdgeInsets.only(top: 10),
          scrollDirection: Axis.horizontal,
          children: [
            SizedBox(
              width: maxwidth * 0.05,
            ),
            Column(
              children: [
                const Center(
                    child: Text(
                  "January",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                )),
                const SizedBox(
                  height: 15,
                ),
                myGrid(31, 0, maxwidth * 0.9, maxheight * 0.35),
              ],
            ),
            SizedBox(
              width: maxwidth * 0.05,
            ),
            Column(
              children: [
                const Center(
                    child: Text(
                  "February",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                )),
                const SizedBox(
                  height: 15,
                ),
                myGrid(28, 31, maxwidth * 0.9, maxheight * 0.35),
              ],
            ),
            SizedBox(
              width: maxwidth * 0.05,
            ),
            Column(
              children: [
                const Center(
                    child: Text(
                  "March",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                )),
                const SizedBox(
                  height: 15,
                ),
                myGrid(31, 59, maxwidth * 0.9, maxheight * 0.35),
              ],
            ),
            SizedBox(
              width: maxwidth * 0.05,
            ),
            Column(
              children: [
                const Center(
                    child: Text(
                  "April",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                )),
                const SizedBox(
                  height: 15,
                ),
                myGrid(30, 90, maxwidth * 0.9, maxheight * 0.35),
              ],
            ),
            SizedBox(
              width: maxwidth * 0.05,
            ),
            Column(
              children: [
                const Center(
                    child: Text(
                  "May ",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                )),
                const SizedBox(
                  height: 15,
                ),
                myGrid(31, 120, maxwidth * 0.9, maxheight * 0.35),
              ],
            ),
            SizedBox(
              width: maxwidth * 0.05,
            ),
            Column(
              children: [
                const Center(
                    child: Text(
                  "June",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                )),
                const SizedBox(
                  height: 15,
                ),
                myGrid(30, 151, maxwidth * 0.9, maxheight * 0.35),
              ],
            ),
            SizedBox(
              width: maxwidth * 0.05,
            ),
            Column(
              children: [
                const Center(
                    child: Text(
                  "July",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                )),
                const SizedBox(
                  height: 15,
                ),
                myGrid(31, 181, maxwidth * 0.9, maxheight * 0.35),
              ],
            ),
            SizedBox(
              width: maxwidth * 0.05,
            ),
            Column(
              children: [
                const Center(
                    child: Text(
                  "August",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                )),
                const SizedBox(
                  height: 15,
                ),
                myGrid(31, 212, maxwidth * 0.9, maxheight * 0.35),
              ],
            ),
            SizedBox(
              width: maxwidth * 0.05,
            ),
            Column(
              children: [
                const Center(
                    child: Text(
                  "September",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                )),
                const SizedBox(
                  height: 15,
                ),
                myGrid(30, 243, maxwidth * 0.9, maxheight * 0.35),
              ],
            ),
            SizedBox(
              width: maxwidth * 0.05,
            ),
            Column(
              children: [
                const Center(
                    child: Text(
                  "October",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                )),
                const SizedBox(
                  height: 15,
                ),
                myGrid(31, 273, maxwidth * 0.9, maxheight * 0.35),
              ],
            ),
            SizedBox(
              width: maxwidth * 0.05,
            ),
            Column(
              children: [
                const Center(
                    child: Text(
                  "November",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                )),
                const SizedBox(
                  height: 15,
                ),
                myGrid(30, 304, maxwidth * 0.9, maxheight * 0.35),
              ],
            ),
            SizedBox(
              width: maxwidth * 0.05,
            ),
            Column(
              children: [
                const Center(
                    child: Text(
                  "December",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                )),
                const SizedBox(
                  height: 15,
                ),
                myGrid(31, 334, maxwidth * 0.9, maxheight * 0.35),
              ],
            ),
            SizedBox(
              width: maxwidth * 0.05,
            ),
          ],
        ));
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
