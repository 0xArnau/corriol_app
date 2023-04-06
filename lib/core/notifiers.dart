import 'package:corriol_app/main.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

ValueNotifier<bool> isGpsOnNotifier = ValueNotifier(false);
ValueNotifier<Locale> localeNotifier = ValueNotifier(MyApp.languageCode);
ValueNotifier<LatLng> currenPositionNotifier =
    ValueNotifier(const LatLng(41.8205, 1.8401)); // Catalunya
