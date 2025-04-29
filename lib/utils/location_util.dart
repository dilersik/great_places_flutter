const _googleApiKey = '';

class LocationUtil {
  /// Generates a Google Maps static image URL for the given latitude and longitude.
  static String getGoogleMapStaticImageUrl(double latitude, double longitude, {int width = 600, int height = 400}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&'
        'size=${width}x$height&markers=color:red%7Clabel:C%7C$latitude,$longitude'
        '&key=$_googleApiKey';
  }
}
