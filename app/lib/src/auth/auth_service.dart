import 'package:app/src/api/repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum Status {
  Authenticated,
  Authenticating,
  Unauthenticated,
  Uninitialized,
  Login,
  Fail,
  SigningOut
}

class AuthService with ChangeNotifier {
  final _repository = new Repository();
  Status _status = Status.Uninitialized;

  Status get status => _status;

  User user;
  String errorMessage = "";

  AuthService() {
    FirebaseAuth.instance.userChanges().listen((User user) {
      if (user != null) {
        this.user = user;
        _repository.postUser(user);
        changeStatus(Status.Authenticated);
      } else {
        changeStatus(Status.Unauthenticated);
      }
    });
  }

  void signInWithGoogle() async {
    changeStatus(Status.Authenticating);
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    await FirebaseAuth.instance.signInWithPopup(googleProvider).catchError((e) {
      errorMessage = e.toString();
      changeStatus(Status.Fail);
    });
  }

  Future<void> signOut() async {
    changeStatus(Status.SigningOut);
    await FirebaseAuth.instance.signOut();
  }

  void changeStatus(Status status) {
    _status = status;
    notifyListeners();
  }
}
