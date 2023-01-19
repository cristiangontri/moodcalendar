import 'package:emotionscalendar/db/datedao.dart';
import 'package:flutter/cupertino.dart';
import 'emotion.dart';

class Calendar extends ChangeNotifier {
  //Calendar is the ChangeNotifier of the entire app.

  DateDao _currentDate;
  DateDao _selectedDate;

  Calendar(this._currentDate, this._selectedDate);

  DateDao getCurrentDate() {
    return _currentDate;
  }

  void setCurrentDate(DateDao d) {
    _currentDate = d;
    notifyListeners();
  }

  void changeEmotion(Emotion e) {
    //CHANGES THE EMOTION OF THE CURRENT DATE.
    _selectedDate.changeEmotion(e);
    notifyListeners();
    _selectedDate.save();
  }

  DateDao getSelectedDate() {
    return _selectedDate;
  }

  void setSelectedDate(DateDao d) {
    _selectedDate = d;
    notifyListeners();
  }
}
