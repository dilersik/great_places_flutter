import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places_flutter/utils/db_util.dart';

import '../models/place.dart';
import '../utils/location_util.dart';

class GreatPlacesProvider with ChangeNotifier {
  final List<Place> _places = [];

  List<Place> get places => [..._places];

  int get placesCount => _places.length;

  Place getPlaceByIndex(int index) => _places[index];

  Future<void> addPlace(String title, File image, LatLng location) async {
    final address = await LocationUtil.getAddressFromLatLng(location);
    final place = Place(
      id: DateTime.timestamp().toString(),
      title: title,
      image: image,
      location: PlaceLocation(latitude: location.latitude, longitude: location.longitude, address: address),
    );
    _places.add(place);

    DBUtil.upsert(Place.tableName, {
      'id': place.id,
      'title': place.title,
      'image': place.image.path,
      'latitude': place.location.latitude,
      'longitude': place.location.longitude,
      'address': place.location.address,
    });

    notifyListeners();
  }

  Future<void> fetchPlaces() async {
    final dataList = await DBUtil.select(Place.tableName);
    _places.clear();
    _places.addAll(
      dataList.map((data) {
        return Place(
          id: data['id'],
          title: data['title'],
          image: File(data['image']),
          location: PlaceLocation(
            latitude: data['latitude'],
            longitude: data['longitude'],
            address: data['address'],
          ),
        );
      }).toList(),
    );
    notifyListeners();
  }
}
