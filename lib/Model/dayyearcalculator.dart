import 'package:intl/intl.dart';

class DayYearCalculator {
  final DateTime _date;
  DayYearCalculator(this._date);

  int toYearDay() {
    int dayOfYear = int.parse(DateFormat("D").format(_date));

    return dayOfYear;
  }
}
