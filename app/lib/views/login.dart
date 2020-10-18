import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../auth/auth_service.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthService authService = context.watch<AuthService>();

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            FlatButton(
              child: Text("Google Login"),
              onPressed: () {
                authService.signInWithGoogle();
              },
            ),
            Text(authService.errorMessage),
          ],
        ),
      ),
    );
  }
}
