import 'package:corriol_app/core/constants.dart';
import 'package:corriol_app/controllers/map_controller.dart';
import 'package:corriol_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapPage extends StatelessWidget {
  const MapPage({
    super.key,
    required this.position,
    required this.zoom,
  });

  final LatLng position;
  final double zoom;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, index) {
        final _position = value.position as LatLng;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "${_position.latitude.toStringAsFixed(6)},${_position.longitude.toStringAsFixed(6)}",
              style: kTextStylePageTitle,
            ),
          ),
          body: Center(
            child: GoogleMap(
              initialCameraPosition:
                  MapController.getDefaultCameraPosition(_position, 10),
              markers: MapController.markers,
              onTap: (LatLng tappedPosition) {
                MapController.onTap(context, tappedPosition);
              },
            ),
          ),
        );
      },
    );
  }
}
