class CalculatorLogic {
  static bool isValidInput(String input, String value) {
    const ops = '+-*/÷×−';
    if (input.isEmpty && '÷×−+'.contains(value)) return false;
    if (input.isNotEmpty &&
        '÷×−+'.contains(value) &&
        '÷×−+'.contains(input[input.length - 1])) {
      return false;
    }
    return true;
  }

  static String evaluate(String expression) {
    try {
      expression = expression
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('−', '-');
      final tokens = _tokenize(expression);
      final rpn = _toRPN(tokens);
      final result = _evalRPN(rpn);
      if (result == result.truncateToDouble()) {
        return result.toInt().toString();
      }
      return result.toStringAsFixed(2);
    } catch (_) {
      return 'Error';
    }
  }

  static List<String> _tokenize(String expr) {
    final tokens = <String>[];
    final buffer = StringBuffer();
    const ops = '+-*/()';
    for (var ch in expr.split('')) {
      if (ops.contains(ch)) {
        if (buffer.isNotEmpty) {
          tokens.add(buffer.toString());
          buffer.clear();
        }
        tokens.add(ch);
      } else {
        buffer.write(ch);
      }
    }
    if (buffer.isNotEmpty) tokens.add(buffer.toString());
    return tokens;
  }

  static List<String> _toRPN(List<String> tokens) {
    final output = <String>[];
    final stack = <String>[];

    int precedence(String op) => (op == '+' || op == '-') ? 1 : 2;
    bool isOp(String t) => '+-*/'.contains(t);

    for (var token in tokens) {
      if (isOp(token)) {
        while (stack.isNotEmpty &&
            isOp(stack.last) &&
            precedence(stack.last) >= precedence(token)) {
          output.add(stack.removeLast());
        }
        stack.add(token);
      } else {
        output.add(token);
      }
    }
    output.addAll(stack.reversed);
    return output;
  }

  static double _evalRPN(List<String> rpn) {
    final stack = <double>[];
    for (var token in rpn) {
      if ('+-*/'.contains(token)) {
        final b = stack.removeLast();
        final a = stack.removeLast();
        switch (token) {
          case '+':
            stack.add(a + b);
            break;
          case '-':
            stack.add(a - b);
            break;
          case '*':
            stack.add(a * b);
            break;
          case '/':
            stack.add(a / b);
            break;
        }
      } else {
        stack.add(double.parse(token));
      }
    }
    return stack.single;
  }
}
