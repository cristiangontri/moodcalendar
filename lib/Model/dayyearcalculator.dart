class DayYearCalculator {
  final DateTime _date;
  DayYearCalculator(this._date);

  int toYearDay() {
    //Zeller's Rule:
    int year = _date.year;
    int c = (year / 100).floor();
    int D = mod(year, c);
    int m = mod(_date.month + 1 - 2 + 12, 12);
    int k = _date.day + 1;
    int result = k +
        ((13 * m - 1) / 5).floor() +
        D +
        (D / 4).floor() +
        (c / 4).floor() -
        (2 * c);

    return result;
  }

  int mod(int i, int x) {
    //SIMPLE RECURSIVE FUNCTION TO CALCULATE MOD
    if (i <= x) {
      return i;
    } else {
      return mod(i - x, x);
    }
  }
}
