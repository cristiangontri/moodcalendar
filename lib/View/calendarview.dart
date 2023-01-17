import 'package:emotionscalendar/Controller/controller.dart';
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
    // TODO: implement initState
    super.initState();
    box = Hive.box("Dates");
  }

  @override
  Widget build(BuildContext context) {
    CalendarController controller = CalendarController();
    var maxwidth = (MediaQuery.of(context).size.width);
    var maxheight = (MediaQuery.of(context).size.height);
    var expandedHeight = (MediaQuery.of(context).size.height) * 0.8;

    ScrollController scrollController =
        ScrollController(initialScrollOffset: 0, keepScrollOffset: true);

    return Container(
      clipBehavior: Clip.hardEdge,
      width: maxwidth,
      height: maxheight,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 49, 44, 70),
        /*borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12))*/
      ),
      child: Center(
        child: SizedBox(
          width: maxwidth * 0.9,
          height: maxheight * 0.9,
          child: ValueListenableBuilder(
            valueListenable: box!.listenable(),
            builder: (context, box, child) {
              return ScrollConfiguration(
                behavior: MyBehavior(),
                child: GridView.count(
                  crossAxisCount: 7,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  childAspectRatio: 1 / 1,
                  shrinkWrap: true,
                  children: List.generate(
                    365,
                    (index) => Center(
                      child: box.get(index + 1) != null
                          ? DayView(box.get(index + 1),
                              widget.calendarMinimizedHeight, widget.dotsColor)
                          : CalendarController()
                                      .getCurrentDate(context)
                                      .getDay() ==
                                  index + 1
                              ? Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.green),
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
                                      Text((index + 1).toString())
                                    ],
                                  ),
                                )
                              : Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
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
                                          ),
                                        ],
                                      ),
                                      Text((index + 1).toString())
                                    ],
                                  ),
                                ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
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
