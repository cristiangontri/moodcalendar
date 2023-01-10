import 'package:emotionscalendar/Model/calendar.dart';
import 'package:intl/intl.dart';

import 'month.dart';

void main(List<String> args) {
  DateFormat myFormatter = DateFormat('yyyy/MM/dd');

  Calendar myCalendar =
      Calendar(DateTime.now(), DateTime.now(), myFormatter.parse('2022/01/01'));
  List<Month> months = myCalendar.getMonths();

  for (Month m in months) {
    print(m.getMonthName());
  }

  int currentMonthNumber = myCalendar.getCurrentMonth().getMonthNumber();
  String currentMonthName = myCalendar.getCurrentMonth().getMonthName();
  int currentYear = myCalendar.getCurrentYear().getYearNumber();
  int currentDay = myCalendar.getCurrentDay().getDay();
  print("The current day is: " +
      currentDay.toString() +
      "\n" +
      "Month Number = " +
      currentMonthNumber.toString() +
      "\n" +
      "which is called: " +
      currentMonthName +
      "\n" +
      "From the year: " +
      currentYear.toString());
}
