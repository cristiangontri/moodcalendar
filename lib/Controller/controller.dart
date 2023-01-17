import 'package:emotionscalendar/Model/calendar.dart';
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
}
