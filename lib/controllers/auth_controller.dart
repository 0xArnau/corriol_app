import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corriol_app/generated/l10n.dart';
import 'package:corriol_app/models/user_model.dart';
import 'package:corriol_app/utils/my_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:logger/logger.dart';

/// Class that provides functionality to the [UserModel] class.
///
/// The class provides methods to sign in, sign up, sign out, check email verification,
/// reload user data, and retrieve user information from the [FirebaseAuth] & [FirebaseFirestore].
class AuthController {
  /// Instance of [FirebaseAuth] for handling user authentication.
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// Get the currently signed-in user, if any.
  User? get currentUser => _firebaseAuth.currentUser;

  /// A stream of the current authentication state changes.
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  /// Reload the user data to ensure the latest email verification status.
  void userReload() => currentUser!.reload();

  /// Reloads the user data to ensure the latest email verification status,
  /// and then returns `true` if the user's email is verified, otherwise `false`.
  bool isEmailVerified() {
    userReload();
    return currentUser!.emailVerified;
  }

  /// Signs in the user with the provided email and password using [FirebaseAuth].
  /// It returns a `Future<void>` which completes when the sign-in process is successful.
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email.toLowerCase(),
      password: password,
    );
  }

  /// Creates a new user account with the provided email and password using Firebase Authentication.
  /// It returns a `Future<void>` which completes when the account is created successfully.
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email.toLowerCase(),
      password: password,
    );
  }

  /// Sign out the currently signed-in user.
  Future<void> signOut() async {
    _firebaseAuth.signOut();
  }

  /// Sends an email verification link to the user's email address
  /// and returns a `Future<String>` with the status message of the operation.
  Future<String> sendEmailVerification() async {
    String status = '';
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      status = S.current.emailSent;
    } catch (e) {
      status = e.toString();
    }
    return status;
  }

  /// Adds user information to the 'Users' collection in the [FirebaseFirestore].
  /// It takes a [UserModel] object as input and returns a `Future<void>` which completes when the operation is successful.
  Future<void> addUserInformation(UserModel user) async {
    try {
      await FirebaseFirestore.instance.collection('Users').add(user.toJson());
    } catch (e) {
      Logger().e(e);
    }
  }

  /// Retrieves user information from the 'Users' collection in the [FirebaseFirestore]
  /// based on the currently signed-in user's email address. It returns a `Future<UserModel?>`
  /// with the user information if found, otherwise `null`.
  Future<UserModel?> getUserInformation() async {
    try {
      UserModel? user;
      await FirebaseFirestore.instance
          .collection('Users')
          .get()
          .then((snapshot) {
        for (var document in snapshot.docs) {
          if (document.data()['email'].toString().toLowerCase() ==
              currentUser?.email?.toLowerCase()) {
            user = UserModel.fromJson(document.data());
          }
        }
      });
      return user;
    } catch (e) {
      Logger().e(e);

      return null;
    }
  }

  /// Remove the user information (Collection 'Users') and the user account (Auth)
  Future<void> deleteUserAccountAndInformation(BuildContext context) async {
    String testingAccountEmail = FlutterConfig.get("TESTING_ACCOUNT_EMAIL");
    // Remove the user info
    await FirebaseFirestore.instance
        .collection('Users')
        .get()
        .then((snapshot) {
          for (var document in snapshot.docs) {
            if (currentUser?.email?.toLowerCase() == testingAccountEmail) {
              // Logger().d("/Users -> ${currentUser?.email} cannot be removed");
              break;
            }
            if (document.data()['email'] == currentUser?.email) {
              document.reference
                  .delete()
                  .then((_) => Logger().d("Removed 'User' document"));
            }
          }
        })
        .then((_) {
          // Remove the account
          if (currentUser?.email != testingAccountEmail) {
            currentUser?.delete().then((_) {
              Logger().d("Removed account");
            }).catchError((e) {
              Logger().e("User account: $e");

              if (e is FirebaseAuthException) {
                errorFirebaseAuthSnackbar(context, e);
              }
            });
          } else {
            // Logger().d("Auth -> ${currentUser?.email} cannot be removed");
            snackbarInfo(context, S.current.userCannotBeRemoved);
          }
        })
        .then((_) => Navigator.of(context).pop())
        .catchError((e) {
          Logger().e("User collection: $e");
          Navigator.of(context).pop();
        });
  }
}
