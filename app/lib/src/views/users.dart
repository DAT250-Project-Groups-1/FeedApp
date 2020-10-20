import 'package:app/src/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Users extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthService authService = context.watch<AuthService>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
        actions: [
          MaterialButton(
            child: Text("Sign out"),
            onPressed: () async {
              await authService.signOut();
            },
          )
        ],
      ),
    );
  }
}
