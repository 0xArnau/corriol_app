import 'package:corriol_app/main.dart';
import 'package:flutter/material.dart';

ValueNotifier<bool> isGpsOnNotifier = ValueNotifier(false);
ValueNotifier<Locale> localeNotifier =
    ValueNotifier(MyApp().getDefaultLocale());
