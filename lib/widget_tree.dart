import 'package:corriol_app/controllers/auth_controller.dart';
import 'package:corriol_app/pages/handyman_page.dart';
import 'package:corriol_app/pages/home_page.dart';
import 'package:corriol_app/pages/profile_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  int currentPage = 0;
  List<Widget> pages = [
    const HomePage(),
    const HandymanPage(),
    ProfilePage(),
  ];

  Future<void> signOut() async {
    await AuthController().signOut();
  }

  @override
  Widget build(BuildContext context) {
    List<NavigationDestination> navigation = [
      NavigationDestination(
        icon: const Icon(Icons.home),
        label: AppLocalizations.of(context).home,
      ),
      NavigationDestination(
        icon: const Icon(Icons.handyman),
        label: AppLocalizations.of(context).handyman,
      ),
      NavigationDestination(
        icon: const Icon(Icons.person),
        label: AppLocalizations.of(context).profile,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Corriol APP',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
        ),
        actions: [
          currentPage == 2
              ? IconButton(
                  onPressed: () {
                    signOut();
                  },
                  icon: const Icon(Icons.logout),
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
  }
}
