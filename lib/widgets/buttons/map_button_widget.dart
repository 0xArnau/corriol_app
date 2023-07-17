import 'package:corriol_app/core/constants.dart';
import 'package:corriol_app/pages/home/map_page.dart';
import 'package:corriol_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapButtonWidget extends StatefulWidget {
  const MapButtonWidget({super.key});

  @override
  State<MapButtonWidget> createState() => _MapButtonWidgetState();
}

class _MapButtonWidgetState extends State<MapButtonWidget> {
  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false).fetchPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, child) {
        final position = value.position as LatLng;
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
                          position: position,
                          zoom: 10,
                        );
                      },
                    ),
                  );
                },
                child: Text(
                    "${position.latitude.toStringAsFixed(6)},${position.longitude.toStringAsFixed(6)}"),
              ),
            ),
          ],
        );
      },
    );
  }
}
