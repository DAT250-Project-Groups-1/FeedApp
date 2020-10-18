import 'package:app/auth_service.dart';
import 'package:app/loading.dart';
import 'package:app/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (BuildContext context) => AuthService(),
        child: Navigation(),
      ),
    );
  }
}

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
