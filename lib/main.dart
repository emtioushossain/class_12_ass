import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isDark = prefs.getBool('isDarkMode') ?? true;
  runApp(CalculatorApp(isDark: isDark));
}

class CalculatorApp extends StatefulWidget {
  final bool isDark;
  const CalculatorApp({super.key, required this.isDark});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  late bool isDarkTheme;

  @override
  void initState() {
    super.initState();
    isDarkTheme = widget.isDark;
  }

  void toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkTheme = !isDarkTheme;
    });
    prefs.setBool('isDarkMode', isDarkTheme);
  }

  @override
  Widget build(BuildContext context) {
    final darkTheme = ThemeData.dark().copyWith(
      colorScheme: const ColorScheme.dark(primary: Colors.blueGrey),
      scaffoldBackgroundColor: Colors.black,
    );

    final lightTheme = ThemeData.light().copyWith(
      colorScheme: const ColorScheme.light(primary: Colors.blue),
      scaffoldBackgroundColor: Colors.grey[200],
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Calculator',
      theme: isDarkTheme ? darkTheme : lightTheme,
      home: HomeScreen(
        isDarkTheme: isDarkTheme,
        onThemeToggle: toggleTheme,
      ),
    );
  }
}
