class Year {
  final int _year;
  bool _selected = false;
  bool _leapYear = false;
  Year(this._year) {
    if (_year % 4 == 0 && _year % 100 == 0 && _year % 400 == 0) {
      _leapYear = true;
    }
  }

  bool isSelected() {
    return _selected;
  }

  void selectYear() {
    _selected = true;
  }

  void unselectYear() {
    _selected = false;
  }

  int getYearNumber() {
    return _year;
  }

  bool isLeapYear() {
    return _leapYear;
  }
}
