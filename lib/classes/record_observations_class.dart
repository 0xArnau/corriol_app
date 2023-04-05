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
  });

  LatLng coordenates;
  String species;
  int males;
  int females;
  int undetermined;
  int chickens;
  int dogs;
  int cats;

  Map<String, dynamic> toJson() => {
        'coordenates': '${coordenates.latitude}, ${coordenates.longitude}',
        'species': species,
        'males': males,
        'females': females,
        'undetermined': undetermined,
        'chickens': chickens,
        'dogs': dogs,
        'cats': cats,
      };
}
