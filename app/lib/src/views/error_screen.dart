import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text("Error"),
        ),
        body: Center(
          child: Text("Please check network connection, and try again"),
        ),
      ),
    );
  }
}
