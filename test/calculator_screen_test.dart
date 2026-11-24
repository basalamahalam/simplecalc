import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simplecalc/main.dart';

void main() {
  testWidgets('tapping digits updates the display', (tester) async {
    await tester.pumpWidget(const SimpleCalcApp());
    await tester.tap(find.text('2'));
    await tester.tap(find.text('3'));
    await tester.pump();
    expect(find.text('23'), findsOneWidget);
  });

  testWidgets('full calculation with precedence via the UI', (tester) async {
    await tester.pumpWidget(const SimpleCalcApp());
    await tester.tap(find.text('2'));
    await tester.tap(find.text('+'));
    await tester.tap(find.text('3'));
    await tester.tap(find.text('×'));
    await tester.tap(find.text('4'));
    await tester.tap(find.text('='));
    await tester.pump();
    expect(find.text('14'), findsOneWidget);
  });

  testWidgets('C button clears the display back to 0', (tester) async {
    await tester.pumpWidget(const SimpleCalcApp());
    await tester.tap(find.text('5'));
    await tester.tap(find.text('C'));
    await tester.pump();
    final displayFinder = find.byKey(const Key('calculatorDisplay'));
    expect(displayFinder, findsOneWidget);
    expect(tester.widget<Text>(displayFinder).data, '0');
  });
}
