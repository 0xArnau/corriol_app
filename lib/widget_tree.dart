import 'package:corriol_app/controllers/auth_controller.dart';
import 'package:corriol_app/generated/l10n.dart';
import 'package:corriol_app/models/user_model.dart';
import 'package:corriol_app/pages/handyman_page.dart';
import 'package:corriol_app/pages/home_page.dart';
import 'package:corriol_app/pages/profile_page.dart';
import 'package:corriol_app/providers/report_provider.dart';
import 'package:corriol_app/providers/user_provider.dart';
import 'package:corriol_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// The main widget tree of the Corriol app, which handles the navigation and page switching between: [HomePage], [HandymanPage] and [ProfilePage].
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
        // final internetStatus = value.internetConnectionStatus;
        late List<NavigationDestination> navigation;
        late List<Widget> pages;

        if (user != null &&
            Provider.of<ReportProvider>(context, listen: false)
                .userReports
                .isEmpty) {
          Provider.of<ReportProvider>(context, listen: false)
              .fetchCurrentUserReports(
            context,
            user.email,
            Provider.of<UserProvider>(context, listen: false)
                .internetConnectionStatus,
          );
        }

        if (user == null) {
          navigation = [
            NavigationDestination(
              icon: const Icon(Icons.home),
              label: S.current.home,
            ),
            NavigationDestination(
              icon: const Icon(Icons.person),
              label: S.current.profile,
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
              label: S.current.home,
            ),
            NavigationDestination(
              icon: const Icon(Icons.person),
              label: S.current.profile,
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
              label: S.current.home,
            ),
            NavigationDestination(
              icon: const Icon(
                Icons.handyman,
                // color: kColorIcon,
              ),
              label: S.current.handyman,
            ),
            NavigationDestination(
              icon: const Icon(
                Icons.person,
                // color: kColorIcon,
              ),
              label: S.current.profile,
            ),
          ];
          pages = [
            const HomePage(),
            const HandymanPage(),
            const ProfilePage(),
          ];
        }

        return Consumer<ReportProvider>(
          builder: (context, value, child) {
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
                                value.fetchAllReports(context, true);
                              },
                              icon: const Icon(
                                Icons.update,
                              ),
                            )
                          : const Text(''),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(kDoubleMainPadding),
                child: pages.elementAt(
                    user == null ? navigation.length - 1 : currentPage),
              ),
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
      },
    );
  }
}
