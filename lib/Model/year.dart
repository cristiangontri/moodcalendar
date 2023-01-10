class Year {
  int year;
  bool selected = false;
  bool leapYear = false;
  Year(this.year) {
    if (year % 4 == 0 && year % 100 == 0 && year % 400 == 0) {
      leapYear = true;
    }
  }

  void selectYear() {
    selected = true;
  }

  int getYearNumber() {
    return year;
  }
}
