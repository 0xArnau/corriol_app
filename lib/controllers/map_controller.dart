import 'package:corriol_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapController extends ChangeNotifier {
  static final Map<MarkerId, Marker> _markers = {};

  static Set<Marker> get markers => _markers.values.toSet();

  static CameraPosition getDefaultCameraPosition(LatLng position, double zoom) {
    return CameraPosition(
      target: position,
      zoom: zoom,
    );
  }

  static void onTap(BuildContext context, LatLng position) {
    const markerId = MarkerId('0');
    final marker = Marker(
      markerId: markerId,
      position: position,
    );

    // currentPositionNotifier.value = position;
    Provider.of<UserProvider>(context, listen: false).setPosition(position);

    _markers[markerId] = marker;
  }
}
