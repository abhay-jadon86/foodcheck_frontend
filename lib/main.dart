import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/main_screen.dart';
import 'providers/user_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()..loadPreferences()),
      ],
      child: const FoodCheckApp(),
    ),
  );
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