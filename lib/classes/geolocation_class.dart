import 'package:corriol_app/core/notifiers.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GeolocationClass {
  LocationPermission? _permission;

  void _updateIsGpsOnNotifier() {
    switch (_permission) {
      case LocationPermission.denied:
        isGpsOnNotifier.value = false;
        break;
      case LocationPermission.deniedForever:
        isGpsOnNotifier.value = false;
        break;
      case LocationPermission.unableToDetermine:
        isGpsOnNotifier.value = false;
        break;
      case LocationPermission.always:
        isGpsOnNotifier.value = true;
        break;
      case LocationPermission.whileInUse:
        isGpsOnNotifier.value = true;
        break;
      default:
    }

    isGpsOnNotifier.notifyListeners();
  }

  void enableLocationPermission() async {
    if (!isGpsOnNotifier.value) {
      _permission = await Geolocator.requestPermission();
      _updateIsGpsOnNotifier();
      if (!isGpsOnNotifier.value) {
        await Geolocator.openLocationSettings();
        _permission = await Geolocator.checkPermission();
      }
    }

    _updateIsGpsOnNotifier();
  }

  void disableLocationPermission() async {
    if (isGpsOnNotifier.value) {
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
    List<Placemark> placemarks = await placemarkFromCoordinates(
      currentPositionNotifier.value.latitude,
      currentPositionNotifier.value.longitude,
    );

    print(placemarks[0]);

    String administrativeArea = placemarks[0].administrativeArea ?? "none";
    String subAdministrativeArea =
        placemarks[0].subAdministrativeArea ?? "none";
    String locality = placemarks[0].locality ?? "none";

    return [administrativeArea, subAdministrativeArea, locality];
  }
}
