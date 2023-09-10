import 'package:corriol_app/controllers/auth_controller.dart';
import 'package:corriol_app/generated/l10n.dart';
import 'package:corriol_app/models/user_model.dart';
import 'package:corriol_app/pages/auth/forgot_password_page.dart';
import 'package:corriol_app/utils/constants.dart';
import 'package:corriol_app/utils/my_snackbar.dart';
import 'package:corriol_app/widgets/buttons/black_button_widget.dart';
import 'package:corriol_app/widgets/buttons/sso_button_widget.dart';
import 'package:corriol_app/widgets/forms/my_text_form_widget.dart';
import 'package:corriol_app/widgets/pdf_viewer_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// A widget representing the "Login/Register" page.
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
  final TextEditingController _controllerName = TextEditingController();
  late final TextEditingController _controllerYearOfBirth =
      TextEditingController();

  bool checkBoxLegal = false;
  bool checkBoxInfo = false;
  bool checkBoxPrivacy = false;

  List<bool> isSelected = [true, false];

  @override
  void dispose() {
    _controllerPassword.dispose();
    _controllerConfirmPassword.dispose();
    _controllerEmail.dispose();
    _controllerName.dispose();
    _controllerYearOfBirth.dispose();
    super.dispose();
  }

  /// Using [FirebaseAuth.signInWithEmailAndPassword] signs in the user with the provided email and password.
  ///
  /// If the passwords don't match shows a [errorFirebaseAuthSnackbar] error message.
  Future<void> signInWithEmailAndPassword(BuildContext context) async {
    if (_controllerEmail.text == "" || _controllerPassword.text == "") {
      snackbarError(context, S.current.errorEmptyFields);
    } else {
      // Show a loading icon
      // showDialog(
      //   context: context,
      //   builder: (context) {
      //     return const Center(
      //       child: CircularProgressIndicator(),
      //     );
      //   },
      // );

      try {
        await AuthController().signInWithEmailAndPassword(
          email: _controllerEmail.text,
          password: _controllerPassword.text,
        );
      } on FirebaseAuthException catch (e) {
        errorFirebaseAuthSnackbar(context, e);
      }
    }
  }

  /// Using [FirebaseAuth.createUserWithEmailAndPassword], registers a new user with the provided email, password, name, and age.
  ///
  /// If a field is empty show a [errorFirebaseAuthSnackbar] error message.
  Future<void> registerWithEmailAndPassword(BuildContext context) async {
    if (_controllerYearOfBirth.text.isEmpty ||
        _controllerConfirmPassword.text.isEmpty ||
        _controllerEmail.text.isEmpty ||
        _controllerName.text.isEmpty ||
        _controllerPassword.text.isEmpty) {
      snackbarError(context, S.current.errorEmptyFields);
    } else if (_controllerConfirmPassword.text != _controllerPassword.text) {
      snackbarError(context, S.current.errorDifferentPasswords);
    } else if (!checkBoxLegal) {
      snackbarError(context, S.current.checkboxLegal);
    } else if (!checkBoxInfo) {
      snackbarError(context, S.current.checkboxInfo);
    } else if (!checkBoxPrivacy) {
      snackbarError(context, S.current.checkboxPrivacy);
    } else {
      // Show a loading icon
      // showDialog(
      //   context: context,
      //   builder: (context) {
      //     return const Center(
      //       child: CircularProgressIndicator(),
      //     );
      //   },
      // );

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
            yearOfBirth: int.parse(_controllerYearOfBirth.text),
          ),
        );
      } on FirebaseAuthException catch (e) {
        errorFirebaseAuthSnackbar(context, e);
      }
    }
  }

  void _showYearPicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value != null) {
        if (mounted) {
          setState(() {
            _controllerYearOfBirth.text = "${value.year}";
          });
        }
      }
    });
  }

  Widget _title() {
    return const Text(
      'CorriolAPP',
      style: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: kColorText,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _forgotPassword() {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ForgotPasswordPage(),
        ),
      ),
      child: Text(
        S.current.forgotPassword,
        style: const TextStyle(color: Colors.grey),
      ),
    );
  }

  // ignore: unused_element
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

  Widget _legalStuff(
      {required String asset,
      required String text,
      required bool isAccepted,
      required Function(bool) onChanged}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: isAccepted,
          onChanged: (value) => onChanged(value ?? false),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PdfViewerWidget(
                      title: text,
                      path: asset,
                    ),
                  ),
                );
              },
              child: Text(
                text,
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.blue,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _login() {
    return Column(
      children: [
        // Email
        MyTextFormWidget(
          hintText: S.current.email,
          controller: _controllerEmail,
          obscureText: false,
          prefixIcon: const Icon(Icons.email),
        ),
        const SizedBox(height: kDouble15),
        // Password
        MyTextFormWidget(
          hintText: S.current.password,
          controller: _controllerPassword,
          obscureText: true,
          prefixIcon: const Icon(Icons.fingerprint),
        ),
        const SizedBox(height: kDouble15),
        const SizedBox(height: kDouble15),
        // Login button
        blackButton(
          context: context,
          text: S.current.signIn,
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

  Widget _register() {
    return Column(
      children: [
        // Name
        MyTextFormWidget(
          hintText: S.current.name,
          controller: _controllerName,
          obscureText: false,
          prefixIcon: const Icon(Icons.person),
        ),
        const SizedBox(height: kDouble15),
        // Age
        MyTextFormWidget(
          hintText: S.current.yearOfBirth,
          controller: _controllerYearOfBirth,
          onTap: () {
            _showYearPicker(context);
          },
          obscureText: false,
          prefixIcon: const Icon(Icons.calendar_today_rounded),
        ),
        const SizedBox(height: kDouble15),
        // Email
        MyTextFormWidget(
          hintText: S.current.email,
          controller: _controllerEmail,
          obscureText: false,
          prefixIcon: const Icon(Icons.email),
        ),
        const SizedBox(height: kDouble15),
        // Password
        MyTextFormWidget(
          hintText: S.current.password,
          controller: _controllerPassword,
          obscureText: true,
          prefixIcon: const Icon(Icons.fingerprint),
        ),
        const SizedBox(height: kDouble15),
        // Confirmation Password
        MyTextFormWidget(
          hintText: S.current.confirmationPassword,
          controller: _controllerConfirmPassword,
          obscureText: true,
          prefixIcon: const Icon(Icons.fingerprint),
        ),
        const SizedBox(height: kDouble15),
        const SizedBox(height: kDouble15),
        // Register button
        blackButton(
          context: context,
          text: S.current.signUp,
          onTap: registerWithEmailAndPassword,
        ),
        const SizedBox(height: kDouble25),
        // Docs
        _legalStuff(
          asset: 'assets/docs/legal/avis-legal.pdf',
          text: S.current.legalWarning,
          isAccepted: checkBoxLegal,
          onChanged: (value) {
            if (mounted) {
              setState(() {
                checkBoxLegal = value;
              });
            }
          },
        ),
        _legalStuff(
          asset: 'assets/docs/legal/clausula-informativa.pdf',
          text: S.current.infoClause,
          isAccepted: checkBoxInfo,
          onChanged: (value) {
            if (mounted) {
              setState(() {
                checkBoxInfo = value;
              });
            }
          },
        ),
        _legalStuff(
          asset: 'assets/docs/legal/privacitat.pdf',
          text: S.current.privacyPolicy,
          isAccepted: checkBoxPrivacy,
          onChanged: (value) {
            if (mounted) {
              setState(() {
                checkBoxPrivacy = value;
              });
            }
          },
        ),

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
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ToggleButtons(
          isSelected: isSelected,
          onPressed: (index) {
            if (mounted) {
              setState(() {
                isSelected[index] = !isSelected[index];
                isSelected[(index + 1) % 2] = !isSelected[(index + 1) % 2];
              });
            }
          },
          selectedColor: Colors.white,
          selectedBorderColor: Colors.black,
          fillColor: Colors.black,
          borderRadius: BorderRadius.circular(kDoubleBorderRadiusButtons),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDouble20),
              child: _optionsTextStyle(S.current.signIn),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDouble20),
              child: _optionsTextStyle(S.current.signUp),
            ),
          ],
        ),
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
            padding: const EdgeInsets.all(kDoublePaddingBasic),
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
