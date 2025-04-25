import 'dart:io';

import 'package:flutter/material.dart';

import '../models/place.dart';

class GreatPlacesProvider with ChangeNotifier {
  final List<Place> _places = [];
  List<Place> get places => [..._places];

  int get placesCount => _places.length;

  Place getPlaceByIndex(int index) => _places[index];

  void addPlace(String title, File image) {
    final newPlace = Place(
      id: DateTime.timestamp().toString(),
      title: title,
      image: image,
      location: PlaceLocation(
        latitude: 0,
        longitude: 0,
        address: '',
      ),
    );
    _places.add(newPlace);
    notifyListeners();
  }
}