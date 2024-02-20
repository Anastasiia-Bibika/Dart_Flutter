/*Створити функцію, яка за номером місяця повертає його назву. */

import 'dart:io';

void main() {
  print('Input a number of month: ');
  int? month = int.parse(stdin.readLineSync()!);
  print(getMonthName(month));
}

String getMonthName(int monthNumber) {
  List<String> monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  if (monthNumber >= 1 && monthNumber <= 12) {
    return monthNames[monthNumber - 1];
  } else {
    return 'Invalid month number';
  }
}
