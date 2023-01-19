import 'dart:core';

import 'package:emotionscalendar/Model/emotion.dart';
import 'package:hive/hive.dart';

part 'datedao.g.dart';

@HiveType(typeId: 1)
class DateDao extends HiveObject {
  @HiveField(0)
  int _day;
  @HiveField(1)
  final int _month;
  @HiveField(2)
  final int _year;
  @HiveField(3)
  String _emotion;
  @HiveField(4)
  String _note = "";

  DateDao(this._day, this._month, this._year, this._emotion);

  int getDay() {
    return _day;
  }

  int getMonth() {
    return _month;
  }

  int getYear() {
    return _year;
  }

  String getEmotion() {
    return _emotion;
  }

  String getNote() {
    return _note;
  }

  void addNote(String note) {
    _note = note;
  }

  void changeEmotion(Emotion e) {
    _emotion = e.getName();
  }

  bool isequal(DateDao d) {
    return (_day == d.getDay() &&
        _month == d.getMonth() &&
        _year == d.getYear());
  }
}
