/*Дано масив, який містить послідовність значень ідентифікаційних кодів (цілих чисел) користувачів
сайту, що відвідували даний сайт протягом дня. Необхідно знайти кількість різних користувачів, для
кожного користувача необхідно вивести кількість відвідувань, вивести на екран користувачів, що
відвідували сайт найчастіше та найрідше.*/

void main() {
  var userIds = [1, 2, 3, 4, 5, 1, 7, 8, 3, 10, 1, 2, 8, 4, 1, 1, 7, 8, 2, 5];
  var ids = {};
  for (var userId in userIds) {
    if (ids.containsKey(userId))
      ids[userId]++;
    else
      ids[userId] = 1;
  }
  for (var item in ids.entries) {
    print("${item.key} - ${item.value}");
  }
  int maxVisits =
      ids.values.reduce((current, next) => current > next ? current : next);
  int minVisits =
      ids.values.reduce((current, next) => current < next ? current : next);
  var maxUser =
      ids.keys.firstWhere((k) => ids[k] == maxVisits, orElse: () => null);
  print('User with maximum number of visits: $maxUser');
  var minUser =
      ids.keys.firstWhere((k) => ids[k] == minVisits, orElse: () => null);
  print('User with minimum number of visits: $minUser');
}
