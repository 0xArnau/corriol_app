import 'package:corriol_app/controllers/file_io_controller.dart';
import 'package:corriol_app/controllers/map_controller.dart';
import 'package:corriol_app/models/report_model.dart';
import 'package:corriol_app/utils/constants.dart';
import 'package:corriol_app/widgets/report_marker_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// A page that displays a map with markers for each report in the [List<ReportModel>].
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
  /// Returns a set of markers for each report in the [widget.reports] list.
  Set<Marker> getMarkers() {
    Set<Marker> markers = <Marker>{};

    for (var report in widget.reports) {
      markers.add(
        Marker(
          markerId: MarkerId("${report.createdBy}-${report.createdAt}"),
          position:
              LatLng(report.coordinates.latitude, report.coordinates.longitude),
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => ReportMarkerWidget(report: report),
            );
          },
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
        actions: [
          IconButton(
            icon: const Icon(Icons.file_download),
            onPressed: () {
              FileIoController.saveReports2CSV(
                context: context,
                reports: widget.reports,
                locality: widget.title,
              );
            },
          ),
        ],
      ),
      body: Center(
        child: GoogleMap(
          initialCameraPosition: MapController.getDefaultCameraPosition(
              widget.reports[0].coordinates, 9),
          markers: getMarkers(),
        ),
      ),
    );
  }
}
