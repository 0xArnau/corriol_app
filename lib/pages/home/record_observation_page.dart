import 'package:corriol_app/classes/geolocation_class.dart';
import 'package:corriol_app/core/constants.dart';
import 'package:corriol_app/core/notifiers.dart';
import 'package:corriol_app/pages/home/map_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RecordObservationPage extends StatefulWidget {
  const RecordObservationPage({super.key});

  @override
  State<RecordObservationPage> createState() => _RecordObservationPageState();
}

class _RecordObservationPageState extends State<RecordObservationPage> {
  Position? _position;

  @override
  void initState() {
    super.initState();
    updateLocation();
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).recordObservation,
          style: kTextStylePageTitle,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(kDouble25),
          child: Column(
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.map_outlined),
                    const SizedBox(width: kDouble25),
                    // _position == null
                    //     ? const CircularProgressIndicator()
                    //     : Text(_position.toString()),
                    Expanded(
                      child: OutlinedButton(
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
                        child: const Text('Veure google maps'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
