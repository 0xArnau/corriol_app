import 'package:corriol_app/controllers/auth_controller.dart';
import 'package:corriol_app/models/user_model.dart';
import 'package:corriol_app/widgets/buttons/data_button_widget.dart';
import 'package:corriol_app/widgets/buttons/drop_down_fab_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // final User? user = AuthController().currentUser;
  late Future<UserModel?> user;

  @override
  void initState() {
    super.initState();
    setState(() {
      user = _getUserInfo();
    });
  }

  Future<UserModel?> _getUserInfo() async {
    return await AuthController().getUserInformation();
  }

  Future<void> signOut() async {
    await AuthController().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: FutureBuilder<UserModel?>(
            future: user,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                UserModel? userModel = snapshot.data;
                if (userModel != null) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Email: ${userModel.email}'),
                      Text('Full Name: ${userModel.fullName}'),
                      Text('Age: ${userModel.age}'),
                      Text('Technician: ${userModel.technician}'),
                    ],
                  );
                }
              }
              return const SizedBox();
            },
          ),
        ),
      ),
      floatingActionButton: const Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          DropDownFABWidget(),
          SizedBox(height: 15),
          DataButtonWidget(),
        ],
      ),
    );
  }
}
