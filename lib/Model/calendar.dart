import 'package:emotionscalendar/Model/day.dart';
import 'package:emotionscalendar/Model/month.dart';
import 'package:emotionscalendar/Model/year.dart';
import 'package:flutter/cupertino.dart';

class Calendar extends ChangeNotifier {
  final DateTime _today;
  DateTime _currentDate;
  late Year _currentYear;
  late Month _currentMonth;
  late Day _currentDay;
  final DateTime _from;
  List<Month> _months = [];
  List<Year> _years = [];

  Calendar(this._today, this._currentDate, this._from) {
    //Lets define the current Year:

    //Getting the List of Months to Display:
    DateTime iterator = DateTime(_from.year, _from.month);
    while (iterator.isBefore(DateTime(_today.year, _today.month + 1))) {
      Month newMonth = Month(iterator.month, Year(iterator.year));
      _months.add(newMonth);
      iterator = DateTime(iterator.year, iterator.month + 1);
    }

    //Lets add all years needed:

    for (Month m in _months) {
      if (m.getMonthNumber() == 12) {
        _years.add(Year(m.getYear().getYearNumber() + 1));
      }
    }
    _currentYear = _years.last;

    _currentYear.selectYear();

    //Lets define the current month and select it:
    _currentMonth = _months.firstWhere((element) =>
        element.getMonthNumber() == _currentDate.month &&
        element.getYear().getYearNumber() == _currentYear.getYearNumber());
    _currentMonth.selectMonth();

    //Lets define the current day:
    _currentDay = _currentMonth.findDay(_today.day) ??
        Day(0, _currentMonth, _currentYear);
    _currentDay.select();
    notifyListeners();
  }
  void changeCurrentDate(DateTime date) {
    _currentDate = date;
    notifyListeners();
  }

  List<Month> getMonths() {
    return _months;
  }

  void changeMonth(Month month) {
    _currentMonth.unselectMonth();
    month.selectMonth();
    _currentMonth = month;
    _currentYear = month.getYear();
    notifyListeners();
  }

  Month getCurrentMonth() {
    return _currentMonth;
  }

  Year getCurrentYear() {
    return _currentYear;
  }

  Day getCurrentDay() {
    return _currentDay;
  }

  List<Year> getYearList() {
    return _years;
  }

  void selectDay(Day d) {
    _currentDay.unselect();
    d.select();
    _currentDay = d;
    notifyListeners();
  }

  List<Object> getPrintableListYaM() {
    List<Object> result = [];
    int cm = 0;
    int cy = 0;
    bool decem = false;
    for (int i = 0; i < _years.length + _months.length; i++) {
      if (decem) {
        result.add(_years[cy]);
        cy++;
        decem = false;
      } else {
        String mname = _months[cm].getMonthName();
        if (mname == "DECEMBER") {
          decem = true;
        } else {
          decem = false;
        }
        result.add(_months[cm]);
        cm++;
      }
    }
    return result;
  }
}
