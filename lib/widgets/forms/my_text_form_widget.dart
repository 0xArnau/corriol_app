import 'package:corriol_app/utils/constants.dart';
import 'package:flutter/material.dart';

class MyTextFormWidget extends StatelessWidget {
  const MyTextFormWidget({
    super.key,
    this.controller,
    this.onTap,
    required this.hintText,
    required this.obscureText,
    required this.prefixIcon,
  });

  final TextEditingController? controller;
  final void Function()? onTap;
  final String hintText;
  final bool obscureText;
  final Icon prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        labelText: hintText,
        // hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kDoubleBorderRadiusButtons),
        ),
      ),
      obscureText: obscureText,
      controller: controller,
      onTap: onTap,
    );
  }
}
