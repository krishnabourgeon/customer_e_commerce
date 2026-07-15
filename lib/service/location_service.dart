import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  LocationService._();

  /// Checks permission and returns current GPS position.
  /// Throws a String error message on failure.
  static Future<Position> getCurrentPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Location services are disabled. Please enable GPS.';
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Location permission denied.';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'Location permissions are permanently denied. Please enable from Settings.';
    }

    return Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 15),
      ),
    );
  }

  /// Converts lat/lng into a readable address string.
  static Future<String> getAddressFromCoordinates(
      double latitude, double longitude) async {
    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isEmpty) return '$latitude, $longitude';
      final p = placemarks.first;
      final parts = [
        if (p.name != null && p.name!.isNotEmpty) p.name,
        if (p.subLocality != null && p.subLocality!.isNotEmpty) p.subLocality,
        if (p.locality != null && p.locality!.isNotEmpty) p.locality,
        if (p.administrativeArea != null && p.administrativeArea!.isNotEmpty)
          p.administrativeArea,
        if (p.postalCode != null && p.postalCode!.isNotEmpty) p.postalCode,
      ];
      return parts.join(', ');
    } catch (_) {
      return '$latitude, $longitude';
    }
  }

  /// Distance in metres between two coordinates.
  static double distanceBetween(
    double startLat, double startLng,
    double endLat,   double endLng,
  ) =>
      Geolocator.distanceBetween(startLat, startLng, endLat, endLng);

  /// Live position stream (fires every 5 s or after 10 m movement).
  static Stream<Position> positionStream({int intervalMs = 5000}) =>
      Geolocator.getPositionStream(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10,
          timeLimit: Duration(milliseconds: intervalMs),
        ),
      );
}