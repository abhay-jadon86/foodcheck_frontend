class Ingredient {
  final String name;
  final String safetyLevel; // 'safe', 'harmful', 'allergen', 'ultra_processed'
  final String explanation;

  Ingredient({
    required this.name,
    required this.safetyLevel,
    required this.explanation,
  });
}

class Product {
  final String name;
  final String brand;
  final int healthScore;
  final List<Ingredient> ingredients;

  Product({
    required this.name,
    required this.brand,
    required this.healthScore,
    required this.ingredients,
  });
}