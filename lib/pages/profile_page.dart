import 'package:corriol_app/controllers/auth_controller.dart';
import 'package:corriol_app/controllers/geolocation_controller.dart';
import 'package:corriol_app/generated/l10n.dart';
import 'package:corriol_app/models/user_model.dart';
import 'package:corriol_app/models/user_preferences_model.dart';
import 'package:corriol_app/providers/user_provider.dart';
import 'package:corriol_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// The profile page where users can view and their account information and preferences. Can modify the [UserPreferencesModel].
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

  /// Signs out the current user.
  Future<void> signOut() async {
    await AuthController().signOut();
  }

  @override
  void dispose() {
    super.dispose();
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

              List<Widget> options = [
                _profileUserOptions(
                  icon: const Icon(Icons.language),
                  option: "${S.current.lang}: ${preferences.lang}",
                  onTap: () => _openLanguageMenu(context),
                ),
                _profileUserOptionsInternet(
                    internetConnection: provider.internetConnectionStatus),
                _profileUserOptionsData(mobileData: preferences.mobileData),
                _profileUserOptionsGps(isGpsOn: preferences.gps),
                _profileUserOptions(
                  icon: const Icon(Icons.settings),
                  option: S.current.goToDeviceSettings,
                  onTap: () => GeolocationController()
                      .openAppSettings(context, provider),
                ),
                _profileUserOptions(
                  icon: const Icon(Icons.delete_forever),
                  option: S.current.deleteMyAccount,
                  onTap: () {
                    _alertDialogDeleteMyAccount(context);
                  },
                ),
                const SizedBox(height: 10),
                const Divider(),
                // const SizedBox(height: 10),
                // _profileAppInfo(),
                const SizedBox(height: 10),
                const Image(
                  image: AssetImage('assets/images/GEPEC_EdC_OFICIAL.png'),
                ),
              ];

              if (user == null) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: kDouble25),
                    const CircularProgressIndicator(),
                    ...options,
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
                    Text(user.technician!
                        ? S.current.techRole
                        : S.current.userRole),
                    const SizedBox(height: 10),
                    const Divider(),
                    const SizedBox(height: 10),
                    ...options,
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

  Widget _profileUserOptionsInternet({required bool internetConnection}) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.grey.withOpacity(0.1),
        ),
        child: internetConnection
            ? const Icon(Icons.signal_cellular_0_bar_rounded)
            : const Icon(
                Icons.signal_cellular_connected_no_internet_0_bar_rounded),
      ),
      title: Text(S.current.inernetConnection),
      trailing: internetConnection
          ? Text(
              S.current.statusOn,
              style: TextStyle(color: Colors.grey[800]),
            )
          : Text(
              S.current.statusOff,
              style: TextStyle(color: Colors.grey[800]),
            ),
      // onTap: onTap,
    );
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
      title: Text(S.current.mobileData),
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
                ? GeolocationController()
                    .enableLocationPermission(context, provider)
                : GeolocationController()
                    .disableLocationPermission(context, provider);
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

  void _alertDialogDeleteMyAccount(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(S.current.deleteMyAccount),
          content: Text(S.current.deleteMyAccountContent),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(S.current.cancel)),
            TextButton(
                onPressed: () {
                  AuthController().deleteUserAccountAndInformation(
                      context); // Deleting the context must be done within the method itself
                },
                child: Text(S.current.confirm)),
          ],
        );
      },
    );
  }
}
