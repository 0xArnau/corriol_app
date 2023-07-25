import 'package:corriol_app/controllers/geolocation_controller.dart';
import 'package:corriol_app/core/constants.dart';
import 'package:corriol_app/pages/home/map_page.dart';
import 'package:corriol_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapButtonWidget extends StatefulWidget {
  const MapButtonWidget({Key? key}) : super(key: key);

  @override
  State<MapButtonWidget> createState() => _MapButtonWidgetState();
}

class _MapButtonWidgetState extends State<MapButtonWidget> {
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
      builder: (context, value, child) {
        final position = value.position as LatLng;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.map_outlined,
              color: kColorText,
            ),
            const SizedBox(width: kDouble25),
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  side: const BorderSide(color: kColorDropDown),
                  backgroundColor: kColorDropDown,
                  foregroundColor: Colors.black,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return MapPage(
                          position: position,
                          zoom: 10,
                        );
                      },
                    ),
                  );
                },
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ValueListenableBuilder<String>(
                    valueListenable: addressNotifier,
                    builder: (context, address, child) {
                      return Text(
                        address,
                        textAlign: TextAlign.center,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
