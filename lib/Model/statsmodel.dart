import 'package:emotionscalendar/Model/emotion.dart';
import 'package:emotionscalendar/db/datedao.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Stats {
  late int _happyDays;
  late int _cryingDays;
  late int _calmDays;
  late int _angryDays;
  late int _sickDays;
  late int _neutralDays;
  late int _lovedDays;
  late int _badDays;

  Stats() {
    update();
  }

  void update() {
    Box dates = Hive.box("Dates");
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
}
