import 'package:corriol_app/core/constants.dart';
import 'package:corriol_app/core/notifiers.dart';
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
      valueListenable: localeNotifier,
      builder: (context, locale, child) {
        return Expanded(
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  localeNotifier.value = widget.newLocale!;
                  print(widget.newLocale!);
                });
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
