import 'package:corriol_app/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class CorriolPage extends StatelessWidget {
  const CorriolPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).meetKentishPlover,
          style: kTextStylePageTitle,
        ),
      ),
      body: SafeArea(
        child: IntroductionScreen(
          showDoneButton: true,
          showNextButton: true,
          showBackButton: true,
          isProgress: false,
          back: Theme.of(context).platform == TargetPlatform.iOS
              ? const Icon(Icons.arrow_back_ios)
              : const Icon(Icons.arrow_back),
          next: Theme.of(context).platform == TargetPlatform.iOS
              ? const Icon(Icons.arrow_forward_ios)
              : const Icon(Icons.arrow_forward),
          done: const Icon(Icons.done),
          onDone: () {
            Navigator.pop(context);
          },
          pages: [
            myPageViewModel(
              title: '',
              textBefore:
                  AppLocalizations.of(context).screen_1_1_Foto_1_1_1_before,
              textAfter:
                  AppLocalizations.of(context).screen_1_1_Foto_1_1_1_after,
              image: 'assets/images/Screen-1_1/Foto-1_1_1.jpg',
            ),
            myPageViewModel(
              title: '',
              textBefore:
                  AppLocalizations.of(context).screen_1_1_Foto_1_1_2_before,
              textAfter:
                  AppLocalizations.of(context).screen_1_1_Foto_1_1_2_after,
              image: 'assets/images/Screen-1_1/Foto-1_1_2.jpg',
            ),
            myPageViewModel(
              title: '',
              textBefore:
                  AppLocalizations.of(context).screen_1_1_Foto_1_1_3_before,
              textAfter:
                  AppLocalizations.of(context).screen_1_1_Foto_1_1_3_after,
              image: 'assets/images/Screen-1_1/Foto-1_1_3.jpg',
            ),
            myPageViewModel(
              title: '',
              textBefore:
                  AppLocalizations.of(context).screen_1_1_Foto_1_1_4_before,
              textAfter:
                  AppLocalizations.of(context).screen_1_1_Foto_1_1_4_after,
              image: 'assets/images/Screen-1_1/Foto-1_1_4.jpeg',
            ),
            myPageViewModel(
              title: '',
              textBefore:
                  AppLocalizations.of(context).screen_1_1_Foto_1_1_5_before,
              textAfter:
                  AppLocalizations.of(context).screen_1_1_Foto_1_1_5_after,
              image: 'assets/images/Screen-1_1/Foto-1_1_5.jpeg',
            ),
            myPageViewModel(
              title: '',
              textBefore:
                  AppLocalizations.of(context).screen_1_1_Foto_1_1_6_before,
              textAfter:
                  AppLocalizations.of(context).screen_1_1_Foto_1_1_6_after,
              image: 'assets/images/Screen-1_1/Foto-1_1_6.jpg',
            ),
            myPageViewModel(
              title: '',
              textBefore:
                  AppLocalizations.of(context).screen_1_1_Foto_1_1_7_before,
              textAfter:
                  AppLocalizations.of(context).screen_1_1_Foto_1_1_7_after,
              image: 'assets/images/Screen-1_1/Foto-1_1_7.jpg',
            ),
            myPageViewModel(
              title: '',
              textBefore:
                  AppLocalizations.of(context).screen_1_1_Foto_1_1_8_before,
              textAfter:
                  AppLocalizations.of(context).screen_1_1_Foto_1_1_8_after,
              image: 'assets/images/Screen-1_1/Foto-1_1_8.jpeg',
            ),
          ],
        ),
      ),
    );
  }

  PageViewModel myPageViewModel({
    required String title,
    required String textBefore,
    required String textAfter,
    required String image,
  }) =>
      PageViewModel(
        title: title, // Empty string, cannot be null
        bodyWidget: Column(
          children: [
            Text(
              textBefore,
              style: const TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20), // Espacio entre texto e imagen
            Image.asset(image),
            const SizedBox(height: 20), // Espacio entre imagen y texto
            Text(
              textAfter,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      );
}
