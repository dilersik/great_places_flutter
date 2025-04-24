import 'package:flutter/material.dart';
import 'package:great_places_flutter/widgets/input_image_widget.dart';

class PlaceFormScreen extends StatefulWidget {
  const PlaceFormScreen({super.key});

  @override
  State<PlaceFormScreen> createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Place')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              onChanged: (value) {
                // Handle title change
              },
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(labelText: 'Location'),
              onChanged: (value) {
                // Handle location change
              },
            ),
            const SizedBox(height: 10),
            InputImageWidget(imagePath: "", onImageSelected: (_) => {}),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Handle save action
              },
              icon: const Icon(Icons.save),
              label: const Text('Save Place'),
            ),
          ],
        ),
      ),
    );
  }
}
