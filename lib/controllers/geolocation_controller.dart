import 'dart:async';

import 'package:corriol_app/generated/l10n.dart';
import 'package:corriol_app/models/user_preferences_model.dart';
import 'package:corriol_app/providers/user_provider.dart';
import 'package:corriol_app/utils/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

/// Controller class for handling geolocation-related operations.
class GeolocationController {
  /// Updates the GPS status in the [UserProvider] based on the current location permission.
  ///
  /// The [provider] is the instance of the [UserProvider] that holds the user's [UserPreferencesModel.gps].
  void _updateIsGpsOnNotifier(BuildContext context, UserProvider provider) {
    Geolocator.requestPermission().then((permission) {
      switch (permission) {
        case LocationPermission.denied:
          provider.setGpsInfo(context, false);
          break;
        case LocationPermission.deniedForever:
          provider.setGpsInfo(context, false);
          break;
        case LocationPermission.unableToDetermine:
          provider.setGpsInfo(context, false);
          break;
        case LocationPermission.always:
          provider.setGpsInfo(context, true);
          break;
        case LocationPermission.whileInUse:
          provider.setGpsInfo(context, true);
          break;
        default:
      }
    });
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
  void enableLocationPermission(BuildContext context, UserProvider provider) {
    final preferences = provider.preferences as UserPreferencesModel;
    if (!preferences.gps) {
      _updateIsGpsOnNotifier(context, provider);
    }
  }

  /// Disables location permission for the user.
  ///
  /// The [provider] is the instance of the [UserProvider] that holds the [UserPreferencesModel] and modify the [UserPreferencesModel.gps].
  Future<void> disableLocationPermission(
      BuildContext context, UserProvider provider) async {
    final preferences = provider.preferences as UserPreferencesModel;

    if (preferences.gps) {
      Geolocator.openAppSettings().then((status) {
        if (status) {
          updateGpsPermission(context, provider);
        }
      });
    }
  }

  Future<void> updateGpsPermission(
      BuildContext context, UserProvider provider) async {
    final location = Permission.location.isGranted;
    final locationAlways = Permission.locationAlways.isGranted;
    final locationWhenInUse = Permission.locationWhenInUse.isGranted;

    Future.wait([
      location,
      locationAlways,
      locationWhenInUse,
    ]).then((value) {
      Provider.of<UserProvider>(context, listen: false)
          .setGpsInfo(context, value.any((status) => status));
    });
  }

  /// Open the app settings
  ///
  /// The [provider] is the instance of the [UserProvider] that holds the [UserPreferencesModel] and modify the [UserPreferencesModel.gps].
  Future<void> openAppSettings(
      BuildContext context, UserProvider provider) async {
    Geolocator.openAppSettings().then((_) => provider.fetchGpsInfo());
  }

  /// Gets the current user's location.
  ///
  /// The [provider] is the instance of the [UserProvider] that holds the [UserPreferencesModel].
  ///
  /// Returns the [Position] object containing the user's current location, or `null` if location permission is not granted.
  Future<Position?> getCurrentLocation(
      BuildContext context, UserProvider provider) async {
    enableLocationPermission(context, provider);

    if (!provider.preferences.gps) return null;

    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      Logger().e(e);
      snackbarError(context, S.current.errorGps);
      return null;
    }
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
