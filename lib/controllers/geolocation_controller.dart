import 'package:corriol_app/models/user_preferences_model.dart';
import 'package:corriol_app/providers/user_provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeolocationController {
  LocationPermission? _permission;

  void _updateIsGpsOnNotifier() {
    switch (_permission) {
      case LocationPermission.denied:
        UserProvider().setGpsInfo(false);
        break;
      case LocationPermission.deniedForever:
        UserProvider().setGpsInfo(false);
        break;
      case LocationPermission.unableToDetermine:
        UserProvider().setGpsInfo(false);
        break;
      case LocationPermission.always:
        UserProvider().setGpsInfo(true);
        break;
      case LocationPermission.whileInUse:
        UserProvider().setGpsInfo(true);
        break;
      default:
    }
  }

  void enableLocationPermission() async {
    final preferences = UserProvider().preferences as UserPreferencesModel;
    if (preferences.gps) {
      _permission = await Geolocator.requestPermission();
      _updateIsGpsOnNotifier();
      if (!preferences.gps) {
        await Geolocator.openLocationSettings();
        _permission = await Geolocator.checkPermission();
      }
    }

    _updateIsGpsOnNotifier();
  }

  void disableLocationPermission() async {
    final preferences = UserProvider().preferences as UserPreferencesModel;
    if (preferences.gps) {
      // await Geolocator.openAppSettings();
      await Geolocator.openLocationSettings();
      _permission = await Geolocator.checkPermission();
    }

    _updateIsGpsOnNotifier();
  }

  Future<Position> getCurrentLocation() async {
    enableLocationPermission();

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<List<String>> updateAddress() async {
    final position = UserProvider().position as LatLng;
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    print(placemarks[0]);

    String administrativeArea = placemarks[0].administrativeArea ?? "none";
    String subAdministrativeArea =
        placemarks[0].subAdministrativeArea ?? "none";
    String locality = placemarks[0].locality ?? "none";

    return [administrativeArea, subAdministrativeArea, locality];
  }
}
