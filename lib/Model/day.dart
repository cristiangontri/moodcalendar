import 'package:emotionscalendar/Model/emotion.dart';
import 'package:emotionscalendar/Model/year.dart';
import 'package:intl/intl.dart';

import 'month.dart';

class Day {
  final Year _year;
  final Month _month;
  final int _day;
  String _weekDay = "";
  bool _selected = false;
  Emotion _emotion = Emotion.unassigned;
  String? _notes;

  Day(this._day, this._month, this._year) {
    DateTime date =
        DateTime(_year.getYearNumber(), _month.getMonthNumber(), _day);
    String input = DateFormat('EEEE').format(date);

    switch (input) {
      case "Monday":
        _weekDay = "Mon";
        break;
      case "Tuesday":
        _weekDay = "Tu";
        break;
      case "Wednesday":
        _weekDay = "Wed";
        break;
      case "Thursday":
        _weekDay = "Th";
        break;
      case "Friday":
        _weekDay = "Fr";
        break;
      case "Saturday":
        _weekDay = "Sat";
        break;
      case "Sunday":
        _weekDay = "Sun";
        break;
      default:
        break;
    }
  }

  bool isSelected() {
    return _selected;
  }

  void select() {
    _selected = true;
  }

  void unselect() {
    _selected = false;
  }

  void setNote(String input) {
    _notes = input;
  }

  String getNote() {
    if (_notes != null) {
      return _notes!;
    } else {
      return "No notes this day :(";
    }
  }

  void setEmotion(Emotion em) {
    _emotion = em;
  }

  Emotion? getEmotion() {
    return _emotion;
  }

  Year getYear() {
    return _year;
  }

  Month getMonth() {
    return _month;
  }

  int getDay() {
    return _day;
  }

  String getWeekDay() {
    return _weekDay;
  }
}
