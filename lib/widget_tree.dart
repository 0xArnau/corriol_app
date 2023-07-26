import 'package:corriol_app/controllers/auth_controller.dart';
import 'package:corriol_app/utils/constants.dart';
import 'package:corriol_app/models/user_model.dart';
import 'package:corriol_app/models/user_preferences_model.dart';
import 'package:corriol_app/pages/handyman_page.dart';
import 'package:corriol_app/pages/home_page.dart';
import 'package:corriol_app/pages/profile_page.dart';
import 'package:corriol_app/providers/user_provider.dart';
import 'package:corriol_app/utils/my_snackbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  int currentPage = 0;

  Future<void> signOut() async {
    await AuthController().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, child) {
        final user = value.user as UserModel?;
        final preferences = value.preferences as UserPreferencesModel;
        late List<NavigationDestination> navigation;
        late List<Widget> pages;

        if (user == null) {
          navigation = [
            NavigationDestination(
              icon: const Icon(Icons.home),
              label: AppLocalizations.of(context).home,
            ),
            NavigationDestination(
              icon: const Icon(Icons.person),
              label: AppLocalizations.of(context).profile,
            ),
          ];
          pages = [
            const HomePage(),
            const ProfilePage(),
          ];
        } else if (user.technician == false) {
          navigation = [
            NavigationDestination(
              icon: const Icon(Icons.home),
              label: AppLocalizations.of(context).home,
            ),
            NavigationDestination(
              icon: const Icon(Icons.person),
              label: AppLocalizations.of(context).profile,
            ),
          ];
          pages = [
            const HomePage(),
            const ProfilePage(),
          ];
        } else {
          navigation = [
            NavigationDestination(
              icon: const Icon(
                Icons.home,
                // color: kColorIcon,
              ),
              label: AppLocalizations.of(context).home,
            ),
            NavigationDestination(
              icon: const Icon(
                Icons.handyman,
                // color: kColorIcon,
              ),
              label: AppLocalizations.of(context).handyman,
            ),
            NavigationDestination(
              icon: const Icon(
                Icons.person,
                // color: kColorIcon,
              ),
              label: AppLocalizations.of(context).profile,
            ),
          ];
          pages = [
            const HomePage(),
            const HandymanPage(),
            const ProfilePage(),
          ];
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Corriol APP',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                color: kColorText,
              ),
            ),
            actions: [
              currentPage == navigation.length - 1
                  ? IconButton(
                      onPressed: () {
                        signOut();
                      },
                      icon: const Icon(
                        Icons.logout,
                        // color: Colors.red.shade700,
                      ),
                    )
                  : currentPage == 1
                      ? IconButton(
                          onPressed: () {
                            if (preferences.mobileData) {
                              Provider.of<UserProvider>(context, listen: false)
                                  .fetchReportDatalocality();
                            } else {
                              snackbarError(
                                  context,
                                  AppLocalizations.of(context)
                                      .noInternetConnection);
                            }
                          },
                          icon: const Icon(
                            Icons.update,
                          ),
                        )
                      : const Text(''),
            ],
          ),
          body: pages.elementAt(currentPage),
          bottomNavigationBar: NavigationBar(
            destinations: navigation,
            selectedIndex: currentPage,
            onDestinationSelected: (int value) {
              if (mounted) {
                setState(
                  () {
                    currentPage = value;
                  },
                );
              }
            },
          ),
        );
      },
    );
  }
}
