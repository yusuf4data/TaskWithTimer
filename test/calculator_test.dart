import 'package:flutter_test/flutter_test.dart';

void main() {
  late Calculator calculator;
  setUp(() {
    calculator = Calculator();
  });
  group('test the operation of class calculator', () {
    test('test adding two numbers', () {
      double sum = calculator.add(2, 2);
      expect(sum, 4);
    });
    test('test subscription 2 numbers', () {
      var sub = calculator.sub(5, 2);
      expect(3, sub);
    });
    test('test multiplay 2 numbers', () {
      var m = 5 * 2;
      var multi = calculator.multiply(5, 2);
      expect(multi, m);
    });
    test('test divided 2 numbers', () {
      var m = 5 / 0;
      var multi = calculator.divided(5, 0);
      expect(multi, m);
    });
  });
}

class Calculator {
  double add(double i, double j) {
    return i + j;
  }

  num sub(int i, int j) {
    return i - j;
  }

  num multiply(int i, int j) {
    return i * j;
  }

  num divided(int i, int j) {
    if (j == 0) {}
    return i / j;
  }
}
