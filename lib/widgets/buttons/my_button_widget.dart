import 'package:corriol_app/core/constants.dart';
import 'package:flutter/material.dart';

class MyButtonWidget extends StatelessWidget {
  const MyButtonWidget({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  final Function()? onTap;
  final String text;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(kDoublePaddingMyButtonAndMyTextField),
        // margin: const EdgeInsets.symmetric(horizontal: kDouble25),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              icon,
              Center(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
