/*Реалізувати клас, що представляє арифметичну прогресію. Передбачити індексатор для
одержання n-го члена прогресії, методи введення/виведення, знаходження суми членів цієї прогресії.*/

void main() {
  ArithmeticProgression ap = ArithmeticProgression(1, 5);
  print(ap[2]);
}

class ArithmeticProgression {
  double first;
  double step;

  ArithmeticProgression(this.first, this.step);

  double operator [](int index) {
    if (index < 0) {
      throw ArgumentError("Index must be non-negative");
    }
    return first + step * index;
  }

  static ArithmeticProgression fromList(List<double> list) {
    if (list.length < 2) {
      throw ArgumentError("List must have at least 2 elements");
    }
    double first = list[0];
    double step = list[1] - first;
    for (int i = 2; i < list.length; i++) {
      if (list[i] - list[i - 1] != step) {
        throw ArgumentError("List is not an arithmetic progression");
      }
    }
    return ArithmeticProgression(first, step);
  }

  double sum(int n) {
    if (n <= 0) {
      throw ArgumentError("n not positive");
    }
    return n * (2 * first + (n - 1) * step) / 2;
  }
}
