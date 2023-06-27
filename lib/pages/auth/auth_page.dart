import 'package:corriol_app/controllers/auth_controller.dart';
import 'package:corriol_app/pages/auth/login_page.dart';
import 'package:corriol_app/pages/auth/verify_email_page.dart';
import 'package:corriol_app/widget_tree.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
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
