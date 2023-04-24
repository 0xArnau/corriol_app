import 'dart:convert';

import 'package:corriol_app/classes/user_config_class.dart';
import 'package:corriol_app/core/constants.dart';
import 'package:corriol_app/core/notifiers.dart';
import 'package:corriol_app/main.dart';
import 'package:flutter/material.dart';

class LanguageButtonWidget extends StatefulWidget {
  const LanguageButtonWidget({
    super.key,
    this.text,
    this.newLocale,
  });

  final String? text;
  final Locale? newLocale;

  @override
  State<LanguageButtonWidget> createState() => _LanguageButtonWidgetState();
}

class _LanguageButtonWidgetState extends State<LanguageButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: userConfigNotifier,
      builder: (context, userConfig, child) {
        return Expanded(
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                userConfig.locale = widget.newLocale!;
                userConfig.saveConfig();
                userConfigNotifier.notifyListeners();
                print(userConfig.locale);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kColorPrimaryBlue,
              ),
              child: Text(
                widget.text!,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}
