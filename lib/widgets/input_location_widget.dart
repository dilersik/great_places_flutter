import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places_flutter/screens/map_screen.dart';
import 'package:great_places_flutter/utils/location_util.dart';
import 'package:location/location.dart';

class InputLocationWidget extends StatefulWidget {
  final Function onSelectLocation;

  const InputLocationWidget({super.key, required this.onSelectLocation});

  @override
  State<InputLocationWidget> createState() => _InputLocationWidgetState();
}

class _InputLocationWidgetState extends State<InputLocationWidget> {
  String _previewImageUrl = '';
  bool _isPreviewImageUrlLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child:
              _isPreviewImageUrlLoading
                  ? const CircularProgressIndicator()
                  : _previewImageUrl.isEmpty
                  ? const Text('No location chosen')
                  : Image.network(_previewImageUrl, fit: BoxFit.cover, width: double.infinity),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              label: const Text('Use current location'),
              onPressed: () => _getCurrentUserLocation(),
            ),
            TextButton.icon(
              icon: const Icon(Icons.map),
              label: const Text('Select on map'),
              onPressed: () => _selectOnMap(),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _selectOnMap() async {
    setState(() => _isPreviewImageUrlLoading = true);
    final selectedLocation = await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => MapScreen(), fullscreenDialog: true));
    if (selectedLocation == null) {
      return;
    }
    _showLocationPreview(selectedLocation.latitude, selectedLocation.longitude);

    widget.onSelectLocation(LatLng(selectedLocation.latitude, selectedLocation.longitude));
  }

  void _showLocationPreview(double latitude, double longitude) => setState(() {
      _previewImageUrl = LocationUtil.getGoogleMapStaticImageUrl(latitude, longitude);
      _isPreviewImageUrlLoading = false;
    });

  Future<void> _getCurrentUserLocation() async {
    setState(() => _isPreviewImageUrlLoading = true);
    final location = await Location().getLocation();
    if (location.longitude == null || location.latitude == null) {
      return;
    }

    widget.onSelectLocation(LatLng(location.latitude!, location.longitude!));

    final imageUrl = LocationUtil.getGoogleMapStaticImageUrl(location.latitude!, location.longitude!);
    _showLocationPreview(location.latitude!, location.longitude!);
  }
}
