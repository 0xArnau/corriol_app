import 'dart:async';

import 'package:corriol_app/auth.dart';
import 'package:corriol_app/core/constants.dart';
import 'package:corriol_app/pages/auth/auth_page.dart';
import 'package:corriol_app/widget_tree.dart';
import 'package:flutter/material.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    _checkEmailVerified();
    if (!isEmailVerified) {
      _sendEmailVerification();

      timer = Timer.periodic(
        const Duration(milliseconds: 5000),
        (_) => _checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Future _checkEmailVerified() async {
    setState(() {
      isEmailVerified = Auth().isEmailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  Future<void> _sendEmailVerification() async {
    String status = await Auth().sendEmailVerification();
    _statusBar(status);
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> _statusBar(
      String status) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(status),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget _button({onPressed, label, icon}) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified == true
        ? const AuthPage()
        : Scaffold(
            appBar: AppBar(
              title: const Text('Verify Email'),
              actions: [
                IconButton(
                  onPressed: () {
                    signOut();
                  },
                  icon: const Icon(Icons.logout),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(kDouble15),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'A verification email has been send to: ${Auth().currentUser!.email}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 15),
                    _button(
                      onPressed: _sendEmailVerification,
                      icon: const Icon(
                        Icons.email,
                        size: 32,
                      ),
                      label: const Text(
                        'Resend Verification',
                        style: TextStyle(fontSize: 24),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
