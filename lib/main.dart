import 'package:flutter/material.dart';
import 'package:weather_app/screens/screens.dart';

void main() {
  runApp(const MyApp());
}

/// {@template my_app}
/// The main application widget.
/// {@endtemplate}
class MyApp extends StatelessWidget {
  /// {@macro my_app}
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: AppBarTheme(backgroundColor: Colors.deepPurple.shade300),
      ),
      home: HomeScreen.route(),
    );
  }
}
