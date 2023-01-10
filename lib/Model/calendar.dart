import 'package:emotionscalendar/Model/day.dart';
import 'package:emotionscalendar/Model/month.dart';
import 'package:emotionscalendar/Model/year.dart';
import 'package:flutter/cupertino.dart';

class Calendar extends ChangeNotifier {
  DateTime today;
  DateTime currentDate;
  late Year currentYear;
  late Month currentMonth;
  late Day currentDay;
  DateTime from;
  List<Month> months = [];
  List<Year> years = [];

  Calendar(this.today, this.currentDate, this.from) {
    //Lets define the current Year:
    currentYear = Year(currentDate.year);
    years.add(currentYear);

    //Getting the List of Months to Display:
    DateTime iterator = from;
    while (iterator.isBefore(today)) {
      Month newMonth = Month(iterator.month, Year(iterator.year));
      months.add(newMonth);
      iterator = DateTime(iterator.year, iterator.month + 1);
    }

    //Lets add all years needed:

    for (int i = 0; i <= months.length / 13; i++) {
      years.add(Year(currentYear.getYearNumber() + 1));
    }

    //Lets define the current month:
    currentMonth = months.firstWhere((element) =>
        element.getMonthNumber() == currentDate.month &&
        element.getYear().getYearNumber() == currentYear.getYearNumber());

    //Lets define the current day:
    currentDay = Day(currentDate.day, currentMonth, currentYear);
  }
  void changeCurrentDate(DateTime date) {
    currentDate = date;
    notifyListeners();
  }

  List<Month> getMonths() {
    return months;
  }

  void changeMonth(Month month) {
    currentMonth.unselectMonth();
    month.selectMonth();
    currentMonth = month;
    currentYear = month.getYear();
    notifyListeners();
  }

  Month getCurrentMonth() {
    return currentMonth;
  }

  Year getCurrentYear() {
    return currentYear;
  }

  Day getCurrentDay() {
    return currentDay;
  }
}
