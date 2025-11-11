import 'package:flutter/material.dart';
import 'calc_button.dart';
import 'calculator_logic.dart';

class HomeScreen extends StatefulWidget {
  final bool isDarkTheme;
  final VoidCallback onThemeToggle;

  const HomeScreen({
    super.key,
    required this.isDarkTheme,
    required this.onThemeToggle,
  });

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
      appBar: AppBar(
        title: const Text('Calculator'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(widget.isDarkTheme ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.onThemeToggle,
          ),
        ],
      ),
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
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
                  fontSize: 36,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20, bottom: 20),
              child: Text(
                result,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Buttons Grid
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: buttonLabels.map((row) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: row.map((label) {
                        if (label.isEmpty) return const SizedBox(width: 70);
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
    return widget.isDarkTheme ? Colors.grey[850]! : Colors.grey[300]!;
  }
}
