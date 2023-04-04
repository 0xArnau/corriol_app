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

  String? valueChoose;
  List itemsList = [
    "Corriol A",
    "Corriol B",
  ];

  int _count = 0;

  void _increment() {
    setState(() {
      _count++;
    });
  }

  void _decrement() {
    setState(() {
      if (_count > 0) _count--;
    });
  }

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
          child: Center(
            child: Column(
              children: [
                // Map
                Row(
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
                ),
                const SizedBox(height: 15),
                // Especie
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.map_outlined),
                    const SizedBox(width: kDouble25),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButton(
                          hint: const Text("Espècie"),
                          isExpanded: true,
                          style: const TextStyle(color: Colors.black),
                          value: valueChoose,
                          onChanged: (newValue) {
                            setState(() {
                              valueChoose = newValue as String;
                            });
                          },
                          items: itemsList.map((itemValue) {
                            return DropdownMenuItem(
                              value: itemValue,
                              child: Text(itemValue),
                            );
                          }).toList(),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.map_outlined),
                    const SizedBox(width: kDouble25),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('#Femelles'),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: _decrement,
                        ),
                        Text('$_count'),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: _increment,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
