import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  LatLng? _pickedLocation;

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
                controller: _titleController,
                onChanged: (text) => setState(() {}),
              ),
              const SizedBox(height: 10),
              InputImageWidget(onImageSelected: (file) => _selectImage(file)),
              const SizedBox(height: 20),
              InputLocationWidget(onSelectLocation: (location) => _selectLocation(location)),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _isValidForm() ? _submitForm : null,
                icon: const Icon(Icons.save),
                label: const Text('Save Place'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectImage(File image) => setState(() => _pickedImage = image);

  void _selectLocation(LatLng location) => setState(() => _pickedLocation = location);

  bool _isValidForm() => _titleController.text.trim().isNotEmpty && _pickedImage != null && _pickedLocation != null;

  Future<void> _submitForm() async {
    if (!_isValidForm()) {
      showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: const Text('Error'),
              content: const Text('Please provide a title, an image and a location.'),
              actions: [TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Okay'))],
            ),
      );
      return;
    }

    final provider = Provider.of<GreatPlacesProvider>(context, listen: false);
    try {
      await provider.addPlace(_titleController.text, _pickedImage!, _pickedLocation!);
    } catch (error) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: const Text('Error'),
              content: Text('An error occurred while saving the place: ${error.toString()}'),
              actions: [TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Okay'))],
            ),
      );
      return;
    }
    if (!mounted) return;
    Navigator.of(context).pop();
  }
}
