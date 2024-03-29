import 'package:corriol_app/generated/l10n.dart';
import 'package:corriol_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// A page that displays contact information, including emergency number, email, and website.
class ContactPage extends StatelessWidget {
  ContactPage({super.key});

  /// Gepec's url website.
  final Uri _url = Uri.parse('https://gepec.cat');

  /// Gepec's email.
  final Uri _emailLaunchUri = Uri(scheme: 'mailto', path: 'especies@gepec.cat');

  @override
  Widget build(BuildContext context) {
    final List<Widget> list = [
      Text(
        S.current.warningText112,
        textAlign: TextAlign.center,
      ),
      const Text('112',
          style: TextStyle(fontSize: 46, color: kColorText),
          textAlign: TextAlign.center),
      const SizedBox(height: 15),
      // mail
      GestureDetector(
        onTap: () => _launchUrl(_emailLaunchUri),
        child: Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
            text: S.current.emailText,
            // style: const TextStyle(fontSize: 16),
            children: <TextSpan>[
              TextSpan(
                text: _emailLaunchUri.path,
                style: const TextStyle(
                  fontSize: 32,
                  color: kColorText,
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
            text: S.current.webText,
            // style: const TextStyle(fontSize: 16),
            children: const <TextSpan>[
              TextSpan(
                text: 'gepec.cat',
                style: TextStyle(
                  fontSize: 32,
                  color: kColorText,
                  // decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 15),
      Image.asset('assets/images/GEPEC_EdC_OFICIAL.png'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.current.contact,
          style: kTextStylePageTitle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kDoubleMainPadding),
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) => list[index],
        ),
      ),
    );
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('${S.current.errorLaunchUrl} $url');
    }
  }
}
