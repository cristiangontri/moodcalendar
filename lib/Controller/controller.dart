import 'package:emotionscalendar/Model/calendar.dart';
import 'package:emotionscalendar/Model/day.dart';
import 'package:provider/provider.dart';

class CalendarController {
  void selectDay(Day d, context) {
    Provider.of<Calendar>(context, listen: false).selectDay(d);
  }
}
