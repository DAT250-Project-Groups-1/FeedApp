import 'package:app/src/api/api_service.dart';
import 'package:app/src/models/user.dart';
import 'package:app/src/views/dialogs/admin_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {
  final User user;

  Future<void> _showAdminDialog(BuildContext context, Future<Null> Function() makeUserAdmin) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AdminDialog(makeUserAdmin));
  }

  UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    ApiService apiService = context.watch<ApiService>();

    _makeUserAdmin() async {
      await apiService.makeAdmin(user.iD);
      await apiService.getUsers();
    }

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
      onTap: !user.isAdmin
          ? () async {
              await _showAdminDialog(context, _makeUserAdmin);
            }
          : null,
    );
  }
}
