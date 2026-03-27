import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'result_screen.dart';
import '../models/product.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  bool _isProcessing = false;

  final MobileScannerController cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Product Barcode'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
          actions: [
            IconButton(
              color: Colors.white,
              icon: ValueListenableBuilder(
                valueListenable: cameraController,
                builder: (context, state, child) {
                  switch (state.torchState) {
                    case TorchState.on:
                      return const Icon(Icons.flash_on, color: Colors.yellow);
                    case TorchState.off:
                      return const Icon(Icons.flash_off, color: Colors.grey);
                    case TorchState.auto:
                      return const Icon(Icons.flash_auto, color: Colors.white);
                    case TorchState.unavailable:
                      return const Icon(Icons.flash_off, color: Colors.white30);
                  }
                },
              ),
              iconSize: 32.0,
              onPressed: () => cameraController.toggleTorch(),
            ),
          ],
      ),
      body: MobileScanner(
        controller: cameraController,
        onDetect: (capture) {
          if (_isProcessing) return;

          final List<Barcode> barcodes = capture.barcodes;

          if (barcodes.isNotEmpty) {
            final String? barcodeValue = barcodes.first.rawValue;

            if (barcodeValue != null) {
              setState(() {
                _isProcessing = true; // Lock the scanner
              });

              print('🎉 Barcode found! $barcodeValue');

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Scanned: $barcodeValue'),
                  backgroundColor: Colors.green,
                ),
              );

              final dummyProduct = Product(
                name: "Oatmeal Cookies",
                brand: "Nature's Best",
                healthScore: 65,
                ingredients: [
                  Ingredient(name: "Whole Grain Oats", safetyLevel: "safe", explanation: "A great source of fiber."),
                  Ingredient(name: "High Fructose Corn Syrup", safetyLevel: "ultra_processed", explanation: "Highly processed sweetener linked to obesity."),
                  Ingredient(name: "Peanut Butter", safetyLevel: "allergen", explanation: "Flagged based on your allergy profile."),
                  Ingredient(name: "Red 40", safetyLevel: "harmful", explanation: "Artificial dye linked to hyperactivity in children."),
                ],
              );

              Future.delayed(const Duration(milliseconds: 500), () {
                if (mounted) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultScreen(product: dummyProduct),
                    ),
                  );
                }
              });
            }
          }
        },
      ),
    );
  }
}