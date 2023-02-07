import 'package:emotionscalendar/Controller/controller.dart';
import 'package:emotionscalendar/View/colors.dart';
import 'package:emotionscalendar/View/dayview.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
    box = Hive.box("Dates");
  }

  //IN ORDER TO NOT DUPLICATE CODE, I HAVE CREATED THE FOLOWING FUNCTION WHICH
  //RETURNS A WIDGET (GRID WITH THE CORRESPONDING DAYS).
  Widget myGrid(
      int monthDays, int lastDays, double maxwidth, double maxheight) {
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
              monthDays,
              (index) => Center(
                child: box.get(index + lastDays + 1) != null
                    ?
                    //IF THE CURRENT DATE EXISTS IN THE DB THEN I USE THE DATA STORED THERE:
                    DayView(box.get(index + 1 + lastDays),
                        widget.calendarMinimizedHeight, widget.dotsColor)
                    :
                    //IN CASE THAT DATE IS NOT ON THE DB:
                    Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            color: containerColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 6,
                                  width: 6,
                                  decoration: BoxDecoration(
                                      color: widget.dotsColor,
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                                Container(
                                  height: 6,
                                  width: 6,
                                  decoration: BoxDecoration(
                                      color: widget.dotsColor,
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              ],
                            ),
                            Text((index + 1).toString(),
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
          myGrid(31, 0, maxwidth * 0.9, maxheight * 0.32),
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
          myGrid(28, 31, maxwidth * 0.9, maxheight * 0.32),
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
          myGrid(31, 59, maxwidth * 0.9, maxheight * 0.32),
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
          myGrid(32, 90, maxwidth * 0.9, maxheight * 0.32),
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
          myGrid(31, 120, maxwidth * 0.9, maxheight * 0.32),
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
          myGrid(32, 151, maxwidth * 0.9, maxheight * 0.32),
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
          myGrid(31, 181, maxwidth * 0.9, maxheight * 0.32),
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
          myGrid(31, 212, maxwidth * 0.9, maxheight * 0.32),
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
          myGrid(32, 243, maxwidth * 0.9, maxheight * 0.32),
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
          myGrid(31, 273, maxwidth * 0.9, maxheight * 0.32),
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
          myGrid(32, 324, maxwidth * 0.9, maxheight * 0.32),
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
          myGrid(31, 334, maxwidth * 0.9, maxheight * 0.32),
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
        height: maxheight * 0.40,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
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
