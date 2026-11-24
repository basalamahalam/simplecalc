import 'package:flutter_test/flutter_test.dart';
import 'package:simplecalc/calculator_engine.dart';

void main() {
  group('CalculatorEngine', () {
    test('digit input builds display', () {
      final e = CalculatorEngine();
      e.inputDigit('1');
      e.inputDigit('2');
      expect(e.display, '12');
    });

    test('leading zeros collapse', () {
      final e = CalculatorEngine();
      e.inputDigit('0');
      e.inputDigit('0');
      e.inputDigit('5');
      expect(e.display, '5');
    });

    test('decimal as first character defaults to 0.', () {
      final e = CalculatorEngine();
      e.inputDecimal();
      e.inputDigit('5');
      expect(e.display, '0.5');
    });

    test('decimal input ignores a second decimal point', () {
      final e = CalculatorEngine();
      e.inputDigit('1');
      e.inputDecimal();
      e.inputDigit('5');
      e.inputDecimal();
      expect(e.display, '1.5');
    });

    test('basic addition', () {
      final e = CalculatorEngine();
      e.inputDigit('2');
      e.inputOperator('+');
      e.inputDigit('3');
      e.evaluate();
      expect(e.display, '5');
    });

    test('operator precedence: multiplication before addition', () {
      final e = CalculatorEngine();
      e.inputDigit('2');
      e.inputOperator('+');
      e.inputDigit('3');
      e.inputOperator('×');
      e.inputDigit('4');
      e.evaluate();
      expect(e.display, '14');
    });

    test('pressing an operator twice replaces the previous one', () {
      final e = CalculatorEngine();
      e.inputDigit('5');
      e.inputOperator('+');
      e.inputOperator('×');
      e.inputDigit('3');
      e.evaluate();
      expect(e.display, '15');
    });

    test('equals with a trailing operator is a no-op', () {
      final e = CalculatorEngine();
      e.inputDigit('5');
      e.inputOperator('+');
      e.evaluate();
      expect(e.display, '5+');
    });

    test('division by zero shows Error', () {
      final e = CalculatorEngine();
      e.inputDigit('5');
      e.inputOperator('÷');
      e.inputDigit('0');
      e.evaluate();
      expect(e.display, 'Error');
      expect(e.hasError, true);
    });

    test('zero divided by zero shows Error', () {
      final e = CalculatorEngine();
      e.inputDigit('0');
      e.inputOperator('÷');
      e.inputDigit('0');
      e.evaluate();
      expect(e.display, 'Error');
    });

    test('typing a digit after an error resets cleanly', () {
      final e = CalculatorEngine();
      e.inputDigit('5');
      e.inputOperator('÷');
      e.inputDigit('0');
      e.evaluate();
      e.inputDigit('1');
      expect(e.hasError, false);
      expect(e.display, '1');
    });

    test('percent converts the current number', () {
      final e = CalculatorEngine();
      e.inputDigit('5');
      e.inputDigit('0');
      e.inputPercent();
      expect(e.display, '0.5');
    });

    test('backspace removes the last digit', () {
      final e = CalculatorEngine();
      e.inputDigit('1');
      e.inputDigit('2');
      e.inputDigit('3');
      e.backspace();
      expect(e.display, '12');
    });

    test('backspace on an empty current number removes the last operator', () {
      final e = CalculatorEngine();
      e.inputDigit('5');
      e.inputOperator('+');
      e.backspace();
      expect(e.display, '5');
    });

    test('clear resets everything', () {
      final e = CalculatorEngine();
      e.inputDigit('1');
      e.inputOperator('+');
      e.inputDigit('2');
      e.clear();
      expect(e.display, '');
    });

    test('chaining continues from the previous result', () {
      final e = CalculatorEngine();
      e.inputDigit('2');
      e.inputOperator('+');
      e.inputDigit('3');
      e.evaluate();
      e.inputOperator('+');
      e.inputDigit('1');
      e.evaluate();
      expect(e.display, '6');
    });

    test('leading minus allows negative number entry', () {
      final e = CalculatorEngine();
      e.inputOperator('-');
      e.inputDigit('5');
      e.evaluate();
      expect(e.display, '-5');
    });

    test('non-terminating division is rounded to 10 decimals, trimmed', () {
      final e = CalculatorEngine();
      e.inputDigit('1');
      e.inputOperator('÷');
      e.inputDigit('3');
      e.evaluate();
      expect(e.display, '0.3333333333');
    });
  });
}
