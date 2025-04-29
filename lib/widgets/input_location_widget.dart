import 'package:flutter/material.dart';
import 'package:great_places_flutter/screens/map_screen.dart';
import 'package:great_places_flutter/utils/location_util.dart';
import 'package:location/location.dart';

class InputLocationWidget extends StatefulWidget {
  const InputLocationWidget({super.key});

  @override
  State<InputLocationWidget> createState() => _InputLocationWidgetState();
}

class _InputLocationWidgetState extends State<InputLocationWidget> {
  String _previewImageUrl = '';

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
              _previewImageUrl.isEmpty
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
    final selectedLocation = await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => MapScreen(), fullscreenDialog: true));
    if (selectedLocation == null) {
      return;
    }
    setState(
      () =>
          _previewImageUrl = LocationUtil.getGoogleMapStaticImageUrl(
            selectedLocation.latitude,
            selectedLocation.longitude,
          ),
    );
  }

  Future<void> _getCurrentUserLocation() async {
    final location = await Location().getLocation();
    if (location.longitude == null || location.latitude == null) {
      return;
    }
    final imageUrl = LocationUtil.getGoogleMapStaticImageUrl(location.latitude!, location.longitude!);
    setState(() => _previewImageUrl = imageUrl);
  }
}
