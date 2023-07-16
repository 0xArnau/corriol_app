import 'package:corriol_app/core/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ReportModel {
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

  String createdBy;
  LatLng coordenates;
  Species species;
  int males;
  int females;
  int undetermined;
  int chickens;
  int dogs;
  int cats;
  String administrativeArea;
  String subAdministrativeArea;
  String locality;
  String createdAt;

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
