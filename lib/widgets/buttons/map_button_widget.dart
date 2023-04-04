import 'package:corriol_app/classes/geolocation_class.dart';
import 'package:corriol_app/core/constants.dart';
import 'package:corriol_app/core/notifiers.dart';
import 'package:corriol_app/pages/home/map_page.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapButtonWidget extends StatefulWidget {
  const MapButtonWidget({super.key});

  @override
  State<MapButtonWidget> createState() => _MapButtonWidgetState();
}

class _MapButtonWidgetState extends State<MapButtonWidget> {
  Position? _position;
  
  Future<void> updateLocation() async {
    GeolocationClass().enableLocationPermission();
    if (!isGpsOnNotifier.value) {
      await Future.delayed(
          const Duration(seconds: 5)); // TODO: Change this to a better solution
    }
    Position? newPosition = await GeolocationClass().getCurrentLocation();
    setState(() {
      _position = newPosition;
    });
  }
    
  @override
  void initState() {
    super.initState();
    updateLocation();
  }
 
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.map_outlined),
        const SizedBox(width: kDouble25),
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                )),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return MapPage(
                      position: LatLng(
                        _position == null
                            ? 41.8205 // Catalunya
                            : _position!.latitude,
                        _position == null
                            ? 1.8401 // Catalunya
                            : _position!.longitude,
                      ),
                      zoom: _position == null ? 7 : 15,
                    );
                  },
                ),
              );
            },
            child: ValueListenableBuilder(
                valueListenable: currenPositionNotifier,
                builder: (context, currentPosition, child) {
                  return Text(
                      "${currentPosition.latitude.toStringAsFixed(6)} ${currentPosition.longitude.toStringAsFixed(6)}");
                }),
          ),
        ),
      ],
    );
  }
}
