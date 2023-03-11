import 'package:corriol_app/core/notifiers.dart';
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
  }

  void enableLocationPermission() async {
    _permission = await Geolocator.checkPermission();
    _updateIsGpsOnNotifier();

    if (!isGpsOnNotifier.value) {
      _permission = await Geolocator.requestPermission();
      _updateIsGpsOnNotifier();
      if (!isGpsOnNotifier.value) {
        await Geolocator.openLocationSettings();
      }
    }
  }

  void disableLocationPermission() async {
    if (isGpsOnNotifier.value) {
      // await Geolocator.openAppSettings();
      await Geolocator.openLocationSettings();
    }
  }

  Future<Position> getCurrentLocation() async {
    enableLocationPermission();

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
