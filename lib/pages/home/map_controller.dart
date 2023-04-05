import 'package:flutter/material.dart';
import 'package:corriol_app/core/notifiers.dart';
import 'package:flutter/widgets.dart' show ChangeNotifier;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends ChangeNotifier {
  static final Map<MarkerId, Marker> _markers = {};

  static Set<Marker> get markers => _markers.values.toSet();

  static CameraPosition getDefaultCameraPosition(LatLng position, double zoom) {
    return CameraPosition(
      target: position,
      zoom: zoom,
    );
  }

  static void onTap(LatLng position) {
    const markerId = MarkerId('0');
    final marker = Marker(
      markerId: markerId,
      position: position,
    );

    currenPositionNotifier.value = position;

    _markers[markerId] = marker;
  }
}
