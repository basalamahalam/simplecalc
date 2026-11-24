import 'package:flutter/material.dart';

import '../calculator_engine.dart';
import '../widgets/calculator_button.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorEngine _engine = CalculatorEngine();

  void _onDigit(String digit) => setState(() => _engine.inputDigit(digit));

  void _onDecimal() => setState(() => _engine.inputDecimal());

  void _onOperator(String op) => setState(() => _engine.inputOperator(op));

  void _onPercent() => setState(() => _engine.inputPercent());

  void _onBackspace() => setState(() => _engine.backspace());

  void _onClear() => setState(() => _engine.clear());

  void _onEquals() => setState(() => _engine.evaluate());

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final functionStyle = (
      background: colors.secondaryContainer,
      foreground: colors.onSecondaryContainer,
    );
    final operatorStyle = (
      background: colors.primary,
      foreground: colors.onPrimary,
    );
    final digitStyle = (
      background: colors.surfaceContainerHighest,
      foreground: colors.onSurfaceVariant,
    );

    final displayText = _engine.display.isEmpty ? '0' : _engine.display;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      displayText,
                      key: const Key('calculatorDisplay'),
                      style: const TextStyle(fontSize: 48),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    _buttonRow([
                      CalculatorButton(
                        label: 'C',
                        background: functionStyle.background,
                        foreground: functionStyle.foreground,
                        onPressed: _onClear,
                      ),
                      CalculatorButton(
                        label: '⌫',
                        background: functionStyle.background,
                        foreground: functionStyle.foreground,
                        onPressed: _onBackspace,
                      ),
                      CalculatorButton(
                        label: '%',
                        background: functionStyle.background,
                        foreground: functionStyle.foreground,
                        onPressed: _onPercent,
                      ),
                      CalculatorButton(
                        label: '÷',
                        background: operatorStyle.background,
                        foreground: operatorStyle.foreground,
                        onPressed: () => _onOperator('÷'),
                      ),
                    ]),
                    _buttonRow([
                      for (final d in ['7', '8', '9'])
                        CalculatorButton(
                          label: d,
                          background: digitStyle.background,
                          foreground: digitStyle.foreground,
                          onPressed: () => _onDigit(d),
                        ),
                      CalculatorButton(
                        label: '×',
                        background: operatorStyle.background,
                        foreground: operatorStyle.foreground,
                        onPressed: () => _onOperator('×'),
                      ),
                    ]),
                    _buttonRow([
                      for (final d in ['4', '5', '6'])
                        CalculatorButton(
                          label: d,
                          background: digitStyle.background,
                          foreground: digitStyle.foreground,
                          onPressed: () => _onDigit(d),
                        ),
                      CalculatorButton(
                        label: '−',
                        background: operatorStyle.background,
                        foreground: operatorStyle.foreground,
                        onPressed: () => _onOperator('-'),
                      ),
                    ]),
                    _buttonRow([
                      for (final d in ['1', '2', '3'])
                        CalculatorButton(
                          label: d,
                          background: digitStyle.background,
                          foreground: digitStyle.foreground,
                          onPressed: () => _onDigit(d),
                        ),
                      CalculatorButton(
                        label: '+',
                        background: operatorStyle.background,
                        foreground: operatorStyle.foreground,
                        onPressed: () => _onOperator('+'),
                      ),
                    ]),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: CalculatorButton(
                                label: '0',
                                background: digitStyle.background,
                                foreground: digitStyle.foreground,
                                onPressed: () => _onDigit('0'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: CalculatorButton(
                                label: '.',
                                background: digitStyle.background,
                                foreground: digitStyle.foreground,
                                onPressed: _onDecimal,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: CalculatorButton(
                                label: '=',
                                background: operatorStyle.background,
                                foreground: operatorStyle.foreground,
                                onPressed: _onEquals,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttonRow(List<Widget> buttons) {
    return Expanded(
      child: Row(
        children: [
          for (final button in buttons)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: button,
              ),
            ),
        ],
      ),
    );
  }
}
