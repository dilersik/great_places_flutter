import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places_flutter/utils/db_util.dart';

import '../models/place.dart';

class GreatPlacesProvider with ChangeNotifier {
  final List<Place> _places = [];

  List<Place> get places => [..._places];

  int get placesCount => _places.length;

  Place getPlaceByIndex(int index) => _places[index];

  void addPlace(String title, File image) {
    final place = Place(
      id: DateTime.timestamp().toString(),
      title: title,
      image: image,
      location: PlaceLocation(latitude: 0, longitude: 0, address: ''),
    );
    _places.add(place);

    DBUtil.upsert(Place.tableName, {'id': place.id, 'title': place.title, 'image': place.image.path});

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
          location: PlaceLocation(latitude: 0, longitude: 0, address: ''),
        );
      }).toList(),
    );
    notifyListeners();
  }
}
