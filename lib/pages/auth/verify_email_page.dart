import 'dart:async';
import 'package:corriol_app/controllers/auth_controller.dart';
import 'package:corriol_app/generated/l10n.dart';
import 'package:corriol_app/utils/constants.dart';
import 'package:corriol_app/pages/auth/auth_page.dart';
import 'package:flutter/material.dart';

/// A widget representing the "Verify Email" page.
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
        const Duration(milliseconds: 20000),
        (_) => _checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  /// Sign out the current user
  Future<void> signOut() async {
    await AuthController().signOut();
  }

  Future _checkEmailVerified() async {
    if (mounted) {
      setState(() {
        isEmailVerified = AuthController().isEmailVerified();
      });
    }

    if (isEmailVerified) timer?.cancel();
  }

  Future<void> _sendEmailVerification() async {
    String status = await AuthController().sendEmailVerification();
    _statusBar(status);
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>? _statusBar(
      String status) {
    if (!mounted) return null;

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
              title: Text(S.current.verifyEmail),
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
                    const Spacer(),
                    Text(
                      '${S.current.verifyEmailSent} ${AuthController().currentUser!.email}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 15),
                    _button(
                      onPressed: _sendEmailVerification,
                      icon: const Icon(
                        Icons.email,
                        size: 32,
                      ),
                      label: Text(
                        S.current.verifyEmailResent,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                    const SizedBox(height: kDouble25),
                    const Spacer(),
                    InkWell(
                      onTap: _checkEmailVerified,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.refresh_outlined,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: kDouble10),
                          Text(
                            S.current.refresh,
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: kDouble25 * 2),
                  ],
                ),
              ),
            ),
          );
  }
}
