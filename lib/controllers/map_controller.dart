import 'package:corriol_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

/// Controller class for managing markers and camera position on the map.
class MapController extends ChangeNotifier {
  /// A static map that holds the markers used on the Map.
  static final Map<MarkerId, Marker> _markers = {};

  /// Get the current [Set<Marker>] on the map.
  static Set<Marker> get markers => _markers.values.toSet();

  /// Get the default camera position with the given [position] and [zoom].
  static CameraPosition getDefaultCameraPosition(LatLng position, double zoom) {
    return CameraPosition(
      target: position,
      zoom: zoom,
    );
  }

  /// Handle the onTap event on the map.
  ///
  /// The [context] is the [BuildContext], and [position] is the tapped position on the map.
  static void onTap(BuildContext context, LatLng position) {
    const markerId = MarkerId('0');
    final marker = Marker(
      markerId: markerId,
      position: position,
    );

    Provider.of<UserProvider>(context, listen: false).setPosition(position);

    _markers[markerId] = marker;
  }
}
