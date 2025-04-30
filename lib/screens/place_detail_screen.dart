import 'package:flutter/material.dart';
import 'package:great_places_flutter/models/place.dart';

import 'map_screen.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final place = ModalRoute.of(context)!.settings.arguments as Place;

    return Scaffold(
      appBar: AppBar(title: Text(place.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.file(place.image, fit: BoxFit.cover, height: 250, width: double.infinity),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(place.location.address, style: const TextStyle(fontSize: 20), textAlign: TextAlign.center),
            ),
            const SizedBox(height: 20),
            Text(
              'Latitude: ${place.location.latitude}, Longitude: ${place.location.longitude}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            TextButton.icon(
              icon: const Icon(Icons.map),
              label: const Text('View on Map'),
              style: TextButton.styleFrom(textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              onPressed:
                  () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => MapScreen(isReadOnly: true, initialLocation: place.location),
                      fullscreenDialog: true,
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
