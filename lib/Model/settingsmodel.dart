import 'package:emotionscalendar/Model/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SettingsModel extends ChangeNotifier {
  final String userbox = 'User';
  String notificationTime = "";
  String userName = "";

  SettingsModel() {
    Box uB = Hive.box(userbox);
    if (uB.getAt(0) != null) {
      userName = uB.getAt(0);
    }
    notificationTime = uB.getAt(1);
  }

  void changeTime(String s) {
    notificationTime = s;
    notifyListeners();
  }

  Future changeNotifications() async {
    Box uB = Hive.box(userbox);
    uB.putAt(1, notificationTime);

    int hour = int.parse(notificationTime.split(":")[0]);

    int minute = int.parse(notificationTime.split(":")[1]);
    DateTime now = DateTime.now();
    DateTime myTime = DateTime(now.year, now.month, now.day, hour, minute, 0);

    NotificationService().showNotification(
        title: "Hey there!", body: "How was your day?", mytime: myTime);
  }

  void changeUserName(String newUN) {
    Box uB = Hive.box(userbox);
    uB.putAt(0, newUN);
    userName = newUN;
    notifyListeners();
  }

  String getCurrentNotificationTime() {
    return notificationTime;
  }

  String getUserName() {
    return userName;
  }
}
