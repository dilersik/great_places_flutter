import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places_flutter/providers/great_places_provider.dart';
import 'package:great_places_flutter/widgets/input_image_widget.dart';
import 'package:great_places_flutter/widgets/input_location_widget.dart';
import 'package:provider/provider.dart';

class PlaceFormScreen extends StatefulWidget {
  const PlaceFormScreen({super.key});

  @override
  State<PlaceFormScreen> createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Place')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                onChanged: (value) {
                  // Handle title change
                },
                controller: _titleController,
              ),
              const SizedBox(height: 10),
              InputImageWidget(onImageSelected: (file) => selectImage(file)),
              const SizedBox(height: 20),
              InputLocationWidget(onSelectPlace: () => {}),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => _submitForm(),
                icon: const Icon(Icons.save),
                label: const Text('Save Place'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void selectImage(File image) => setState(() => _pickedImage = image);

  void _submitForm() {
    if (_titleController.text.trim().isEmpty || _pickedImage == null) {
      showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: const Text('Error'),
              content: const Text('Please provide a title and an image.'),
              actions: [TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Okay'))],
            ),
      );
      return;
    }

    Provider.of<GreatPlacesProvider>(context, listen: false).addPlace(_titleController.text, _pickedImage!);

    Navigator.of(context).pop();
  }
}
