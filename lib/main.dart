import 'package:flutter/material.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const FoodCheckApp());
}

class FoodCheckApp extends StatelessWidget {
  const FoodCheckApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodCheck',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.grey[50],
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}