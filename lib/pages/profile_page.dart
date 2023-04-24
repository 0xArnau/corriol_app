import 'package:corriol_app/widgets/buttons/data_button_widget.dart';
import 'package:corriol_app/widgets/buttons/drop_down_fab_widget.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const [],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          DropDownFABWidget(),
          SizedBox(height: 15),
          DataButtonWidget(),
        ],
      ),
    );
  }
}
