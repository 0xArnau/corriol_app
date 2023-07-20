import 'dart:async';

import 'package:corriol_app/models/user_preferences_model.dart';
import 'package:corriol_app/providers/user_provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeolocationController {
  void _updateIsGpsOnNotifier(UserProvider provider) async {
    final LocationPermission permission = await Geolocator.requestPermission();
    print("checking permissions: $permission");
    switch (permission) {
      case LocationPermission.denied:
        provider.setGpsInfo(false);
        break;
      case LocationPermission.deniedForever:
        provider.setGpsInfo(false);
        break;
      case LocationPermission.unableToDetermine:
        provider.setGpsInfo(false);
        break;
      case LocationPermission.always:
        provider.setGpsInfo(true);
        break;
      case LocationPermission.whileInUse:
        provider.setGpsInfo(true);
        break;
      default:
    }
  }

  bool checkGpsStatus() {
    Geolocator.requestPermission().then((LocationPermission permission) {
      print("checking permissions: $permission");
      switch (permission) {
        case LocationPermission.denied:
          return false;
        case LocationPermission.deniedForever:
          return false;
        case LocationPermission.unableToDetermine:
          return false;
        case LocationPermission.always:
          return true;
        case LocationPermission.whileInUse:
          return true;
        default:
          return true;
      }
    });

    return false;
  }

  Future<void> enableLocationPermission(UserProvider provider) async {
    final preferences = provider.preferences as UserPreferencesModel;
    print("preferences, ${preferences.gps}");
    if (!preferences.gps) {
      final completer = Completer<void>();

      await Geolocator.requestPermission();

      _updateIsGpsOnNotifier(provider);

      if (!preferences.gps) {
        await Geolocator.openAppSettings();

        _updateIsGpsOnNotifier(provider);
      }

      completer.complete(); // Completar el Completer

      return completer.future;
    }
  }

  Future<void> disableLocationPermission(UserProvider provider) async {
    final preferences = provider.preferences as UserPreferencesModel;

    if (preferences.gps) {
      final completer = Completer<void>();

      await Geolocator.openAppSettings();

      completer.future.then((_) {
        _updateIsGpsOnNotifier(provider);
      });

      return completer.future;
    }
  }

  Future<Position> getCurrentLocation(UserProvider provider) async {
    enableLocationPermission(provider);

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<List<String>> updateAddress(UserProvider provider) async {
    final position = provider.position as LatLng;
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    print(placemarks[0]);

    String administrativeArea = placemarks[0].administrativeArea ?? "";
    String subAdministrativeArea = placemarks[0].subAdministrativeArea ?? "";
    String locality = placemarks[0].locality ?? "";

    return [administrativeArea, subAdministrativeArea, locality];
  }
}
