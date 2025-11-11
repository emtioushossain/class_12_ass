import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorLogic {
  static bool isValidInput(String input, String value) {
    // Prevent multiple operators in a row
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
      String finalExp = expression
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('−', '-');
      Parser parser = Parser();
      Expression exp = parser.parse(finalExp);
      double eval = exp.evaluate(EvaluationType.REAL, ContextModel());
      return eval.toStringAsFixed(eval.truncateToDouble() == eval ? 0 : 2);
    } catch (e) {
      return 'Error';
    }
  }
}
