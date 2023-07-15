import 'package:corriol_app/controllers/auth_controller.dart';
import 'package:corriol_app/pages/auth/login_page.dart';
import 'package:corriol_app/pages/auth/verify_email_page.dart';
import 'package:corriol_app/providers/user_provider.dart';
import 'package:corriol_app/widget_tree.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late UserProvider provider;
  @override
  void initState() {
    provider = Provider.of<UserProvider>(context, listen: false);
    provider.fetchUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthController().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return AuthController().isEmailVerified()
              ? const WidgetTree()
              : const VerifyEmailPage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
