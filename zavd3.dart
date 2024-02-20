/*Нехай шестизначне число називається “щасливим”, якщо сума його
перших трьох цифр дорівнює сумі інших трьох. Знайти k-те щасливе число.*/

void main() {
  int k = 1;
  int count = 0;
  int num = 180027;

  while (count < k) {
    List<int> numStr = num.toString().split('').map(int.parse).toList();
    int sum1 = numStr.sublist(0, 3).reduce((a, b) => a + b);
    int sum2 = numStr.sublist(3).reduce((a, b) => a + b);

    if (sum1 == sum2) {
      count++;
      print('$num is the ${count}th happy number.');
    }

    num++;
  }
}
