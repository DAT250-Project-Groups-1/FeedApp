import 'package:app/src/models/user.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final User user;

  UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.person),
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: user.isAdmin
          ? Icon(
              Icons.security,
              color: Colors.red,
            )
          : SizedBox.shrink(),
    );
  }
}
