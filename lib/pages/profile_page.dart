import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corriol_app/classes/geolocation_class.dart';
import 'package:corriol_app/controllers/auth_controller.dart';
import 'package:corriol_app/core/constants.dart';
import 'package:corriol_app/core/notifiers.dart';
import 'package:corriol_app/models/user_model.dart';
import 'package:corriol_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  }

  void _setGps(bool value) {
    isGpsOnNotifier.value
        ? GeolocationClass().disableLocationPermission()
        : GeolocationClass().enableLocationPermission();
  }

  void _setLanguage(Locale value) {
    if (mounted) {
      setState(() {
        userConfigNotifier.value.locale = value;
      });
    }
    userConfigNotifier.value.saveConfig();
    userConfigNotifier.notifyListeners();
  }

  void _setMobileConnection(bool value) {
    if (mounted) {
      setState(() {
        userConfigNotifier.value.mobileData = value;
      });
    }
    userConfigNotifier.value.saveConfig();
    userConfigNotifier.notifyListeners();
  }

  Future<void> signOut() async {
    await AuthController().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(kDouble25),
        child: Column(
          children: [
            _profileUserInfo(),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            _profileUserOptions(
              icon: const Icon(Icons.language),
              option: "Language: ${userConfigNotifier.value.locale}",
              onTap: () => _openLanguageMenu(context),
            ),
            _profileUserOptionsData(),
            _profileUserOptionsGps(),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            _profileAppInfo(),
          ],
        ),
      ),
    );
  }

  Widget _profileUserInfo() {
    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        final user = provider.data as UserModel?;
        if (user == null) {
          return const CircularProgressIndicator();
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.person,
                size: 150,
              ),
              Text(
                user.fullName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                user.email,
                style: const TextStyle(
                  // fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),
              ),
              Text(user.technician! ? 'Role: Technician' : 'Role: User'),
            ],
          );
        }
      },
    );
  }

  Widget _profileUserOptions({
    required Icon icon,
    required String option,
    void Function()? onTap,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.grey.withOpacity(0.1),
        ),
        child: icon,
      ),
      title: Text(option),
      trailing: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(100),
          color: Colors.grey.withOpacity(0.1),
        ),
        child: const Icon(
          Icons.navigate_next,
          color: Colors.grey,
        ),
      ),
      onTap: onTap,
    );
  }

  void _openLanguageMenu(BuildContext context) async {
    final result = await showMenu(
      position: RelativeRect.fill,
      context: context,
      items: [
        const PopupMenuItem(
          value: 1,
          child: Text('Català'),
        ),
        const PopupMenuItem(
          value: 2,
          child: Text('Español'),
        ),
        const PopupMenuItem(
          value: 3,
          child: Text('English'),
        ),
      ],
    );

    if (result != null) {
      switch (result) {
        case 1:
          _setLanguage(const Locale('ca'));
          break;
        case 2:
          _setLanguage(const Locale('es'));
          break;
        case 3:
          _setLanguage(const Locale('en'));
          break;
      }
    }
  }

  Widget _profileUserOptionsData() {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.grey.withOpacity(0.1),
        ),
        child: userConfigNotifier.value.mobileData
            ? const Icon(Icons.four_g_mobiledata_rounded)
            : const Icon(Icons.mobiledata_off),
      ),
      title: const Text("Datos mobiles"),
      trailing: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(100),
          color: Colors.grey.withOpacity(0.1),
        ),
        child: Switch(
          value: userConfigNotifier.value.mobileData,
          onChanged: _setMobileConnection,
        ),
      ),
      // onTap: onTap,
    );
  }

  Widget _profileUserOptionsGps() {
    return ValueListenableBuilder(
      valueListenable: isGpsOnNotifier,
      builder: (context, isGpsOn, child) {
        return ListTile(
          leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: isGpsOn
                  ? const Icon(Icons.gps_fixed)
                  : const Icon(Icons.gps_off)),
          title: const Text("GPS"),
          trailing: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(100),
              color: Colors.grey.withOpacity(0.1),
            ),
            child: Switch(
              value: isGpsOn,
              onChanged: _setGps,
            ),
          ),
          // onTap: onTap,
        );
      },
    );
  }

  Widget _profileAppInfo() {
    return const ExpansionTile(
      title: Text('App Info'),
      children: [
        Text('Version: pre alpha'),
      ],
    );
  }
}
