import 'package:flutter/material.dart';
import 'result_screen.dart';
import '../models/product.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  Color _getScoreColor(int score) {
    if (score < 40) return Colors.red;
    if (score < 70) return Colors.orange;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    final List<Product> pastScans = [
      Product(
        name: "Oatmeal Cookies",
        brand: "Nature's Best",
        healthScore: 65,
        ingredients: [
          Ingredient(name: "Whole Grain Oats", safetyLevel: "safe", explanation: "A great source of fiber."),
          Ingredient(name: "High Fructose Corn Syrup", safetyLevel: "ultra_processed", explanation: "Highly processed sweetener."),
        ],
      ),
      Product(
        name: "Organic Apple Juice",
        brand: "Fresh Farms",
        healthScore: 92,
        ingredients: [
          Ingredient(name: "Organic Apples", safetyLevel: "safe", explanation: "Completely safe."),
          Ingredient(name: "Water", safetyLevel: "safe", explanation: "Completely safe."),
        ],
      ),
      Product(
        name: "Spicy Nacho Chips",
        brand: "SnackCo",
        healthScore: 24,
        ingredients: [
          Ingredient(name: "Corn Flour", safetyLevel: "safe", explanation: "Standard base ingredient."),
          Ingredient(name: "Red 40", safetyLevel: "harmful", explanation: "Artificial dye."),
          Ingredient(name: "MSG", safetyLevel: "harmful", explanation: "Flavor enhancer linked to headaches in some people."),
        ],
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan History'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: pastScans.length,
        itemBuilder: (context, index) {
          final product = pastScans[index];

          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12.0),
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: _getScoreColor(product.healthScore).withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                  border: Border.all(color: _getScoreColor(product.healthScore), width: 2),
                ),
                alignment: Alignment.center,
                child: Text(
                  '${product.healthScore}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: _getScoreColor(product.healthScore),
                  ),
                ),
              ),
              // Title and Subtitle (middle)
              title: Text(
                product.name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Text('${product.brand} • Scanned recently'),
              // Trailing widget (right side) - An arrow
              trailing: const Icon(Icons.chevron_right, color: Colors.grey),

              // 3. When tapped, open the Result Screen for this specific product
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultScreen(product: product),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}