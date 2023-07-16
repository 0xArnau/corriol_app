import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void errorFirebaseAuthSnackbar(BuildContext context, FirebaseAuthException e) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        "$e",
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
      duration: const Duration(seconds: 15),
      backgroundColor: Colors.red[200],
    ),
  );
}

void errorAuthFieldsSnackbar(BuildContext context, String e) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        e,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.red[200],
    ),
  );
}

void snackbarInfo(BuildContext context, String e) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        e,
      ),
      duration: const Duration(seconds: 3),
      // backgroundColor: Colors.red[200],
    ),
  );
}
