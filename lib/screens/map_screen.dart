import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places_flutter/models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;

  const MapScreen({super.key, this.initialLocation = const PlaceLocation(latitude: 37.7749, longitude: -122.4194)});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              // Handle save action
            },
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.initialLocation.latitude, widget.initialLocation.longitude),
          zoom: 16,
        ),
      ),
    );
  }
}
