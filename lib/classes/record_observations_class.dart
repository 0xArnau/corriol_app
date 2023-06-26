import 'dart:convert';
import 'package:corriol_app/core/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RecordObservationClass {
  RecordObservationClass({
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

  Map<String, dynamic> toJson() => {
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

  factory RecordObservationClass.fromJson(Map<String, dynamic> json) {
    final coordenates = json['coordenates'].split(',');
    return RecordObservationClass(
      coordenates: LatLng(
          double.parse(coordenates[0]),
          double.parse(
            coordenates[1],
          )),
      species: SpeciesExtension.valueOf(['species'].toString()),
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

  static Future<List<RecordObservationClass>> loadRecords() async {
    try {
      List<RecordObservationClass> records = [];
      if (await kFileReports.fileExists()) {
        final jsonStr = await kFileReports.readContent();
        final jsonStrList = jsonStr.split('\n');
        for (var element in jsonStrList) {
          if (element.isNotEmpty) {
            records.add(
              RecordObservationClass.fromJson(
                jsonDecode(element),
              ),
            );
          }
        }
      }
      if (await kFileReportsWithoutConnection.fileExists()) {
        final jsonStr = await kFileReportsWithoutConnection.readContent();
        final jsonStrList = jsonStr.split('\n');
        for (var element in jsonStrList) {
          if (element.isNotEmpty) {
            records.add(
              RecordObservationClass.fromJson(
                jsonDecode(element),
              ),
            );
          }
        }
      }
      return records;
    } on Exception catch (e) {
      // TODO
      print(e);
      return [];
    }
  }
}
