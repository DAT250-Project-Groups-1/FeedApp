import 'package:app/src/api/api_service.dart';
import 'package:app/src/auth/auth_service.dart';
import 'package:app/src/widgets/user_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  void initState() {
    super.initState();
    context.read<ApiService>().getUsers();
  }

  @override
  Widget build(BuildContext context) {
    AuthService authService = context.watch<AuthService>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
        actions: [
          MaterialButton(
            child: Text("Sign out"),
            onPressed: () async {
              await authService.signOut();
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Nothing yet
        },
      ),
      body: UserList(),
    );
  }
}
