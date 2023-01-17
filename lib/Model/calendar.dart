import 'package:emotionscalendar/db/datedao.dart';
import 'package:flutter/cupertino.dart';
import 'emotion.dart';

class Calendar extends ChangeNotifier {
  //Calendar is the ChangeNotifier of the entire app.

  DateDao _currentDate;

  Calendar(this._currentDate);

  DateDao getCurrentDate() {
    return _currentDate;
  }

  void setCurrentDate(DateDao d) {
    _currentDate = d;
  }

  void changeEmotion(Emotion e) {
    //CHANGES THE EMOTION OF THE CURRENT DATE.
    _currentDate.changeEmotion(e);
    _currentDate.save();
    notifyListeners();
  }
}
