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
  Set<Marker> getMarkers() {
    Set<Marker> markers = <Marker>{};

    for (var report in widget.reports) {
      markers.add(
        Marker(
          markerId: MarkerId(report.createdBy),
          position:
              LatLng(report.coordenates.latitude, report.coordenates.longitude),
        ),
      );
    }

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
      body: Center(
        child: GoogleMap(
          initialCameraPosition: MapController.getDefaultCameraPosition(
              widget.reports[0].coordenates, 7),
          markers: getMarkers(),
        ),
      ),
    );
  }
}
