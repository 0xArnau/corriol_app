import 'package:corriol_app/controllers/auth_controller.dart';
import 'package:corriol_app/core/constants.dart';
import 'package:corriol_app/models/user_model.dart';
import 'package:corriol_app/pages/auth/login_page.dart';
import 'package:corriol_app/widgets/buttons/my_button_widget.dart';
import 'package:corriol_app/widgets/my_text_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    super.key,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final ageController = TextEditingController();
  final nameController = TextEditingController();

  String? errorMessage = '';

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    ageController.dispose();
    nameController.dispose();
  }

  void signUserUp() async {
    BuildContext dialogContext = context;
    print('signUserUp');

    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      if (passwordController.text == confirmPasswordController.text) {
        // Create the user
        await AuthController().createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        setState(() {
          errorMessage = '';
        });

        // Add user details
        await AuthController().addUserInformation(UserModel(
          email: emailController.text,
          fullName: nameController.text,
          age: int.parse(ageController.text),
        ));
      } else {
        setState(() {
          errorMessage = 'Passwords don\'t match';
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        setState(() {
          errorMessage = 'Email already in use.';
        });
      } else if (e.code == 'weak-password') {
        setState(() {
          errorMessage = 'Weak password.';
        });
      }
    } catch (e) {
      print(e);
    } finally {
      Navigator.pop(dialogContext);
    }
  }

  Widget _errorMessage() {
    return Text(
      errorMessage == '' ? '' : '$errorMessage',
      style: const TextStyle(color: Colors.red),
    );
  }

  Widget _login() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already a member?',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Text(
            'Login now',
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(kDoublePaddingBasic),
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App name
              const Text(
                'Corriol APP',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: kColorPrimaryBlue,
                ),
              ),
              const SizedBox(height: 100),
              MyTextFieldWidget(
                controller: nameController,
                hintText: 'Name',
                obscureText: false,
              ),
              const SizedBox(height: 15),
              MyTextFieldWidget(
                controller: ageController,
                hintText: 'Age',
                obscureText: false,
              ),
              const SizedBox(height: 15),
              MyTextFieldWidget(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),
              const SizedBox(height: 15),
              MyTextFieldWidget(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 15),
              MyTextFieldWidget(
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
                obscureText: true,
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDouble25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _errorMessage(),
                  ],
                ),
              ),
              const SizedBox(height: 26),
              MyButtonWidget(
                onTap: () {
                  signUserUp();
                  Navigator.pop(context);
                },
                text: 'Sign Up',
                icon: const Icon(
                  Icons.email,
                  color: Colors.white,
                ),
              ),
              // const Spacer(),
              const SizedBox(height: 100),
              _login(),
            ],
          ),
        ),
      ),
    );
  }
}
