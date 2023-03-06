import 'package:intl/intl.dart';

class DayYearCalculator {
  final DateTime _date;
  DayYearCalculator(this._date);

  int toYearDay() {
    int dayOfYear = int.parse(DateFormat("D").format(_date));

    return dayOfYear;
  }

  bool isLeapYear() {
    int year = _date.year;
    if (year % 4 == 0) {
      if (year % 100 == 0) {
        if (year % 400 == 0) {
          return true;
        } else {
          return false;
        }
      } else {
        return true;
      }
    }
    return false;
  }
}
