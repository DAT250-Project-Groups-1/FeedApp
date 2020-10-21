import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:provider/provider.dart';

import '../auth/auth_service.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthService authService = context.watch<AuthService>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GoogleSignInButton(
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
