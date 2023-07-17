import 'package:corriol_app/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SSOButtonWidget extends StatelessWidget {
  const SSOButtonWidget({
    super.key,
    required this.svgPath,
    // required this.text,
    required this.onTap,
  });

  final String svgPath;
  // final String text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: kDouble15),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: SvgPicture.asset(
            svgPath,
            height: 22,
          ),
        ),
      ),
    );
  }
}
