import 'package:emotionscalendar/Controller/controller.dart';
import 'package:emotionscalendar/Model/dayyearcalculator.dart';
import 'package:emotionscalendar/View/colors.dart';
import 'package:emotionscalendar/View/dayview.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CalendarView extends StatefulWidget {
  //MAIN VIEW OF APPLICATION
  final Color backgroundColor;
  final Color dotsColor;
  final Color monthColor;
  final double calendarMinimizedHeight;
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  CalendarView(this.backgroundColor, this.dotsColor, this.monthColor,
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

    box = Hive.box(DateTime.now().year.toString());
  }

  int weekPosition(DateTime d) {
    String dwName = DateFormat('EEEE').format(d);
    switch (dwName) {
      case "Monday":
        return 0;
      case "Tuesday":
        return 1;
      case "Wednesday":
        return 2;
      case "Thursday":
        return 3;
      case "Friday":
        return 4;
      case "Saturday":
        return 5;
      case "Sunday":
        return 6;

      default:
        return 0;
    }
  }

  Widget myWeekDays(double maxwidth) {
    return SizedBox(
      width: maxwidth - maxwidth * 0.14,
      child: Row(
        children: [
          SizedBox(
            width: maxwidth / 11 * 0.05,
          ),
          SizedBox(
            width: maxwidth / 11,
            child: Text("Mon",
                textAlign: TextAlign.center,
                style: GoogleFonts.aboreto(
                  textStyle: const TextStyle(
                    color: containerColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                )),
          ),
          const Spacer(),
          SizedBox(
            width: maxwidth / 11,
            child: Text("Tue",
                textAlign: TextAlign.center,
                style: GoogleFonts.aboreto(
                  textStyle: const TextStyle(
                    color: containerColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                )),
          ),
          const Spacer(),
          SizedBox(
            width: maxwidth / 11,
            child: Text("Wed",
                textAlign: TextAlign.center,
                style: GoogleFonts.aboreto(
                  textStyle: const TextStyle(
                    color: containerColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                )),
          ),
          const Spacer(),
          SizedBox(
            width: maxwidth / 11,
            child: Text("Thu ",
                textAlign: TextAlign.center,
                style: GoogleFonts.aboreto(
                  textStyle: const TextStyle(
                    color: containerColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                )),
          ),
          const Spacer(),
          SizedBox(
            width: maxwidth / 11,
            child: Text("Fri",
                textAlign: TextAlign.center,
                style: GoogleFonts.aboreto(
                  textStyle: const TextStyle(
                    color: containerColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                )),
          ),
          const Spacer(),
          SizedBox(
            width: maxwidth / 11,
            child: Text("Sat",
                textAlign: TextAlign.center,
                style: GoogleFonts.aboreto(
                  textStyle: const TextStyle(
                    color: containerColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                )),
          ),
          const Spacer(),
          SizedBox(
            width: maxwidth / 11,
            child: Text("Sun",
                textAlign: TextAlign.center,
                style: GoogleFonts.aboreto(
                  textStyle: const TextStyle(
                    color: containerColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                )),
          )
        ],
      ),
    );
  }

  //IN ORDER TO NOT DUPLICATE CODE, I HAVE CREATED THE FOLOWING FUNCTION WHICH
  //RETURNS A WIDGET (GRID WITH THE CORRESPONDING DAYS).
  Widget myGrid(int monthDays, int lastDays, double maxwidth, double maxheight,
      monthNumber) {
    CalendarController controller = CalendarController();
    DateTime firstDay = DateTime(
        int.parse(controller.getRenderedYear(context)), monthNumber, 1);
    int wPosition = weekPosition(firstDay);
    return SizedBox(
      width: maxwidth,
      height: maxheight,
      child: ValueListenableBuilder(
        //LISTENING TO THE VALUES ON THE HIVE BOX (DB)
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
              monthDays + wPosition,
              (index) => index < wPosition
                  ? const SizedBox()
                  : Center(
                      child: box.get(index - wPosition + lastDays + 1) != null
                          ?
                          //IF THE CURRENT DATE EXISTS IN THE DB THEN I USE THE DATA STORED THERE:
                          DayView(box.get(index - wPosition + 1 + lastDays),
                              widget.calendarMinimizedHeight, widget.dotsColor)
                          :
                          //IN CASE THAT DATE IS NOT ON THE DB:
                          Container(
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
                                      ),
                                    ],
                                  ),
                                  Text((index - wPosition + 1).toString(),
                                      style: GoogleFonts.aboreto())
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
    box = Hive.box(controller.getRenderedYear(context));
    bool isLeapYear = DayYearCalculator(DateTime.now()).isLeapYear();

    var maxwidth = (MediaQuery.of(context).size.width);
    var maxheight = (MediaQuery.of(context).size.height);

    List<Widget> items = [
      //MONTH CALENDARS AND SPACE BETWEEN THEM.
      SizedBox(
        width: maxwidth * 0.05,
      ),
      Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Center(
              child: Text("January",
                  style: GoogleFonts.aboreto(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      letterSpacing: 2,
                    ),
                  ))),
          const SizedBox(
            height: 15,
          ),
          myWeekDays(maxwidth),
          myGrid(31, 0, maxwidth * 0.9,
              maxheight <= 600 ? maxheight * 0.5 : maxheight * 0.4, 1),
        ],
      ),
      SizedBox(
        width: maxwidth * 0.05,
      ),
      Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Center(
              child: Text(
            "February",
            style: GoogleFonts.aboreto(
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 25,
                  letterSpacing: 2),
            ),
          )),
          const SizedBox(
            height: 15,
          ),
          myWeekDays(maxwidth),
          myGrid(isLeapYear ? 29 : 28, 31, maxwidth * 0.9,
              maxheight <= 600 ? maxheight * 0.5 : maxheight * 0.32, 2),
        ],
      ),
      SizedBox(
        width: maxwidth * 0.05,
      ),
      Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Center(
              child: Text(
            "March",
            style: GoogleFonts.aboreto(
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 25,
                  letterSpacing: 2),
            ),
          )),
          const SizedBox(
            height: 15,
          ),
          myWeekDays(maxwidth),
          myGrid(31, isLeapYear ? 60 : 59, maxwidth * 0.9,
              maxheight <= 600 ? maxheight * 0.5 : maxheight * 0.4, 3),
        ],
      ),
      SizedBox(
        width: maxwidth * 0.05,
      ),
      Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Center(
              child: Text(
            "April",
            style: GoogleFonts.aboreto(
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 25,
                  letterSpacing: 2),
            ),
          )),
          const SizedBox(
            height: 15,
          ),
          myWeekDays(maxwidth),
          myGrid(30, isLeapYear ? 91 : 90, maxwidth * 0.9,
              maxheight <= 600 ? maxheight * 0.5 : maxheight * 0.4, 4),
        ],
      ),
      SizedBox(
        width: maxwidth * 0.05,
      ),
      Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Center(
              child: Text(
            "May ",
            style: GoogleFonts.aboreto(
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 25,
                  letterSpacing: 2),
            ),
          )),
          const SizedBox(
            height: 15,
          ),
          myWeekDays(maxwidth),
          myGrid(31, isLeapYear ? 121 : 120, maxwidth * 0.9,
              maxheight <= 600 ? maxheight * 0.5 : maxheight * 0.4, 5),
        ],
      ),
      SizedBox(
        width: maxwidth * 0.05,
      ),
      Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Center(
              child: Text(
            "June",
            style: GoogleFonts.aboreto(
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 25,
                  letterSpacing: 2),
            ),
          )),
          const SizedBox(
            height: 15,
          ),
          myWeekDays(maxwidth),
          myGrid(30, isLeapYear ? 152 : 151, maxwidth * 0.9,
              maxheight <= 600 ? maxheight * 0.5 : maxheight * 0.4, 6),
        ],
      ),
      SizedBox(
        width: maxwidth * 0.05,
      ),
      Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Center(
              child: Text(
            "July",
            style: GoogleFonts.aboreto(
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 25,
                  letterSpacing: 2),
            ),
          )),
          const SizedBox(
            height: 15,
          ),
          myWeekDays(maxwidth),
          myGrid(31, isLeapYear ? 182 : 181, maxwidth * 0.9,
              maxheight <= 600 ? maxheight * 0.5 : maxheight * 0.4, 7),
        ],
      ),
      SizedBox(
        width: maxwidth * 0.05,
      ),
      Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Center(
              child: Text(
            "August",
            style: GoogleFonts.aboreto(
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 25,
                  letterSpacing: 2),
            ),
          )),
          const SizedBox(
            height: 15,
          ),
          myWeekDays(maxwidth),
          myGrid(31, isLeapYear ? 213 : 212, maxwidth * 0.9,
              maxheight <= 600 ? maxheight * 0.5 : maxheight * 0.4, 8),
        ],
      ),
      SizedBox(
        width: maxwidth * 0.05,
      ),
      Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Center(
              child: Text(
            "September",
            style: GoogleFonts.aboreto(
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 25,
                  letterSpacing: 2),
            ),
          )),
          const SizedBox(
            height: 15,
          ),
          myWeekDays(maxwidth),
          myGrid(30, isLeapYear ? 244 : 243, maxwidth * 0.9,
              maxheight <= 600 ? maxheight * 0.5 : maxheight * 0.4, 9),
        ],
      ),
      SizedBox(
        width: maxwidth * 0.05,
      ),
      Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Center(
              child: Text(
            "October",
            style: GoogleFonts.aboreto(
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 25,
                  letterSpacing: 2),
            ),
          )),
          const SizedBox(
            height: 15,
          ),
          myWeekDays(maxwidth),
          myGrid(31, isLeapYear ? 274 : 273, maxwidth * 0.9,
              maxheight <= 600 ? maxheight * 0.5 : maxheight * 0.4, 10),
        ],
      ),
      SizedBox(
        width: maxwidth * 0.05,
      ),
      Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Center(
              child: Text(
            "November",
            style: GoogleFonts.aboreto(
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 25,
                  letterSpacing: 2),
            ),
          )),
          const SizedBox(
            height: 15,
          ),
          myWeekDays(maxwidth),
          myGrid(30, isLeapYear ? 305 : 304, maxwidth * 0.9,
              maxheight <= 600 ? maxheight * 0.5 : maxheight * 0.4, 11),
        ],
      ),
      SizedBox(
        width: maxwidth * 0.05,
      ),
      Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Center(
              child: Text(
            "December",
            style: GoogleFonts.aboreto(
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 25,
                  letterSpacing: 2),
            ),
          )),
          const SizedBox(
            height: 15,
          ),
          myWeekDays(maxwidth),
          myGrid(31, isLeapYear ? 335 : 334, maxwidth * 0.9,
              maxheight <= 600 ? maxheight * 0.5 : maxheight * 0.4, 12),
        ],
      ),
      SizedBox(
        width: maxwidth * 0.05,
      ),
    ];

    int currentMonth = controller.getCurrentDate(context).getMonth();

    return Container(
        clipBehavior: Clip.hardEdge,
        width: maxwidth,
        height: maxheight <= 600 ? maxheight * 0.7 : maxheight * 0.50,
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: ScrollablePositionedList.builder(
          //THIS WIDGET ALLOWS TO SCROLL TO AN INDEX.
          initialScrollIndex: (currentMonth - 1) * 2,
          /* AS  THE LIST OF ELEMENTS INCLUDED IN THE SCROLLABLEPOSITIONEDLIST
               ARE THE ACTUAL MONTH CALENDARS AND SOME SIZEDBOX IN ORDER TO CENTER
               THE CALENDARS, WE NEED TO CALCULATE THE ACTUAL INDEX WE WANT TO SCROLL TO,
               CAUSE I MIGHT NOT BE THE SAME AS THE MONTH NUMBER OF THE DATE. */
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          itemBuilder: (context, index) => items[index],
          itemScrollController: widget.itemScrollController,
          itemPositionsListener: widget.itemPositionsListener,
        ));
  }
}
