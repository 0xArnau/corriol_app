import 'package:corriol_app/controllers/auth_controller.dart';
import 'package:corriol_app/controllers/geolocation_controller.dart';
import 'package:corriol_app/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:corriol_app/models/user_model.dart';
import 'package:corriol_app/models/user_preferences_model.dart';
import 'package:corriol_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // final User? user = AuthController().currentUser;
  late Future<UserModel?> user;
  late UserProvider provider;

  @override
  void initState() {
    provider = Provider.of<UserProvider>(context, listen: false);
    super.initState();
  }

  Future<void> signOut() async {
    await AuthController().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Consumer<UserProvider>(
            builder: (context, provider, child) {
              final user = provider.user as UserModel?;
              final preferences = provider.preferences as UserPreferencesModel;
              if (user == null) {
                return const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: kDouble25),
                    CircularProgressIndicator(),
                  ],
                );
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
                    const SizedBox(height: 10),
                    const Divider(),
                    const SizedBox(height: 10),
                    _profileUserOptions(
                      icon: const Icon(Icons.language),
                      option: "Language: ${preferences.lang}",
                      onTap: () => _openLanguageMenu(context),
                    ),
                    _profileUserOptionsData(mobileData: preferences.mobileData),
                    _profileUserOptionsGps(isGpsOn: preferences.gps),
                    const SizedBox(height: 10),
                    const Divider(),
                    // const SizedBox(height: 10),
                    // _profileAppInfo(),
                    const SizedBox(height: 10),
                    const Image(
                      image: AssetImage('assets/images/GEPEC_EdC_OFICIAL.png'),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
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
          provider.setLangInfo(const Locale('ca'));
          break;
        case 2:
          provider.setLangInfo(const Locale('es'));
          break;
        case 3:
          provider.setLangInfo(const Locale('en'));
          break;
      }
    }
  }

  Widget _profileUserOptionsData({required bool mobileData}) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.grey.withOpacity(0.1),
        ),
        child: mobileData
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
          value: mobileData,
          onChanged: provider.setMobileDataInfo,
        ),
      ),
      // onTap: onTap,
    );
  }

  Widget _profileUserOptionsGps({required bool isGpsOn}) {
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
          onChanged: (value) {
            value
                ? GeolocationController().enableLocationPermission(provider)
                : GeolocationController().disableLocationPermission(provider);
          },
        ),
      ),
      // onTap: onTap,
    );
  }

  // ignore: unused_element
  Widget _profileAppInfo() {
    return const ExpansionTile(
      title: Text('App Info'),
      children: [
        Text('Version: pre alpha'),
      ],
    );
  }
}
