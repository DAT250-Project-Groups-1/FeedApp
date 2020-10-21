import 'package:app/src/auth/auth_service.dart';
import 'package:app/src/views/loading.dart';
import 'package:app/src/views/login.dart';
import 'package:app/src/views/main_screen.dart';
import 'package:app/src/views/public_polls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthService authService = context.watch<AuthService>();
    return Navigator(
        pages: [
          if (authService.status == Status.Authenticated)
            MaterialPage(
              key: ValueKey<String>('main'),
              child: MainScreen(),
            ),
          if (authService.status == Status.Unauthenticated ||
              authService.status == Status.Fail ||
              authService.status == Status.Login)
            MaterialPage(
              key: ValueKey<String>('public'),
              child: PublicPolls(),
            ),
          if (authService.status == Status.Fail ||
              authService.status == Status.Login)
            MaterialPage(
              key: ValueKey<String>('login'),
              child: Login(),
            ),
          if (authService.status == Status.Authenticating ||
              authService.status == Status.Uninitialized ||
              authService.status == Status.SigningOut)
            MaterialPage(
              key: ValueKey<String>('loading'),
              child: Loading(),
            ),
        ],
        onPopPage: (route, result) {
          if (!route.didPop(result)) {
            return false;
          }
          Page page = route.settings;
          if (page.key == ValueKey<String>('login')) {
            authService.changeStatus(Status.Unauthenticated);
          }
          return true;
        });
  }
}
