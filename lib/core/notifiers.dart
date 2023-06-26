import 'package:corriol_app/classes/user_config_class.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

ValueNotifier<bool> isGpsOnNotifier = ValueNotifier(false);
ValueNotifier<UserConfigClass> userConfigNotifier = ValueNotifier(
  UserConfigClass(locale: const Locale('ca'), mobileData: false),
);
ValueNotifier<LatLng> currentPositionNotifier =
    ValueNotifier(const LatLng(41.8205, 1.8401)); // Catalunya

ValueNotifier<bool> isConnectedNotifier = ValueNotifier(false);
