import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

enum Status { Authenticated, Authenticating, Unauthenticated, Fail, SigningOut }

class AuthService with ChangeNotifier {
  Status _status = Status.Unauthenticated;

  Status get status => _status;

  UserCredential userCredential;
  String errorMessage = "";

  void signInWithGoogle() async {
    _changeStatus(Status.Authenticating);
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithPopup(googleProvider)
        .catchError((e) {
      errorMessage = e.toString();
      _changeStatus(Status.Fail);
    });
    if (userCredential != null) {
      this.userCredential = userCredential;
      _changeStatus(Status.Authenticated);
    }
  }

  Future<void> signOut() async {
    _changeStatus(Status.SigningOut);
    await FirebaseAuth.instance.signOut();
    _changeStatus(Status.Unauthenticated);
  }

  void _changeStatus(Status status) {
    _status = status;
    notifyListeners();
  }
}
