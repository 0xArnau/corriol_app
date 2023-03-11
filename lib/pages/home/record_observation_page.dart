import 'package:corriol_app/classes/geolocation_class.dart';
import 'package:corriol_app/core/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

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
    await Future.delayed(
        const Duration(seconds: 5)); // TODO: Change this to a better solution
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
        child: _position == null
            ? const CircularProgressIndicator()
            : Text(_position.toString()),
      ),
    );
  }
}
