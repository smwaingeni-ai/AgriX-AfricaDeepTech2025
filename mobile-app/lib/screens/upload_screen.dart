import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  File? _image;
  String? _result;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  Future<void> _loadModel() async {
    await Tflite.loadModel(
      model: 'assets/tflite/crop_disease_model.tflite',
      labels: 'assets/tflite/labels.txt',
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        _image = File(picked.path);
        _loading = true;
      });
      await _classifyImage(File(picked.path));
    }
  }

  Future<void> _classifyImage(File image) async {
    final output = await Tflite.runModelOnImage(
      path: image.path,
      imageMean: 127.5,
      imageStd: 127.5,
      numResults: 3,
      threshold: 0.3,
    );

    setState(() {
      _loading = false;
      if (output != null && output.isNotEmpty) {
        final label = output[0]['label'];
        final confidence = (output[0]['confidence'] * 100).toStringAsFixed(1);
        _result = '🌾 Predicted: $label\nConfidence: $confidence%';
      } else {
        _result = '⚠️ Could not classify image.';
      }
    });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload & Diagnose'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Pick Image from Gallery'),
              ),
              const SizedBox(height: 20),
              if (_image != null) Image.file(_image!, height: 200),
              const SizedBox(height: 20),
              if (_loading)
                const CircularProgressIndicator()
              else if (_result != null)
                Text(
                  _result!,
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
