import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FoodCheck',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Weekly Summary Card
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Weekly Health Score',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '85/100',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700],
                      ),
                    ),
                    const Text('Great job making healthy choices!'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  print("Barcode scan tapped");
                },
                icon: const Icon(Icons.qr_code_scanner, size: 40),
                label: const Text(
                  'Scan Barcode',
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[100],
                  foregroundColor: Colors.green[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: Navigate to Photo Scanner
                  print("Photo scan tapped");
                },
                icon: const Icon(Icons.document_scanner_outlined, size: 40),
                label: const Text(
                  'Scan Ingredients',
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[100],
                  foregroundColor: Colors.blue[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}