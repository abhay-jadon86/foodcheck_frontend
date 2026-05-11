import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Allergens',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          const SizedBox(height: 10),

          ...userProvider.allergens.keys.map((String key) {
            return SwitchListTile(
              title: Text(key),
              value: userProvider.allergens[key]!,
              activeColor: Colors.orange,
              onChanged: (bool value) {
                userProvider.updateAllergen(key, value);
              },
            );
          }),

          const Divider(height: 40, thickness: 2),

          const Text(
            'Dietary Preferences',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          const SizedBox(height: 10),

          ...userProvider.diets.keys.map((String key) {
            return SwitchListTile(
              title: Text(key),
              value: userProvider.diets[key]!,
              activeThumbColor: Colors.green,
              onChanged: (bool value) {
                userProvider.updateDiet(key, value);
              },
            );
          }),
        ],
      ),
    );
  }
}