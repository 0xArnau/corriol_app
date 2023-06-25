import 'package:corriol_app/auth.dart';
import 'package:corriol_app/widgets/buttons/data_button_widget.dart';
import 'package:corriol_app/widgets/buttons/drop_down_fab_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user?.email ?? 'Email'),
      ),
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
