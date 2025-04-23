import 'package:flutter/material.dart';
import 'package:great_places_flutter/screens/place_form_screen.dart';
import 'package:great_places_flutter/screens/places_list_screen.dart';
import 'package:great_places_flutter/utils/app_routes_util.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Great Places',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          primary: Colors.indigo,
          secondary: Colors.amber,
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          backgroundColor: Colors.indigo,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: const PlacesListScreen(),
      routes: {
        AppRoutesUtil.placeForm: (ctx) => const PlaceFormScreen(),
      },
    );
  }
}
