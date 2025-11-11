import 'package:flutter/material.dart';
import 'calc_button.dart';
import 'calculator_logic.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String input = '';
  String result = '0';

  void buttonPressed(String value) {
    setState(() {
      if (value == 'AC') {
        input = '';
        result = '0';
      } else if (value == '=') {
        result = CalculatorLogic.evaluate(input);
        input = result;
      } else {
        if (CalculatorLogic.isValidInput(input, value)) {
          input += value;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final buttonLabels = [
      ['AC', '÷', '×', '−'],
      ['7', '8', '9', '+'],
      ['4', '5', '6', ''],
      ['1', '2', '3', '='],
      ['0', '.', '', '']
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Display Section
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                input,
                style: const TextStyle(color: Colors.white70, fontSize: 36),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20, bottom: 20),
              child: Text(
                result,
                style: const TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
            // Buttons Grid
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: buttonLabels.map((row) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: row.map((label) {
                        if (label.isEmpty) {
                          return const SizedBox(width: 70);
                        }
                        return CalcButton(
                          text: label,
                          onPressed: () => buttonPressed(label),
                          color: _getButtonColor(label),
                        );
                      }).toList(),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getButtonColor(String label) {
    if (label == 'AC') return Colors.redAccent;
    if (label == '=') return Colors.orangeAccent;
    if ('÷×−+'.contains(label)) return Colors.blueGrey;
    return Colors.grey[850]!;
  }
}
