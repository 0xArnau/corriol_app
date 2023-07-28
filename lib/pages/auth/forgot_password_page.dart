import 'package:corriol_app/generated/l10n.dart';
import 'package:corriol_app/utils/constants.dart';
import 'package:corriol_app/widgets/buttons/black_button_widget.dart';
import 'package:corriol_app/widgets/forms/my_text_form_widget.dart';
import 'package:corriol_app/utils/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// A widget representing the "Forgot Password" page.
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _controllerEmail = TextEditingController();

  @override
  void dispose() {
    _controllerEmail.dispose();
    super.dispose();
  }

  /// Using [FirebaseAuth.sendPasswordResetEmail] sends a message to reset the password for the user associated with the entered email.
  Future<void> _resetPassword(BuildContext context) async {
    if (_controllerEmail.text.isEmpty) {
      snackbarError(context, S.current.errorEmptyFields);
      return;
    }

    // Show a loading icon
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _controllerEmail.text)
          .then((value) => snackbarInfo(context, S.current.emailSent));
    } on FirebaseAuthException catch (e) {
      errorFirebaseAuthSnackbar(context, e);
      return;
    } finally {
      Navigator.of(context).pop(); // Not working
    }
  }

  Widget _emailButton() {
    return MyTextFormWidget(
      controller: _controllerEmail,
      hintText: "Email",
      obscureText: false,
      prefixIcon: const Icon(Icons.email),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [
      _emailButton(),
      const SizedBox(height: kDouble25),
      blackButton(
        context: context,
        text: S.current.sendEmail,
        onTap: _resetPassword,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.resetPassword),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(kDoublePaddingBasic),
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return list[index];
            },
          ),
        ),
      ),
    );
  }
}
