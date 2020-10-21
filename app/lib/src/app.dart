import 'package:app/src/api/api_service.dart';
import 'package:app/src/auth/auth_service.dart';
import 'package:app/src/navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthService()),
          ChangeNotifierProvider(create: (_) => ApiService())
        ],
        child: Navigation(),
      ),
      theme: ThemeData(
        primaryColor: Color(0xFF445963),
        primaryColorDark: Color(0xFF1b3039),
        primaryColorLight: Color(0xFF708690),
        accentColor: Color(0xFFffb300),
      ),
    );
  }
}
