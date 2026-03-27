import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../models/product.dart';

class ResultScreen extends StatelessWidget {
  final Product product;

  const ResultScreen({super.key, required this.product});

  Color _getIngredientColor(String safetyLevel) {
    switch (safetyLevel) {
      case 'harmful':
        return Colors.red[100]!;
      case 'allergen':
        return Colors.orange[100]!;
      case 'ultra_processed':
        return Colors.yellow[100]!;
      case 'safe':
      default:
        return Colors.green[100]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Result'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Text(
              product.brand,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            SizedBox(
              height: 250,
              child: SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 0,
                    maximum: 100,
                    ranges: <GaugeRange>[
                      GaugeRange(startValue: 0, endValue: 40, color: Colors.red),
                      GaugeRange(startValue: 40, endValue: 70, color: Colors.orange),
                      GaugeRange(startValue: 70, endValue: 100, color: Colors.green)
                    ],
                    pointers: <GaugePointer>[
                      NeedlePointer(value: product.healthScore.toDouble())
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Text(
                          '${product.healthScore}',
                          style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                        ),
                        angle: 90,
                        positionFactor: 0.5,
                      )
                    ],
                  )
                ],
              ),
            ),

            const Text(
              'Ingredients Analysis',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: product.ingredients.length,
              itemBuilder: (context, index) {
                final ingredient = product.ingredients[index];
                return Card(
                  color: _getIngredientColor(ingredient.safetyLevel),
                  child: ExpansionTile(
                    title: Text(
                      ingredient.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(ingredient.explanation),
                      )
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 30),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[100]),
                    child: const Text('Find Alternatives'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green[100]),
                    child: const Text('Save to History'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}