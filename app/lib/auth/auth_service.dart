import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

enum Status { Authenticated, Authenticating, Unauthenticated, Uninitialized, Fail, SigningOut }

class AuthService with ChangeNotifier {
  Status _status = Status.Uninitialized;

  Status get status => _status;

  User user;
  String errorMessage = "";

  AuthService() {
    FirebaseAuth.instance.userChanges().listen((User user) {
      if (user != null) {
        this.user = user;
        _changeStatus(Status.Authenticated);
      } else {
        _changeStatus(Status.Unauthenticated);
      }
    });
  }

  void signInWithGoogle() async {
    _changeStatus(Status.Authenticating);
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    await FirebaseAuth.instance.signInWithPopup(googleProvider).catchError((e) {
      errorMessage = e.toString();
      _changeStatus(Status.Fail);
    });
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
