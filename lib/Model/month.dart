import 'package:emotionscalendar/Model/calendar.dart';
import 'package:emotionscalendar/Model/day.dart';
import 'package:flutter/cupertino.dart';

import 'package:emotionscalendar/Model/year.dart';

class Month {
  final int _monthNumber;
  String _monthName = "";
  final Year _year;
  late int _monthDaysNumber;
  List<Day> _monthDays = [];
  bool _selected = false;

  Month(this._monthNumber, this._year) {
    _monthName = _monthName.toUpperCase();

    switch (_monthNumber) {
      case 1:
        _monthName = "JANUARY";
        _monthDaysNumber = 31;
        break;
      case 2:
        _monthName = "FEBRUARY";
        _monthDaysNumber = 28;
        break;
      case 3:
        _monthName = "MARCH";
        _monthDaysNumber = 31;
        break;
      case 4:
        _monthName = "APRIL";
        _monthDaysNumber = 30;
        break;
      case 5:
        _monthName = "MAY";
        _monthDaysNumber = 31;
        break;
      case 6:
        _monthName = "JUNE";
        _monthDaysNumber = 30;
        break;
      case 7:
        _monthName = "JULY";
        _monthDaysNumber = 31;
        break;
      case 8:
        _monthName = "AUGUST";
        _monthDaysNumber = 31;
        break;
      case 9:
        _monthName = "SEPTEMBER";
        _monthDaysNumber = 30;
        break;
      case 10:
        _monthName = "OCTOBER";
        _monthDaysNumber = 31;
        break;
      case 11:
        _monthName = "NOVEMBER";
        _monthDaysNumber = 30;
        break;
      case 12:
        _monthName = "DECEMBER";
        _monthDaysNumber = 31;
        break;
      default:
        break;
    }
    for (int i = 0; i < _monthDaysNumber; i++) {
      _monthDays.add(Day(i + 1, this, _year));
    }
  }

  String getMonthName() {
    return _monthName;
  }

  int getMonthNumber() {
    return _monthNumber;
  }

  bool isSelected() {
    return _selected;
  }

  Year getYear() {
    return _year;
  }

  void selectMonth() {
    _selected = true;
  }

  void unselectMonth() {
    _selected = false;
  }

  int getNumberOfDays() {
    return _monthDaysNumber;
  }

  List<Day> getDays() {
    return _monthDays;
  }

  Day? findDay(int i) {
    for (Day d in _monthDays) {
      if (i == d.getDay()) {
        return d;
      }
    }
    return null;
  }
}
