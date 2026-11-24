const _operators = {'+', '-', '×', '÷'};

class CalculatorEngine {
  final List<String> _tokens = [];
  String _currentNumber = '';
  bool _hasError = false;
  String _errorDisplay = '';

  bool get hasError => _hasError;

  String get display {
    if (_hasError) return _errorDisplay;
    return _tokens.join() + _currentNumber;
  }

  void inputDigit(String digit) {
    if (_hasError) clear();

    if (_currentNumber == '0') {
      _currentNumber = digit;
    } else if (_currentNumber == '-0') {
      _currentNumber = '-$digit';
    } else {
      _currentNumber += digit;
    }
  }

  void inputDecimal() {
    if (_hasError) clear();

    if (_currentNumber.contains('.')) return;

    if (_currentNumber.isEmpty) {
      _currentNumber = '0.';
    } else if (_currentNumber == '-') {
      _currentNumber = '-0.';
    } else {
      _currentNumber += '.';
    }
  }

  void inputOperator(String op) {
    if (_hasError) clear();

    if (_currentNumber.isNotEmpty) {
      _tokens.add(_currentNumber);
      _tokens.add(op);
      _currentNumber = '';
    } else if (_tokens.isNotEmpty) {
      _tokens[_tokens.length - 1] = op;
    } else if (op == '-') {
      _currentNumber = '-';
    }
  }

  void inputPercent() {
    if (_hasError) clear();

    if (_currentNumber.isEmpty) return;
    final value = double.parse(_currentNumber) / 100;
    _currentNumber = _formatNumber(value);
  }

  void backspace() {
    if (_hasError) {
      clear();
      return;
    }

    if (_currentNumber.isNotEmpty) {
      _currentNumber = _currentNumber.substring(0, _currentNumber.length - 1);
    } else if (_tokens.isNotEmpty) {
      _tokens.removeLast();
    }
  }

  void clear() {
    _tokens.clear();
    _currentNumber = '';
    _hasError = false;
    _errorDisplay = '';
  }

  void evaluate() {
    final full = [..._tokens];
    if (_currentNumber.isNotEmpty) full.add(_currentNumber);

    if (full.isEmpty || _operators.contains(full.last)) return;

    final values = <double>[];
    final ops = <String>[];
    for (final token in full) {
      if (_operators.contains(token)) {
        ops.add(token);
      } else {
        values.add(double.parse(token));
      }
    }

    // First pass: resolve × and ÷ left-to-right.
    final afterMulDiv = <double>[values.first];
    final remainingOps = <String>[];
    var opIndex = 0;
    for (var i = 1; i < values.length; i++) {
      final op = ops[opIndex++];
      if (op == '×') {
        afterMulDiv[afterMulDiv.length - 1] *= values[i];
      } else if (op == '÷') {
        if (values[i] == 0) {
          _setError();
          return;
        }
        afterMulDiv[afterMulDiv.length - 1] /= values[i];
      } else {
        remainingOps.add(op);
        afterMulDiv.add(values[i]);
      }
    }

    // Second pass: resolve + and - left-to-right.
    var result = afterMulDiv.first;
    for (var i = 0; i < remainingOps.length; i++) {
      final next = afterMulDiv[i + 1];
      result = remainingOps[i] == '+' ? result + next : result - next;
    }

    _tokens.clear();
    _currentNumber = _formatNumber(result);
  }

  void _setError() {
    _tokens.clear();
    _currentNumber = '';
    _hasError = true;
    _errorDisplay = 'Error';
  }

  String _formatNumber(double value) {
    if (!value.isFinite) return 'Error';
    var rounded = double.parse(value.toStringAsFixed(10));
    var text = rounded.toString();
    if (text.contains('.')) {
      text = text.replaceFirst(RegExp(r'0+$'), '');
      text = text.replaceFirst(RegExp(r'\.$'), '');
    }
    return text;
  }
}
