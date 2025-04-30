import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class LocationUtil {
  /// Generates a Google Maps static image URL for the given latitude and longitude.
  static String getGoogleMapStaticImageUrl(double latitude, double longitude, {int width = 600, int height = 400}) {
    return 'https://maps.googleapis.com/maps/api/staticmap'
        '?center=$latitude,$longitude&zoom=16'
        '&size=${width}x$height&markers=color:red%7Clabel:C%7C$latitude,$longitude'
        '&key=$_googleApiKey';
  }

  static Future<String> getAddressFromLatLng(LatLng location) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json'
          '?latlng=${location.latitude},${location.longitude}'
          '&key=$_googleApiKey',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['results'].isNotEmpty && data['status'] == 'OK') {
        return data['results'][0]['formatted_address'];
      } else if (data['results'].isEmpty) {
        throw Exception('No address found for the given coordinates.');
      } else {
        throw Exception('Failed to retrieve address: ${data['error_message']}');
      }
    } else {
      throw Exception('Failed to load address: ${response.statusCode}');
    }
  }
}


const _googleApiKey = '';
