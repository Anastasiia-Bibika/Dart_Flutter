/*клавіатури вводиться кількість монет номіналом 2 копійки (5коп, 25коп, 50
коп). Визначити скільки гривень і копійок є у даній сумі.*/

import 'dart:io';

void main() {
  print('Введіть кількість монет номіналом 2 копійки:');
  int twoKop = int.parse(stdin.readLineSync()!);

  print('Введіть кількість монет номіналом 5 копійок:');
  int fiveKop = int.parse(stdin.readLineSync()!);

  print('Введіть кількість монет номіналом 25 копійок:');
  int twentyFiveKop = int.parse(stdin.readLineSync()!);

  print('Введіть кількість монет номіналом 50 копійок:');
  int fiftyKop = int.parse(stdin.readLineSync()!);

  int totalKop = twoKop * 2 + fiveKop * 5 + twentyFiveKop * 25 + fiftyKop * 50;
  int hrn = totalKop ~/ 100;
  int kop = totalKop % 100;

  print('Всього у вас є $hrn гривень і $kop копійок.');
}
