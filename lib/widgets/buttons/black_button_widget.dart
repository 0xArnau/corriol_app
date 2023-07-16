import 'package:corriol_app/core/constants.dart';
import 'package:flutter/material.dart';

Widget blackButton({
  required BuildContext context,
  required String text,
  required Function onTap,
}) {
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
