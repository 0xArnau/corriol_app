import 'package:corriol_app/core/constants.dart';
import 'package:corriol_app/widgets/buttons/language_button_widget.dart';
import 'package:flutter/material.dart';

class DropDownFABWidget extends StatefulWidget {
  const DropDownFABWidget({super.key});

  @override
  State<DropDownFABWidget> createState() => _DropDownFABWidgetState();
}

class _DropDownFABWidgetState extends State<DropDownFABWidget>
    with SingleTickerProviderStateMixin {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: _isOpen ? kDoublePaddingFloatingActionButtonV : 0,
          width: _isOpen ? kDoublePaddingFloatingActionButtonH : 0,
          child: _isOpen
              ? Column(
                  children: const [
                    LanguageButtonWidget(
                      text: 'Català',
                      newLocale: Locale('ca'),
                    ),
                    LanguageButtonWidget(
                      text: 'Español',
                      newLocale: Locale('es'),
                    ),
                    LanguageButtonWidget(
                      text: 'English',
                      newLocale: Locale('en'),
                    )
                  ],
                )
              : null,
        ),
        const SizedBox(height: kDouble15),
        FloatingActionButton(
          onPressed: () {
            setState(() {
              _isOpen = !_isOpen;
            });
          },
          child: const Icon(Icons.language),
        ),
      ],
    );
  }
}
