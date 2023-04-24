import 'package:corriol_app/core/constants.dart';
import 'package:corriol_app/core/notifiers.dart';
import 'package:corriol_app/widgets/buttons/language_button_widget.dart';
import 'package:flutter/material.dart';

class DataButtonWidget extends StatefulWidget {
  const DataButtonWidget({super.key});

  @override
  State<DataButtonWidget> createState() => _DataButtonWidgetState();
}

class _DataButtonWidgetState extends State<DataButtonWidget>
    with SingleTickerProviderStateMixin {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: userConfigNotifier,
      builder: (context, userConfig, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                userConfig.mobileData = !userConfig.mobileData;
                userConfig.saveConfig();
                userConfigNotifier.notifyListeners();
                print(userConfig.mobileData);
              },
              child: userConfig.mobileData
                  ? const Icon(Icons.signal_cellular_4_bar_rounded)
                  : const Icon(Icons.signal_cellular_off_rounded),
            ),
          ],
        );
      },
    );
  }
}
