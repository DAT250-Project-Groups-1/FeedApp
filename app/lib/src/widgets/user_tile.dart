import 'package:app/src/models/poll.dart';
import 'package:app/src/models/user.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final User user;
  UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: ListTile(
          title: Text(user.name),
        ),
      ),
    );
  }
}
