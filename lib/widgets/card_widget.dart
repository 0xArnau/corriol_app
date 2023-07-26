import 'package:corriol_app/utils/constants.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget(
      {super.key,
      required this.imagePath,
      required this.text,
      required this.background,
      required this.foreground,
      required this.page});

  final String imagePath;
  final String text;
  final Color background;
  final Color foreground;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return page;
        }));
      },
      child: Card(
        color: background,
        child: Container(
          padding: const EdgeInsets.all(kDouble25),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image(
                  image: AssetImage(imagePath),
                  width: 56.0,
                  color: Colors.black,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: foreground,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
