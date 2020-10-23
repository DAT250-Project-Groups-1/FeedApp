import 'package:flutter/material.dart';

class AdminDialog extends StatelessWidget {
  final Future<Null> Function() makeUserAdmin;

  AdminDialog(this.makeUserAdmin);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Are you sure you want to make this user admin?"),
      content: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: Text("Yes"),
              onPressed: () async {
                makeUserAdmin();
                Navigator.pop(context);
              },
            ),
            TextButton(
                child: Text("No"),
                onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
