import 'package:emotionscalendar/Controller/controller.dart';
import 'package:emotionscalendar/Model/emotion.dart';
import 'package:emotionscalendar/db/datedao.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Stats {
  String year = "";
  int _happyDays = 0;
  int _cryingDays = 0;
  int _calmDays = 0;
  int _angryDays = 0;
  int _sickDays = 0;
  int _neutralDays = 0;
  int _lovedDays = 0;
  int _badDays = 0;

  Stats(context) {
    var controller = CalendarController();
    year = controller.getRenderedYear(context);
    update();
  }

  void update() {
    Box dates = Hive.box(year);
    _happyDays = dates.values
        .where((element) =>
            (element as DateDao).getEmotion() == Emotion.happy.getName())
        .length;

    _cryingDays = dates.values
        .where((element) =>
            (element as DateDao).getEmotion() == Emotion.crying.getName())
        .length;

    _calmDays = dates.values
        .where((element) =>
            (element as DateDao).getEmotion() == Emotion.calm.getName())
        .length;

    _badDays = dates.values
        .where((element) =>
            (element as DateDao).getEmotion() == Emotion.bad.getName())
        .length;

    _angryDays = dates.values
        .where((element) =>
            (element as DateDao).getEmotion() == Emotion.angry.getName())
        .length;

    _lovedDays = dates.values
        .where((element) =>
            (element as DateDao).getEmotion() == Emotion.loved.getName())
        .length;

    _sickDays = dates.values
        .where((element) =>
            (element as DateDao).getEmotion() == Emotion.sick.getName())
        .length;

    _neutralDays = dates.values
        .where((element) =>
            (element as DateDao).getEmotion() == Emotion.unassigned.getName())
        .length;
  }

  int getHappyDays() {
    return _happyDays;
  }

  int getCryingDays() {
    return _cryingDays;
  }

  int getBadDays() {
    return _badDays;
  }

  int getSickDays() {
    return _sickDays;
  }

  int getAngryDays() {
    return _angryDays;
  }

  int getNeutralDays() {
    return _neutralDays;
  }

  int getLovedDays() {
    return _lovedDays;
  }

  int getCalmDays() {
    return _calmDays;
  }

  String getYear() {
    return year;
  }

  void setYear(String y) {
    year = y;
  }
}
