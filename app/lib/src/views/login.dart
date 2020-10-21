import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../auth/auth_service.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthService authService = context.watch<AuthService>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Polls"),
      ),
      body: Center(
        child: Column(
          children: [
            MaterialButton(
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
