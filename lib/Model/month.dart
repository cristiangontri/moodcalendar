import 'package:flutter/cupertino.dart';

import 'package:emotionscalendar/Model/year.dart';

class Month extends ChangeNotifier {
  final int _monthNumber;
  String _monthName = "";
  final Year _year;
  late int _monthDays;
  bool _selected = false;
  Month(this._monthNumber, this._year) {
    _monthName = _monthName.toUpperCase();

    switch (_monthNumber) {
      case 1:
        _monthName = "JANUARY";
        _monthDays = 31;
        break;
      case 2:
        _monthName = "FEBRUARY";
        _monthDays = 28;
        break;
      case 3:
        _monthName = "MARCH";
        _monthDays = 31;
        break;
      case 4:
        _monthName = "APRIL";
        _monthDays = 30;
        break;
      case 5:
        _monthName = "MAY";
        _monthDays = 31;
        break;
      case 6:
        _monthName = "JUNE";
        _monthDays = 30;
        break;
      case 7:
        _monthName = "JULY";
        _monthDays = 31;
        break;
      case 8:
        _monthName = "AUGUST";
        _monthDays = 31;
        break;
      case 9:
        _monthName = "SEPTEMBER";
        _monthDays = 30;
        break;
      case 10:
        _monthName = "OCTOBER";
        _monthDays = 31;
        break;
      case 11:
        _monthName = "NOVEMBER";
        _monthDays = 30;
        break;
      case 12:
        _monthName = "DECEMBER";
        _monthDays = 31;
        break;
      default:
        break;
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
    notifyListeners();
  }

  void unselectMonth() {
    _selected = false;
    notifyListeners();
  }

  int getMonthDays() {
    return _monthDays;
  }
}
