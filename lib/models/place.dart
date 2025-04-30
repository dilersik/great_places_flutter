import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place {
  static const String tableName = 'places';
  final String id;
  final String title;
  final PlaceLocation location;
  final File image;

  const Place({
    required this.id,
    required this.title,
    required this.location,
    required this.image,
  });
}

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  const PlaceLocation({
    required this.latitude,
    required this.longitude,
    this.address = '',
  });

  LatLng get toLatLng => LatLng(latitude, longitude);
}