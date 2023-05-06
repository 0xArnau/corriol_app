import 'package:corriol_app/core/constants.dart';
import 'package:corriol_app/widgets/buttons/my_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  String? _status = null;
  String? _errorMessage = '';

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Widget _MyErrorMessage() {
    return Text(
      _errorMessage == '' ? '' : '$_errorMessage',
      style: const TextStyle(color: Colors.red),
    );
  }

  Future resetPassword() async {
    // Show a loading icon
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailController.text)
        .then((value) => _status = 'Emailed send to: ${emailController.text}')
        .catchError((e) => _status = e.code);
    setState(() {
      _errorMessage = _status;
    });
    print(_errorMessage);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: kColorPrimaryBlue,
        elevation: 0,
        title: const Text(
          'Reset password',
          style: TextStyle(color: kColorPrimaryBlue),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                // cursorColor: primaryBlueColor,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: 'Email',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade500,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade900),
                  ),
                  fillColor: Colors.grey.shade100,
                  filled: true,
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) {
                  return email == null && email!.isEmpty
                      ? 'Enter a valid email'
                      : null;
                },
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDouble25),
                child: _MyErrorMessage(),
              ),
              const SizedBox(height: 25),
              MyButtonWidget(
                text: 'Reset password',
                icon: const Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                onTap: resetPassword,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
