import 'package:corriol_app/controllers/geolocation_controller.dart';
import 'package:corriol_app/utils/constants.dart';
import 'package:corriol_app/controllers/map_controller.dart';
import 'package:corriol_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapPage extends StatefulWidget {
  const MapPage({
    super.key,
    required this.position,
    required this.zoom,
  });

  final LatLng position;
  final double zoom;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late UserProvider provider;
  final ValueNotifier<String> addressNotifier = ValueNotifier('');

  @override
  void initState() {
    provider = Provider.of<UserProvider>(context, listen: false);
    provider.addListener(() {
      _fetchPositionAndAddress();
    });
    _fetchPositionAndAddress();
    super.initState();
  }

  Future<void> _fetchPositionAndAddress() async {
    final address = await GeolocationController().updateAddress(provider);
    if (address[1].isEmpty) {
      addressNotifier.value = address[0];
    } else if (address[2].isEmpty) {
      addressNotifier.value = "${address[0]}, ${address[1]}";
    } else {
      addressNotifier.value = "${address[0]}, ${address[1]}, ${address[2]}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, index) {
        final position = value.position as LatLng;
        return Scaffold(
          appBar: AppBar(
            title: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ValueListenableBuilder<String>(
                valueListenable: addressNotifier,
                builder: (context, address, child) {
                  return Text(
                    address,
                    textAlign: TextAlign.center,
                    style: kTextStylePageTitle,
                  );
                },
              ),
            ),
          ),
          body: Center(
            child: GoogleMap(
              initialCameraPosition:
                  MapController.getDefaultCameraPosition(position, 10),
              markers: MapController.markers,
              onTap: (LatLng tappedPosition) {
                MapController.onTap(context, tappedPosition);
              },
            ),
          ),
        );
      },
    );
  }
}
