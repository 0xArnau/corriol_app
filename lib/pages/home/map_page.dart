import 'package:corriol_app/core/constants.dart';
import 'package:corriol_app/pages/home/map_controller.dart';
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
    return ChangeNotifierProvider<MapController>(
      create: (_) => MapController(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Google Maps: Selecciona una posició',
            style: kTextStylePageTitle,
          ),
        ),
        body: Center(
          child: Consumer<MapController>(
            builder: (_, controller, __) => GoogleMap(
              initialCameraPosition:
                  controller.getDefaultCameraPosition(position, zoom),
              markers: controller.markers,
              onTap: controller.onTap,
            ),
          ),
        ),
      ),
    );
  }
}
