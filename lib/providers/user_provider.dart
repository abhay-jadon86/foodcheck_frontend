import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  final Map<String, bool> allergens = {
    'Peanuts': false,
    'Dairy': false,
    'Gluten': false,
    'Soy': false,
  };

  final Map<String, bool> diets = {
    'Vegan': false,
    'Vegetarian': false,
    'Halal': false,
  };

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    for (String key in allergens.keys) {
      allergens[key] = prefs.getBool(key) ?? false;
    }
    for (String key in diets.keys) {
      diets[key] = prefs.getBool(key) ?? false;
    }

    notifyListeners();
  }

  Future<void> updateAllergen(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
    allergens[key] = value;
    notifyListeners();
  }

  Future<void> updateDiet(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
    diets[key] = value;
    notifyListeners();
  }
}