import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places_flutter/models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isReadOnly;

  const MapScreen({
    super.key,
    this.initialLocation = const PlaceLocation(latitude: 37.7749, longitude: -122.4194),
    this.isReadOnly = false,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
        actions: [
          if (!widget.isReadOnly)
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: _pickedPosition == null ? null : () => Navigator.of(context).pop(_pickedPosition),
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.initialLocation.latitude, widget.initialLocation.longitude),
          zoom: 16,
        ),
        onTap: widget.isReadOnly ? null : (LatLng position) => _selectPosition(position),
        markers:
            (_pickedPosition == null && !widget.isReadOnly)
                ? {}
                : {
                  Marker(markerId: const MarkerId('m1'), position: _pickedPosition ?? widget.initialLocation.toLatLng),
                },
      ),
    );
  }

  void _selectPosition(LatLng position) => setState(() => _pickedPosition = position);
}
