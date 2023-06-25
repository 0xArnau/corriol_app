import 'package:corriol_app/auth.dart';
import 'package:corriol_app/core/constants.dart';
import 'package:corriol_app/pages/auth/auth_page.dart';
import 'package:corriol_app/pages/auth/forgot_password_page.dart';
import 'package:corriol_app/pages/auth/register_page.dart';
import 'package:corriol_app/widgets/buttons/my_button_widget.dart';
import 'package:corriol_app/widgets/my_text_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controllerEmail = TextEditingController();

  final TextEditingController _controllerPassword = TextEditingController();

  String? errorMessage = '';

  Future<void> signInWithEmailAndPassword(BuildContext context) async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    } finally {
      if (errorMessage == '') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const AuthPage()),
        );
      }
    }
  }

  Widget _title() {
    return const Center(
      child: Text(
        'CorriolAPP',
        style: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: kColorPrimaryBlue,
        ),
      ),
    );
  }

  Widget _errorMessage() {
    return Text(
      errorMessage == '' ? '' : errorMessage!,
      style: const TextStyle(color: Colors.red),
    );
  }

  Widget _forgotPassword() {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ForgotPasswordPage(),
        ),
      ),
      child: const Text(
        'Forgot password?',
        style: TextStyle(color: Colors.grey),
      ),
    );
  }

  Widget _register() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Not a member?',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const RegisterPage(),
            ),
          ),
          child: const Text(
            'Register now',
            style: TextStyle(
                color: kColorPrimaryBlue, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(kDoublePaddingBasic),
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              _title(),
              SizedBox(
                  height: kDouble25 *
                      2 *
                      (MediaQuery.of(context).size.height /
                          MediaQuery.of(context).size.width)),
              MyTextFieldWidget(
                hintText: 'Email',
                controller: _controllerEmail,
                obscureText: false,
              ),
              const SizedBox(height: kDouble15),
              MyTextFieldWidget(
                hintText: 'Password',
                controller: _controllerPassword,
                obscureText: true,
              ),
              const SizedBox(height: kDouble15),
              _errorMessage(),
              _forgotPassword(),
              const SizedBox(height: kDouble25),
              MyButtonWidget(
                text: 'Login',
                icon: const Icon(
                  Icons.login,
                  color: Colors.white,
                ),
                onTap: () {
                  signInWithEmailAndPassword(context);
                },
              ),
              const SizedBox(height: kDouble25),
              _register(),
            ],
          ),
        ),
      ),
    );
  }
}
