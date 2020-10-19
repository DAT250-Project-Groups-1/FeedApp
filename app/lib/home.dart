import 'package:app/auth/auth_service.dart';
import 'package:app/navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
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
