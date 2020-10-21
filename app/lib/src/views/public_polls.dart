import 'package:app/src/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PublicPolls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthService authService = context.watch<AuthService>();
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Public polls"),
        actions: [
          if (authService.status == Status.Unauthenticated)
            FlatButton.icon(
              icon: Icon(
                Icons.person,
                color: themeData.accentColor,
              ),
              label: Text(
                "Login",
                style: TextStyle(
                    color: themeData.primaryTextTheme.subtitle1.color),
              ),
              onPressed: () {
                authService.changeStatus(Status.Login);
              },
            )
        ],
      ),
    );
  }
}
