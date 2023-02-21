import 'package:emotionscalendar/db/datedao.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'emotion.dart';

class Calendar extends ChangeNotifier {
  //Calendar is the ChangeNotifier of the entire app.

  DateDao _currentDate;
  DateDao _selectedDate;
  late int _renderedYear;

  Calendar(this._currentDate, this._selectedDate) {
    _renderedYear = _currentDate.getYear();
  }

  DateDao getCurrentDate() {
    return _currentDate;
  }

  String getRenderedYear() {
    return _renderedYear.toString();
  }

  void nextRenderedYear() async {
    if (_renderedYear != DateTime.now().year) {
      _renderedYear++;
      await Hive.openBox(_renderedYear.toString());
      notifyListeners();
      await Hive.box((_renderedYear - 1).toString()).close();
    }
  }

  void previousRenderedYear() async {
    _renderedYear--;
    await Hive.openBox(_renderedYear.toString());
    notifyListeners();
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

  void addNote(String note) {
    _selectedDate.addNote(note);
    _selectedDate.save();
    notifyListeners();
  }
}
