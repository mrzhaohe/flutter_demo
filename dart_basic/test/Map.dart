void main() {
  Map map1 = new Map();
  map1['first'] = 'one';
  print(map1);

  var map2 = new Map();
  map2['apple'] = '苹果';
  print(map2);

  map1.addAll(map2);
  print(map1);

  Map map3 = {'key1': 'value1', 'key2': 'valu2'};
  
}
