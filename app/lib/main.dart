import 'package:app/src/app.dart';
import 'package:app/src/views/error_screen.dart';
import 'package:app/src/views/loading.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() => runApp(Init());

class Init extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return ErrorScreen();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return App();
        }

        return Loading();
      },
    );
  }
}
