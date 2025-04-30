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
      body: FutureBuilder(
        future: Provider.of<GreatPlacesProvider>(context, listen: false).fetchPlaces(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('An error occurred!'));
          } else {
            return Consumer<GreatPlacesProvider>(
              builder:
                  (ctx, greatPlaces, child) =>
                      greatPlaces.placesCount == 0
                          ? const Center(child: Text('No places added yet!'))
                          : ListView.builder(
                            itemCount: greatPlaces.placesCount,
                            itemBuilder: (ctx, i) {
                              final place = greatPlaces.getPlaceByIndex(i);
                              return ListTile(
                                leading: CircleAvatar(backgroundImage: FileImage(place.image)),
                                title: Text(place.title),
                                subtitle: Text(place.location.address),
                                onTap:
                                    () => Navigator.of(context).pushNamed(AppRoutesUtil.placeDetail, arguments: place),
                              );
                            },
                          ),
            );
          }
        },
      ),
    );
  }
}
