void main() {
  List list = [1, 's', 4, false];
  print(list);

  var fruits = new List();
  fruits.add('apples');
  fruits.addAll(['pea', 'orange']);
  fruits.add(3);
  print(fruits);
  print(fruits.length);

  var suc = fruits.remove('pea');
  print(suc);
  print(fruits);
  fruits.clear();
  print(fruits);
}
