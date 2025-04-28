import 'package:flutter/material.dart';
import 'package:location/location.dart';

class InputLocationWidget extends StatefulWidget {
  final Function onSelectPlace;

  const InputLocationWidget({super.key, required this.onSelectPlace});

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
              onPressed: () {
                _getCurrentUserLocation();
                widget.onSelectPlace('https://example.com/current-location');
              },
            ),
            TextButton.icon(
              icon: const Icon(Icons.map),
              label: const Text('Select on map'),
              onPressed: () {
                // Logic to select location on map
                widget.onSelectPlace('https://example.com/location');
              },
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _getCurrentUserLocation() async {
    final location = await Location().getLocation();

  }
}
