import 'package:corriol_app/controllers/geolocation_controller.dart';
import 'package:corriol_app/core/constants.dart';
import 'package:corriol_app/controllers/map_controller.dart';
import 'package:corriol_app/models/report_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ReportMapPage extends StatefulWidget {
  const ReportMapPage({
    super.key,
    required this.title,
    required this.reports,
  });

  final List<ReportModel> reports;
  final String title;

  @override
  State<ReportMapPage> createState() => _ReportMapPageState();
}

class _ReportMapPageState extends State<ReportMapPage> {
  Future<LatLng> getPosition() async {
    try {
      LatLng locations =
          await GeolocationController().getLatLngFromAddress(widget.title);
      return locations;
    } catch (e) {
      print('Error al obtener las coordenadas: $e');
      // Puedes devolver un valor por defecto o lanzar una excepción si es necesario.
      return LatLng(0.0, 0.0);
    }
  }

  Set<Marker> getMarkers() {
    Set<Marker> markers = <Marker>{};

    for (var report in widget.reports) {
      print(report.coordenates);
      markers.add(
        Marker(
          markerId: MarkerId(report.createdBy),
          position:
              LatLng(report.coordenates.latitude, report.coordenates.longitude),
        ),
      );
    }

    print(markers.toString());

    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: kTextStylePageTitle,
          ),
        ),
      ),
      body: FutureBuilder(
        future: getPosition(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error al obtener las coordenadas'),
            );
          } else {
            final position = snapshot.data ?? const LatLng(41.8205, 1.8401);
            return Center(
              child: GoogleMap(
                initialCameraPosition:
                    MapController.getDefaultCameraPosition(position, 10),
                markers: getMarkers(),
                onTap: (LatLng tappedPosition) {
                  MapController.onTap(context, tappedPosition);
                },
              ),
            );
          }
        },
      ),
    );
  }
}
