import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corriol_app/generated/l10n.dart';
import 'package:corriol_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class AuthController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  void userReload() => currentUser!.reload();

  bool isEmailVerified() {
    userReload();
    return currentUser!.emailVerified;
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    _firebaseAuth.signOut();
  }

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

  Future<void> addUserInformation(UserModel user) async {
    try {
      await FirebaseFirestore.instance.collection('Users').add(user.toJson());
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<UserModel?> getUserInformation() async {
    try {
      UserModel? user;
      await FirebaseFirestore.instance
          .collection('Users')
          .get()
          .then((snapshot) {
        for (var document in snapshot.docs) {
          if (document.data()['email'] == currentUser!.email) {
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
}
