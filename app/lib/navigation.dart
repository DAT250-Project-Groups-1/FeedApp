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
    MaterialPage authPage;

    switch (authService.status) {
      case Status.Authenticated:
        authPage = MaterialPage(
          child: MainScreen(),
        );
        break;
      case Status.Unauthenticated:
      case Status.Fail:
        authPage = MaterialPage(
          child: Login(),
        );
        break;
      case Status.Authenticating:
      case Status.Uninitialized:
      case Status.SigningOut:
        authPage = MaterialPage(
          child: Loading(),
        );
        break;
    }

    return Navigator(
      pages: [authPage],
      onPopPage: (route, result) => route.didPop(result),
    );
  }
}