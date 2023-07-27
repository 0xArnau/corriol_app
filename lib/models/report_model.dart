import 'package:corriol_app/utils/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Class that represents the fields that a report has
class ReportModel {
  /// Creates a new [ReportModel] instance from a JSON format.
  ReportModel({
    required this.createdAt,
    required this.createdBy,
    required this.coordenates,
    required this.species,
    required this.females,
    required this.males,
    required this.undetermined,
    required this.chickens,
    required this.cats,
    required this.dogs,
    required this.administrativeArea,
    required this.subAdministrativeArea,
    required this.locality,
  });

  /// The date and time when the report was created.
  final String createdAt;

  /// The user who created the report.
  final String createdBy;

  /// The coordinates [LatLng.latitude] and [LatLng.longitude] where the report was made.
  final LatLng coordenates;

  /// The [Species] reported in the observation.
  final Species species;

  /// The number of male specimens in the report.
  final int males;

  /// The number of female specimens in the report.
  final int females;

  /// The number of undetermined specimens in the report.
  final int undetermined;

  /// The number of chicken specimens in the report.
  final int chickens;

  /// The number of cat specimens in the report.
  final int cats;

  /// The number of dog specimens in the report.
  final int dogs;

  /// The administrative area where the report was made.
  final String administrativeArea;

  /// The sub-administrative area where the report was made.
  final String subAdministrativeArea;

  /// The locality where the report was made.
  final String locality;

  /// Converts the [ReportModel] instance to a JSON format.
  Map<String, dynamic> toJson() => {
        'createdAt': createdAt,
        'createdBy': createdBy,
        'coordenates': '${coordenates.latitude}, ${coordenates.longitude}',
        'administrativeArea': administrativeArea,
        'subAdministrativeArea': subAdministrativeArea,
        'locality': locality,
        'species': species.toString(),
        'males': males,
        'females': females,
        'undetermined': undetermined,
        'chickens': chickens,
        'dogs': dogs,
        'cats': cats,
      };

  /// Creates a new [ReportModel] instance from a JSON format.
  factory ReportModel.fromJson(Map<String, dynamic> json) {
    final coordenates = json['coordenates'].split(',');
    return ReportModel(
      createdAt: json['createdAt'].toString(),
      createdBy: json['createdBy'].toString(),
      coordenates: LatLng(
          double.parse(coordenates[0]),
          double.parse(
            coordenates[1],
          )),
      species: SpeciesExtension.valueOf(json['species'].toString()),
      females: int.parse(json['females'].toString()),
      males: int.parse(json['males'].toString()),
      undetermined: int.parse(json['undetermined'].toString()),
      chickens: int.parse(json['chickens'].toString()),
      cats: int.parse(json['cats'].toString()),
      dogs: int.parse(json['dogs'].toString()),
      administrativeArea: json['administrativeArea'].toString(),
      subAdministrativeArea: json['subAdministrativeArea'].toString(),
      locality: json['locality'].toString(),
    );
  }
}
