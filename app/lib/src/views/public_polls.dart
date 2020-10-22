import 'package:app/src/api/api_service.dart';
import 'package:app/src/auth/auth_service.dart';
import 'package:app/src/widgets/poll_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PublicPolls extends StatefulWidget {
  @override
  _PublicPollsState createState() => _PublicPollsState();
}

class _PublicPollsState extends State<PublicPolls> {
  @override
  void initState() {
    super.initState();
    Provider.of<ApiService>(context, listen: false).getPublicPolls();
  }

  @override
  Widget build(BuildContext context) {
    AuthService authService = context.watch<AuthService>();
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Public polls"),
        actions: [
          if (authService.status == Status.Unauthenticated)
            FlatButton.icon(
              icon: Icon(
                Icons.person,
                color: themeData.accentColor,
              ),
              label: Text(
                "Login",
                style: TextStyle(
                    color: themeData.primaryTextTheme.subtitle1.color),
              ),
              onPressed: () {
                authService.changeStatus(Status.Login);
              },
            )
        ],
      ),
      body: PollList(),
    );
  }
}
