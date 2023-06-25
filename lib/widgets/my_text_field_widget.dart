import 'package:corriol_app/core/constants.dart';
import 'package:flutter/material.dart';

class MyTextFieldWidget extends StatelessWidget {
  const MyTextFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade500,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade900,
          ),
        ),
        fillColor: Colors.grey.shade100,
        filled: true,
        hintText: hintText,
      ),
    );
  }
}
