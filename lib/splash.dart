import 'package:corriol_app/utils/constants.dart';
import 'package:corriol_app/pages/auth/auth_page.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(const Duration(milliseconds: 1500), () {});
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const AuthPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
                  child: Text(
                    'Corriol APP',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: kColorText,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                  child: Image.asset('assets/images/CorriolAPP.png'),
                ),
              ),
              // const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                  child: Image.asset('assets/images/GEPEC_EdC_OFICIAL.png'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
