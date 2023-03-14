import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' show ChangeNotifier;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends ChangeNotifier {
  final Map<MarkerId, Marker> _markers = {};

  Set<Marker> get markers => _markers.values.toSet();

  CameraPosition getDefaultCameraPosition(LatLng position, double zoom) {
    return CameraPosition(
      target: position,
      zoom: zoom,
    );
  }

  void onTap(LatLng position) {
    const markerId = MarkerId('0');
    final marker = Marker(
      markerId: markerId,
      position: position,
    );

    _markers[markerId] = marker;
    notifyListeners();
  }
}
