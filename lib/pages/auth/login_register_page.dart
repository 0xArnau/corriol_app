import 'package:corriol_app/controllers/auth_controller.dart';
import 'package:corriol_app/core/constants.dart';
import 'package:corriol_app/models/user_model.dart';
import 'package:corriol_app/pages/auth/auth_page.dart';
import 'package:corriol_app/pages/auth/forgot_password_page.dart';
import 'package:corriol_app/widgets/buttons/sss_button_widget.dart';
import 'package:corriol_app/widgets/forms/my_text_form_widget.dart';
import 'package:corriol_app/widgets/snackbars/firebase_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginRegisterPage extends StatefulWidget {
  const LoginRegisterPage({super.key});

  @override
  State<LoginRegisterPage> createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConfirmPassword =
      TextEditingController();
  final TextEditingController _controllerAge = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();

  List<bool> isSelected = [true, false];

  @override
  void dispose() {
    _controllerPassword.dispose();
    _controllerConfirmPassword.dispose();
    _controllerEmail.dispose();
    _controllerName.dispose();
    _controllerAge.dispose();
    super.dispose();
  }

  Future<void> signInWithEmailAndPassword(BuildContext context) async {
    if (_controllerEmail.text == "" || _controllerPassword.text == "") {
      errorAuthFieldsSnackbar(context, "Empty fields");

      return;
    }

    try {
      await AuthController().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      errorFirebaseAuthSnackbar(context, e);
      return;
    } finally {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const AuthPage(),
        ),
      );
    }
  }

  Future<void> registerWithEmailAndPassword(BuildContext context) async {
    if (_controllerAge.text.isEmpty ||
        _controllerConfirmPassword.text.isEmpty ||
        _controllerEmail.text.isEmpty ||
        _controllerName.text.isEmpty ||
        _controllerPassword.text.isEmpty) {
      errorAuthFieldsSnackbar(context, "Empty fields");
      return;
    } else if (_controllerConfirmPassword.text != _controllerPassword.text) {
      errorAuthFieldsSnackbar(context, "Passwords are different");
      return;
    }

    try {
      // Create the user
      await AuthController().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );

      // Add user details
      await AuthController().addUserInformation(
        UserModel(
          email: _controllerEmail.text,
          fullName: _controllerName.text,
          age: int.parse(_controllerAge.text),
        ),
      );
    } on FirebaseAuthException catch (e) {
      errorFirebaseAuthSnackbar(context, e);
      return;
    } finally {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const AuthPage(),
        ),
      );
    }
  }

  Widget _title() {
    return const Text(
      'CorriolAPP',
      style: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: kColorPrimaryBlue,
      ),
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

  Widget _sso() {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SSOButtonWidget(
            svgPath: 'assets/images/sso/Google_logo.svg',
            onTap: null,
            // text: 'Login with Google',
          ),
          SSOButtonWidget(
            svgPath: 'assets/images/sso/Apple_logo.svg',
            onTap: null,
            // text: 'Login with Google',
          ),
          SSOButtonWidget(
            svgPath: 'assets/images/sso/Microsoft_logo.svg',
            onTap: null,
            // text: 'Login with Google',
          ),
        ],
      ),
    );
  }

  Widget _login() {
    return Column(
      children: [
        // Email
        MyTextFormWidget(
          hintText: 'Email',
          controller: _controllerEmail,
          obscureText: false,
          prefixIcon: const Icon(Icons.email),
        ),
        const SizedBox(height: kDouble15),
        // Password
        MyTextFormWidget(
          hintText: 'Password',
          controller: _controllerPassword,
          obscureText: true,
          prefixIcon: const Icon(Icons.fingerprint),
        ),
        const SizedBox(height: kDouble15),
        const SizedBox(height: kDouble15),
        // Login button
        _loginregisterButton(
          text: "Sign In",
          onTap: signInWithEmailAndPassword,
        ),
        const SizedBox(height: kDouble10),
        _forgotPassword(),
        const SizedBox(height: kDouble25),
        // SSO
        // _sso(),
      ],
    );
  }

  Widget _loginregisterButton({required String text, required Function onTap}) {
    return GestureDetector(
      onTap: () {
        onTap(context);
      },
      child: Container(
        padding: const EdgeInsets.all(kDoublePaddingMyButtonAndMyTextField),
        // margin: const EdgeInsets.symmetric(horizontal: kDouble25),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(kDoubleBorderRadiusButtons),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _register() {
    return Column(
      children: [
        // Name
        MyTextFormWidget(
          hintText: 'Name',
          controller: _controllerName,
          obscureText: false,
          prefixIcon: const Icon(Icons.person),
        ),
        const SizedBox(height: kDouble15),
        // Age
        MyTextFormWidget(
          hintText: 'Age',
          controller: _controllerAge,
          obscureText: false,
          prefixIcon: const Icon(Icons.numbers),
        ),
        const SizedBox(height: kDouble15),
        // Email
        MyTextFormWidget(
          hintText: 'Email',
          controller: _controllerEmail,
          obscureText: false,
          prefixIcon: const Icon(Icons.email),
        ),
        const SizedBox(height: kDouble15),
        // Password
        MyTextFormWidget(
          hintText: 'Password',
          controller: _controllerPassword,
          obscureText: true,
          prefixIcon: const Icon(Icons.fingerprint),
        ),
        const SizedBox(height: kDouble15),
        // Confirmation Password
        MyTextFormWidget(
          hintText: 'Confirmation Password',
          controller: _controllerConfirmPassword,
          obscureText: true,
          prefixIcon: const Icon(Icons.fingerprint),
        ),
        const SizedBox(height: kDouble15),
        const SizedBox(height: kDouble15),
        // Register button
        _loginregisterButton(
          text: "Register",
          onTap: registerWithEmailAndPassword,
        ),
        const SizedBox(height: kDouble25),
        // SSO
        // _sso(),
      ],
    );
  }

  Widget _optionsTextStyle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _options() {
    return Center(
      child: ToggleButtons(
        isSelected: isSelected,
        onPressed: (index) {
          setState(() {
            isSelected[index] = !isSelected[index];
            isSelected[(index + 1) % 2] = !isSelected[(index + 1) % 2];
          });
        },
        selectedColor: Colors.white,
        selectedBorderColor: Colors.black,
        fillColor: Colors.black,
        borderRadius: BorderRadius.circular(kDoubleBorderRadiusButtons),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDouble20),
            child: _optionsTextStyle("Login"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDouble20),
            child: _optionsTextStyle("Register"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [
      _title(),
      SizedBox(
        height: kDouble25 *
            (MediaQuery.of(context).size.height /
                MediaQuery.of(context).size.width),
      ),
      // Login
      Visibility(
        visible: isSelected[0],
        child: _login(),
      ),
      // Register
      Visibility(
        visible: isSelected[1],
        child: _register(),
      ),
      SizedBox(
        height: kDouble25 *
            (MediaQuery.of(context).size.height /
                MediaQuery.of(context).size.width),
      ),
      _options(),
    ];
    return Scaffold(
      // backgroundColor: kColorLightBackground,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(kDouble20 * 2),
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return list[index];
              },
            ),
          ),
        ),
      ),
    );
  }
}
