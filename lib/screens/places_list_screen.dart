import 'package:flutter/material.dart';
import 'package:great_places_flutter/providers/great_places_provider.dart';
import 'package:provider/provider.dart';

import '../utils/app_routes_util.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Places'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutesUtil.placeForm);
            },
          ),
        ],
      ),
      body: Consumer<GreatPlacesProvider>(
        builder:
            (ctx, greatPlaces, child) =>
                greatPlaces.placesCount == 0
                    ? const Center(child: Text('No places added yet!'))
                    : ListView.builder(
                      itemCount: greatPlaces.placesCount,
                      itemBuilder:
                          (ctx, i) => ListTile(
                            leading: CircleAvatar(backgroundImage: FileImage(greatPlaces.getPlaceByIndex(i).image)),
                            title: Text(greatPlaces.getPlaceByIndex(i).title),
                            subtitle: Text(greatPlaces.getPlaceByIndex(i).location.address),
                            onTap: () {
                              // Handle place selection
                            },
                          ),
                    ),
      ),
    );
  }
}
