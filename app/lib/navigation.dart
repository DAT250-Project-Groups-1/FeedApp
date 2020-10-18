import 'package:app/auth/auth_service.dart';
import 'package:app/views/loading.dart';
import 'package:app/views/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'views/login.dart';

class Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthService authService = context.watch<AuthService>();

    return Navigator(
      pages: [
        if (authService.status == Status.Unauthenticated ||
            authService.status == Status.Fail)
          MaterialPage(
            child: Login(),
          ),
        if (authService.status == Status.Authenticated)
          MaterialPage(
            child: MainScreen(),
          ),
        if (authService.status == Status.Authenticating ||
            authService.status == Status.SigningOut)
          MaterialPage(
            child: Loading(),
          ),
      ],
      onPopPage: (route, result) => route.didPop(result),
    );
  }
}
