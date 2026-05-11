import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'result_screen.dart';
import '../models/product.dart';

class PhotoScannerScreen extends StatefulWidget {
  const PhotoScannerScreen({super.key});

  @override
  State<PhotoScannerScreen> createState() => _PhotoScannerScreenState();
}

class _PhotoScannerScreenState extends State<PhotoScannerScreen> {
  File? _selectedImage;
  bool _isAnalyzing = false;
  final ImagePicker _picker = ImagePicker();

  Future<void> _takePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _selectedImage = File(photo.path);
      });
    }
  }

  Future<void> _pickFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  void _analyzeImage() {
    if (_selectedImage == null) return;

    setState(() {
      _isAnalyzing = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      setState(() {
        _isAnalyzing = false;
      });

      final dummyProduct = Product(
        name: "Unknown Product",
        brand: "Scanned from image",
        healthScore: 45,
        ingredients: [
          Ingredient(name: "Enriched Wheat Flour", safetyLevel: "allergen", explanation: "Contains gluten."),
          Ingredient(name: "Sugar", safetyLevel: "ultra_processed", explanation: "High amount of added sugar."),
          Ingredient(name: "Sodium Benzoate", safetyLevel: "harmful", explanation: "Chemical preservative."),
          Ingredient(name: "Water", safetyLevel: "safe", explanation: "Completely safe."),
        ],
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(product: dummyProduct),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Ingredients'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey[400]!),
                ),
                child: _selectedImage != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(_selectedImage!, fit: BoxFit.cover),
                )
                    : const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image_search, size: 80, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'Take a photo of the ingredient list',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isAnalyzing ? null : _takePhoto,
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Camera'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isAnalyzing ? null : _pickFromGallery,
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Gallery'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            if (_selectedImage != null)
              ElevatedButton(
                onPressed: _isAnalyzing ? null : _analyzeImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isAnalyzing
                    ? const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                    ),
                    SizedBox(width: 16),
                    Text('Extracting text...', style: TextStyle(fontSize: 18)),
                  ],
                )
                    : const Text('Analyze Ingredients', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
          ],
        ),
      ),
    );
  }
}