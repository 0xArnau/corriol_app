import 'package:corriol_app/generated/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

/// Determines the message to show based on [FirebaseAuthException].
void errorFirebaseAuthSnackbar(BuildContext context, FirebaseAuthException e) {
  switch (e.code) {
    case "user-not-found":
      _errorFirebaseAuthSnackbar(context, S.current.userNotFound);
      break;
    case "invalid-email":
      _errorFirebaseAuthSnackbar(context, S.current.invalidEmail);
      break;
    case "email-already-in-use":
      _errorFirebaseAuthSnackbar(context, S.current.emailAlreadyInUse);
      break;
    default:
      Logger().d(e.code);
      _errorFirebaseAuthSnackbar(context, e.message);
  }
}

/// Shows a [SnackBar] with an error message.
void _errorFirebaseAuthSnackbar(BuildContext context, String? e) {
  Logger().d(e);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        "$e",
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
      duration: const Duration(seconds: 5),
      backgroundColor: Colors.red[200],
    ),
  );
}

/// Shows a [SnackBar] with a generic error message [str]
void snackbarInfo(BuildContext context, String str) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        str,
      ),
      duration: const Duration(seconds: 3),
      // backgroundColor: Colors.red[200],
    ),
  );
}

/// Shows a [SnackBar] with a generic message [str]
void snackbarError(BuildContext context, String str) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        str,
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.red[200],
      // backgroundColor: Colors.red[200],
    ),
  );
}
