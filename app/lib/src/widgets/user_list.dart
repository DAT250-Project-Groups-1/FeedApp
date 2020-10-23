import 'package:app/src/api/api_service.dart';
import 'package:app/src/widgets/user_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ApiService apiService = context.watch<ApiService>();
    return ListView.builder(
      itemCount: apiService.users.length,
      itemBuilder: (BuildContext context, int i) =>
          UserTile(apiService.users[i]),
    );
  }
}
