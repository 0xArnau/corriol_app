import 'package:corriol_app/core/constants.dart';
import 'package:corriol_app/core/notifiers.dart';
import 'package:corriol_app/pages/home/map_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
    return ValueListenableBuilder(
      valueListenable: currentPositionNotifier,
      builder: (context, currentPosition, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "${currentPosition.latitude.toStringAsFixed(6)},${currentPosition.longitude.toStringAsFixed(6)}",
              style: kTextStylePageTitle,
            ),
          ),
          body: Center(
            child: GoogleMap(
              initialCameraPosition:
                  MapController.getDefaultCameraPosition(position, zoom),
              markers: MapController.markers,
              onTap: MapController.onTap,
            ),
          ),
        );
      },
    );
  }
}
