import 'package:app/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthService authService = context.watch<AuthService>();

    return Scaffold(
      appBar: AppBar(
        actions: [
          MaterialButton(
            child: Text("Sign out"),
            onPressed: () async {
              await authService.signOut();
            },
          )
        ],
      ),
      body: Center(
        child: Text("Homepage"),
      ),
    );
  }
}
