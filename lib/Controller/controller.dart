import 'package:emotionscalendar/Model/calendar.dart';
import 'package:emotionscalendar/Model/settingsmodel.dart';
import 'package:emotionscalendar/db/datedao.dart';
import 'package:emotionscalendar/Model/emotion.dart';
import 'package:provider/provider.dart';

class CalendarController {
  //HANDLES THE COMUNICATION BETWEEN THE MODEL AND THE VIEWS
  DateDao getCurrentDate(context) {
    return Provider.of<Calendar>(context).getCurrentDate();
  }

  void setCurrentDate(DateDao d, context) {
    Provider.of<Calendar>(context, listen: false).setCurrentDate(d);
  }

  void changeEmotion(Emotion e, context) {
    Provider.of<Calendar>(context, listen: false).changeEmotion(e);
  }

  DateDao getSelectedDate(context) {
    return Provider.of<Calendar>(context, listen: false).getSelectedDate();
  }

  void setSelectedDate(context, DateDao d) {
    Provider.of<Calendar>(context, listen: false).setSelectedDate(d);
  }

  String getRenderedYear(context) {
    return Provider.of<Calendar>(context).getRenderedYear();
  }

  void previousRenderedYear(context) {
    Provider.of<Calendar>(context, listen: false).previousRenderedYear();
  }

  void nextRenderedYear(context) {
    Provider.of<Calendar>(context, listen: false).nextRenderedYear();
  }

  void addNote(context, String note) {
    Provider.of<Calendar>(context, listen: false).addNote(note);
  }
}

class SettingsController {
  String getCurrentNotificationTime(context) {
    return Provider.of<SettingsModel>(context).getCurrentNotificationTime();
  }

  String getUserName(context) {
    return Provider.of<SettingsModel>(context).getUserName();
  }

  void changeUserName(context, String s) {
    Provider.of<SettingsModel>(context, listen: false).changeUserName(s);
  }

  void changeTime(context, String s) {
    Provider.of<SettingsModel>(context, listen: false).changeTime(s);
  }

  void changeNotification(context) {
    Provider.of<SettingsModel>(context, listen: false).changeNotifications();
  }
}
