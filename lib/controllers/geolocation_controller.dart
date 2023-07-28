import 'dart:async';

import 'package:corriol_app/models/user_preferences_model.dart';
import 'package:corriol_app/providers/user_provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';

/// Controller class for handling geolocation-related operations.
class GeolocationController {
  /// Updates the GPS status in the [UserProvider] based on the current location permission.
  ///
  /// The [provider] is the instance of the [UserProvider] that holds the user's [UserPreferencesModel.gps].
  void _updateIsGpsOnNotifier(UserProvider provider) async {
    final LocationPermission permission = await Geolocator.requestPermission();
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

  /// Checks the current location permission status.
  ///
  /// Returns `true` if GPS is enabled, otherwise `false`.
  bool checkGpsStatus() {
    Geolocator.requestPermission().then((LocationPermission permission) {
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

  /// Requests and enables location permission for the user.
  ///
  /// The [provider] is the instance of the [UserProvider] that holds the [UserPreferencesModel] and modify the [UserPreferencesModel.gps].
  Future<void> enableLocationPermission(UserProvider provider) async {
    final preferences = provider.preferences as UserPreferencesModel;
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

  /// Disables location permission for the user.
  ///
  /// The [provider] is the instance of the [UserProvider] that holds the [UserPreferencesModel] and modify the [UserPreferencesModel.gps].
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

  /// Gets the current user's location.
  ///
  /// The [provider] is the instance of the [UserProvider] that holds the [UserPreferencesModel].
  ///
  /// Returns the [Position] object containing the user's current location, or `null` if location permission is not granted.
  Future<Position?> getCurrentLocation(UserProvider provider) async {
    enableLocationPermission(provider);

    if (!provider.preferences.gps) return null;

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  /// Updates the user's address based on the current [LatLng].
  ///
  /// The [provider] is the instance of the [UserProvider] that holds the current user's [UserProvider.position].
  ///
  /// Returns a [List] of [String] containing the administrativeArea, subAdministrativeArea, and locality, or empty strings if an error occurs.
  Future<List<String>> updateAddress(UserProvider provider) async {
    try {
      final position = provider.position as LatLng;
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      String administrativeArea = placemarks[0].administrativeArea ?? "";
      String subAdministrativeArea = placemarks[0].subAdministrativeArea ?? "";
      String locality = placemarks[0].locality ?? "";

      return [administrativeArea, subAdministrativeArea, locality];
    } catch (e) {
      Logger().e(e);
      return ['', '', ''];
    }
  }

  /// Gets the [LatLng] from the given address.
  ///
  /// The [address] is the string representation of the address to be converted to [LatLng].
  ///
  /// Returns the [LatLng] coordinates if successful, otherwise returns the default coordinates (Catalunya).
  Future<LatLng> getLatLngFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        Location location = locations[0];
        LatLng latLng = LatLng(location.latitude, location.longitude);
        return latLng;
      } else {
        return const LatLng(41.8205, 1.8401);
      }
    } catch (e) {
      Logger().e(e);
      return const LatLng(41.8205, 1.8401);
    }
  }
}
