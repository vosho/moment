enum MomentExUnit {
  year,
  quarter,
  month,
  week,
  day,
  hour,
  minute,
  second,
  millisecond,
  microsecond,
}

class MomentEx {
  static int monthPerQuarter = 3;

  DateTime _dateTime = DateTime.now();

  MomentEx.fromDateTime(this._dateTime);

  int get timestamp {
    return _dateTime.millisecondsSinceEpoch ~/ 1000;
  }

  MomentEx(String pattern) {
    _dateTime = DateTime.parse(pattern);
  }

  MomentEx.now() {
    _dateTime = DateTime.now();
  }

  MomentEx.fromSeconds(int seconds) {
    _dateTime = DateTime.fromMillisecondsSinceEpoch(
        seconds * Duration.millisecondsPerSecond);
  }

  MomentEx.fromMilliseconds(int milliseconds) {
    _dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
  }

  MomentEx.fromMicroseconds(int microseconds) {
    _dateTime = DateTime.fromMicrosecondsSinceEpoch(microseconds);
  }
  diff(MomentEx end, MomentExUnit unit) {
    var seconds = timestamp - end.timestamp;
    // Log.d('seconds = $seconds');
    var diff = 0;
    switch (unit) {
      case MomentExUnit.second:
        diff = seconds ~/ 1;
        break;
      case MomentExUnit.minute:
        diff = seconds ~/ 60;
        break;
      case MomentExUnit.hour:
        diff = seconds ~/ (60 * 60);
        break;
      case MomentExUnit.day:
        diff = seconds ~/ (60 * 60 * 24);
        break;
      case MomentExUnit.week:
        diff = seconds ~/ (60 * 60 * 24 * 7);
        break;
      case MomentExUnit.month:
        //TODO:
        diff = seconds ~/ (60 * 60 * 24 * 30);
        break;
      case MomentExUnit.year:
        //TODO:
        diff = seconds ~/ (60 * 60 * 24 * 365);
        break;
    }
    return diff;
  }

  bool isAfter(MomentEx momentEx) {
    //20220102222334
    var selfFactor = year * 10000000000 +
        month * 100000000 +
        day +
        1000000 +
        hour * 10000 +
        minute * 100 * second;
    var otherFactor = momentEx.year * 10000000000 +
        momentEx.month * 100000000 +
        momentEx.day +
        1000000 +
        momentEx.hour * 10000 +
        momentEx.minute * 100 * momentEx.second;
    return selfFactor > otherFactor;
  }

  bool isAfterOrEqual(MomentEx momentEx) {
    //20220102222334
    var selfFactor = year * 10000000000 +
        month * 100000000 +
        day +
        1000000 +
        hour * 10000 +
        minute * 100 * second;
    var otherFactor = momentEx.year * 10000000000 +
        momentEx.month * 100000000 +
        momentEx.day +
        1000000 +
        momentEx.hour * 10000 +
        momentEx.minute * 100 * momentEx.second;
    return selfFactor >= otherFactor;
  }

  bool isBefore(MomentEx momentEx) {
    //20220102222334
    var selfFactor = year * 10000000000 +
        month * 100000000 +
        day +
        1000000 +
        hour * 10000 +
        minute * 100 * second;
    var otherFactor = momentEx.year * 10000000000 +
        momentEx.month * 100000000 +
        momentEx.day +
        1000000 +
        momentEx.hour * 10000 +
        momentEx.minute * 100 * momentEx.second;
    return selfFactor < otherFactor;
  }

  bool isBeforeOrEqual(MomentEx momentEx) {
    //20220102222334
    var selfFactor = year * 10000000000 +
        month * 100000000 +
        day * 1000000 +
        hour * 10000 +
        minute * 100 +
        second;
    var otherFactor = momentEx.year * 10000000000 +
        momentEx.month * 100000000 +
        momentEx.day * 1000000 +
        momentEx.hour * 10000 +
        momentEx.minute * 100 +
        momentEx.second;
    return selfFactor <= otherFactor;
  }

  bool isBetween(MomentEx a, MomentEx b) {
    return isAfterOrEqual(a) && isBeforeOrEqual(b);
  }

  MomentEx add(
      {int years: 0,
      int quarters: 0,
      int months: 0,
      int weeks: 0,
      int days: 0,
      int hours: 0,
      int minutes: 0,
      int seconds: 0,
      int milliseconds: 0,
      int microseconds: 0}) {
    var dateTime = DateTime(
        _dateTime.year + years,
        _dateTime.month + months + quarters * monthPerQuarter,
        _dateTime.day + days + weeks * DateTime.daysPerWeek,
        _dateTime.hour + hours,
        _dateTime.minute + minutes,
        _dateTime.second + seconds,
        _dateTime.millisecond + milliseconds,
        _dateTime.microsecond + microseconds);
    return MomentEx.fromDateTime(dateTime);
  }

  MomentEx subtract(
      {int years: 0,
      int quarters: 0,
      int months: 0,
      int weeks: 0,
      int days: 0,
      int hours: 0,
      int minutes: 0,
      int seconds: 0,
      int milliseconds: 0,
      int microseconds: 0}) {
    var dateTime = DateTime(
        _dateTime.year - years,
        _dateTime.month - months - quarters * monthPerQuarter,
        _dateTime.day - days - weeks * DateTime.daysPerWeek,
        _dateTime.hour - hours,
        _dateTime.minute - minutes,
        _dateTime.second - seconds,
        _dateTime.millisecond - milliseconds,
        _dateTime.microsecond - microseconds);
    return MomentEx.fromDateTime(dateTime);
  }

  int get startMonthOfQuarter => _dateTime.month - ((_dateTime.month - 1) % 3);
  int get startDayOfWeek => _dateTime.day - _dateTime.weekday + 1;

  MomentEx startOf(MomentExUnit unit) {
    DateTime dateTime;
    switch (unit) {
      case MomentExUnit.year:
        dateTime = DateTime(_dateTime.year);
        break;
      case MomentExUnit.quarter:
        dateTime = DateTime(_dateTime.year, startMonthOfQuarter);
        break;
      case MomentExUnit.month:
        dateTime = DateTime(_dateTime.year, _dateTime.month);
        break;
      case MomentExUnit.week:
        dateTime =
            DateTime(_dateTime.year, startDayOfWeek + DateTime.daysPerWeek);
        break;
      case MomentExUnit.day:
        dateTime = DateTime(_dateTime.year, _dateTime.month, _dateTime.day);
        break;
      case MomentExUnit.hour:
        dateTime = DateTime(
            _dateTime.year, _dateTime.month, _dateTime.day, _dateTime.hour);
        break;
      case MomentExUnit.minute:
        dateTime = DateTime(_dateTime.year, _dateTime.month, _dateTime.day,
            _dateTime.hour, _dateTime.minute);
        break;
      case MomentExUnit.second:
        dateTime = DateTime(_dateTime.year, _dateTime.month, _dateTime.day,
            _dateTime.hour, _dateTime.minute, _dateTime.second);
        break;
      case MomentExUnit.millisecond:
        dateTime = DateTime(
            _dateTime.year,
            _dateTime.month,
            _dateTime.day,
            _dateTime.hour,
            _dateTime.minute,
            _dateTime.second,
            _dateTime.millisecond);
        break;
      default:
        return this;
    }
    return MomentEx.fromDateTime(dateTime);
  }

  MomentEx endOf(MomentExUnit unit) {
    DateTime dateTime;
    switch (unit) {
      case MomentExUnit.year:
        dateTime = DateTime(_dateTime.year + 1);
        break;
      case MomentExUnit.quarter:
        dateTime =
            DateTime(_dateTime.year, startMonthOfQuarter + monthPerQuarter);
        break;
      case MomentExUnit.month:
        dateTime = DateTime(_dateTime.year, _dateTime.month + 1);
        break;
      case MomentExUnit.week:
        dateTime =
            DateTime(_dateTime.year, startDayOfWeek + DateTime.daysPerWeek);
        break;
      case MomentExUnit.day:
        dateTime = DateTime(_dateTime.year, _dateTime.month, _dateTime.day + 1);
        break;
      case MomentExUnit.hour:
        dateTime = DateTime(
            _dateTime.year, _dateTime.month, _dateTime.day, _dateTime.hour + 1);
        break;
      case MomentExUnit.minute:
        dateTime = DateTime(_dateTime.year, _dateTime.month, _dateTime.day,
            _dateTime.hour, _dateTime.minute + 1);
        break;
      case MomentExUnit.second:
        dateTime = DateTime(_dateTime.year, _dateTime.month, _dateTime.day,
            _dateTime.hour, _dateTime.minute, _dateTime.second + 1);
        break;
      case MomentExUnit.millisecond:
        dateTime = DateTime(
            _dateTime.year,
            _dateTime.month,
            _dateTime.day,
            _dateTime.hour,
            _dateTime.minute,
            _dateTime.second,
            _dateTime.millisecond + 1);
        break;
      default:
        return this;
    }
    return MomentEx.fromDateTime(dateTime).subtract(microseconds: 1);
  }

  String format([String pattern = 'yyyy-MM-dd hh:mm:ss']) {
    var str = pattern;
    str = str.replaceAll('yyyy', '$year');
    str = str.replaceAll('MM', '$month'.padLeft(2, '0'));
    str = str.replaceAll('M', '$month');
    str = str.replaceAll('dd', '$day'.padLeft(2, '0'));
    str = str.replaceAll('d', '$day');
    str = str.replaceAll('hh', '$hour'.padLeft(2, '0'));
    str = str.replaceAll('h', '$hour');
    str = str.replaceAll('mm', '$minute'.padLeft(2, '0'));
    str = str.replaceAll('m', '$minute');
    str = str.replaceAll('ss', '$second'.padLeft(2, '0'));
    str = str.replaceAll('s', '$second');
    return str;
  }

  /// The year
  int get year => _dateTime.year;

  /// The quarter
  int get quarter => (_dateTime.month - 1) ~/ 3 + 1;

  /// The month
  int get month => _dateTime.month;

  /// The day of the month
  int get day => _dateTime.day;

  /// The day of the week
  int get weekday => _dateTime.weekday;

  /// The hour of the day
  int get hour => _dateTime.hour;

  /// The minute
  int get minute => _dateTime.minute;

  /// The second
  int get second => _dateTime.second;

  /// The millisecond
  int get millisecond => _dateTime.millisecond;

  /// The microsecond
  int get microsecond => _dateTime.microsecond;
}
