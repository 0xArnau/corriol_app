import 'package:corriol_app/core/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  ContactPage({super.key});

  final Uri _url = Uri.parse('https://gepec.cat');
  // final String _mail = 'especies@gepec.cat';
  final Uri _emailLaunchUri = Uri(scheme: 'mailto', path: 'especies@gepec.cat');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).contact,
          style: kTextStylePageTitle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kDouble25),
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context).warningText112,
              textAlign: TextAlign.center,
            ),
            const Text('112',
                style: TextStyle(fontSize: 46, color: kColorPrimaryBlue),
                textAlign: TextAlign.center),
            const SizedBox(height: 15),
            // mail
            GestureDetector(
              onTap: () => _launchUrl(_emailLaunchUri),
              child: Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  text: AppLocalizations.of(context).emailText,
                  // style: const TextStyle(fontSize: 16),
                  children: <TextSpan>[
                    TextSpan(
                      text: _emailLaunchUri.path,
                      style: const TextStyle(
                        fontSize: 32,
                        color: kColorPrimaryBlue,
                        // decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            // webpage
            GestureDetector(
              onTap: () => _launchUrl(_url),
              child: Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  text: AppLocalizations.of(context).webText,
                  // style: const TextStyle(fontSize: 16),
                  children: const <TextSpan>[
                    TextSpan(
                      text: 'gepec.cat',
                      style: TextStyle(
                        fontSize: 32,
                        color: kColorPrimaryBlue,
                        // decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // const Spacer(),
            // Expanded(
            //   child: Image.asset(
            //     'assets/images/CorriolAPP.png',
            //   ),
            // ),
            const Spacer(),
            Image.asset('assets/images/GEPEC_EdC_OFICIAL.png'),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
