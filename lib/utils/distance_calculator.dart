import 'dart:developer';

import 'package:geolocator/geolocator.dart';

/// Calculates the distance between the current position and
/// a given position.
/// Returns the distance in meters.
Future<double> calculateDistance(double latitude, double longitude) async {
  double _distance;
  var  distanceFuture = await determinePosition().catchError((err) {
        log(err, time: DateTime.now());
      }
  );
  _distance = (Geolocator.distanceBetween(
      latitude, longitude, distanceFuture.latitude, distanceFuture.longitude) / 1000).floorToDouble();
  return _distance;
}

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
/// CODE COPIED FROM: https://pub.dev/packages/geolocator
Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      return Future.error(
          'Location permissions are denied (actual value: $permission).');
    }
  }

  return await Geolocator.getCurrentPosition();
}
