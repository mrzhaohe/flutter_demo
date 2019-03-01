import 'dart:math';

class Point {
  num x, y;
  Point(this.x, this.y);
  num distanceTo(Point other) {
    var dx = x - other.x;
    var dy = y - other.y;
    return sqrt(dx * dx + dy * dy);
  }
}

void main() {
  // var point = Point(3, 5);
  // print(point.distanceTo(Point(4,6)));

  // var rect = Rectangle(3, 4, 3, 4);
  // rect.right = 12;
  // print(rect.left);

  // var subDoer = EffectiveDoer();
  // subDoer.doSomething();
  @Todo('ss', '注释')
  var logger = Logger('UI');
  logger.log('Button clicked');
  print(logger.name);
}

class Rectangle {
  num left, top, width, height;
  Rectangle(this.left, this.top, this.width, this.height);

  num get right => left + width;
  set right(num value) => left = value - width;

  num get bottom => top + height;
  set bottom(num value) => top = value - height;
}

abstract class Doer {
  void doSomething();
}

class EffectiveDoer extends Doer {
  void doSomething() {
    print('do something');
  }
}

class Logger {
  final String name;
  bool mute = false;
  static final Map<String, Logger> _cache = <String, Logger>{};

  factory Logger(String name) {
    if (_cache.containsKey(name)) {
      return _cache[name];
    } else {
      final logger = Logger._internal(name);
      _cache[name] = logger;
      return logger;
    }
  }

  Logger._internal(this.name);
  void log(String msg) {
    if (!mute) print(msg);
  }
}

class Todo {
  final String who;
  final String what;
  const Todo(this.who, this.what);
}
