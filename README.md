# Moment for Dart

Inspired by [moment](https://github.com/pd4d10/moment) and `Js Library` [momentjs](https://github.com/moment/moment)

## Usage

```dart
import '../lib/moment.dart';

main() {
  MomentEx.now();

  var m = MomentEx('2018-09-15 16:28:58Z');
  // Get
  m.year; // 2018
  m.quarter; // 3
  m.month; // 9
  m.day; // 15
  m.weekday; // 6 (Saturday)
  m.hour; // 16
  m.minute; // 28
  m.second; // 58

  // Manipulate
  print(m.add(years: 1, quarters: 2, months: 3));
  print(m.subtract(weeks: 1, days: 2, hours: 3));

  print(m.startOf(MomentExUnit.year).format()); 
  print(m.startOf(MomentExUnit.week));  

  // Display
  print(m.format('yyyy-MM-dd'));
  print(m.format('yyyy-M-dd'));
  print(m.add(years: 2).format('yyyy-M-dd'));
  print(m.add(years: 2).add(months: 8).format('yyyy-M-dd'));
}

```

## License

MIT