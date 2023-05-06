import 'dart:async';

import 'package:corriol_app/auth.dart';
import 'package:corriol_app/core/constants.dart';
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

    isEmailVerified = Auth().isEmailVerified;

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

  Future _checkEmailVerified() async {
    Auth().userReload();

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
        duration: const Duration(seconds: 5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified == true
        ? const WidgetTree()
        : Scaffold(
            appBar: AppBar(title: const Text('Verify Email')),
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
                    ElevatedButton.icon(
                      onPressed: _sendEmailVerification,
                      icon: const Icon(
                        Icons.email,
                        size: 32,
                      ),
                      label: const Text(
                        'Resend Verification',
                        style: TextStyle(fontSize: 24),
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                      ),
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton.icon(
                      onPressed: () {
                        Auth().userReload();
                        // Navigator.pop(context);
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Refresh'),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
