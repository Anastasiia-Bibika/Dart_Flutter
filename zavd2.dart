/*З клавіатури вводиться символ, що є літерою українського алфавіту.
Визначити, якою є ця літера: голосною чи приголосною.*/

import 'dart:io';

void main() {
  print('Enter a letter:');
  String letter = stdin.readLineSync()!.toLowerCase();

  if (['a', 'e', 'i', 'o', 'u'].contains(letter)) {
    print("'$letter' is a vowel.");
  } else {
    print("'$letter' is a consonant.");
  }
}
