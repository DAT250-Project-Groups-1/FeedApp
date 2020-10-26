import 'package:app/src/api/repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String _errorMessage = "";
  bool _isAdmin = false;

  Status get status => _status;

  String get errorMessage => _errorMessage;

  bool get isAdmin => _isAdmin;

  AuthService() {
    FirebaseAuth.instance.userChanges().listen((User user) async {
      if (user != null) {
        var prefs = await SharedPreferences.getInstance();
        var token = await user.getIdTokenResult(true);
        _isAdmin = token.claims['admin'] ?? false;
        prefs.setString('token', token.token);
        _repository.postUser();
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
      _errorMessage = e.toString();
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
