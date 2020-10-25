import 'package:app/src/api/api_service.dart';
import 'package:app/src/auth/auth_service.dart';
import 'package:app/src/models/poll.dart';
import 'package:app/src/views/dialogs/poll_dialog.dart';
import 'package:app/src/widgets/poll_list.dart';
import 'package:app/src/widgets/poll_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PublicPolls extends StatefulWidget {
  @override
  _PublicPollsState createState() => _PublicPollsState();
}

class _PublicPollsState extends State<PublicPolls> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  Poll searched;

  Future<void> _showPollDialog(
      BuildContext context, Future<Null> Function(String code) getPoll) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => PollDialog(getPoll));
  }

  @override
  void initState() {
    super.initState();
    Provider.of<ApiService>(context, listen: false).getPublicPolls();
  }

  @override
  Widget build(BuildContext context) {
    AuthService authService = context.watch<AuthService>();
    ApiService apiService = context.watch<ApiService>();
    ThemeData themeData = Theme.of(context);

    _getPoll(String code) async {
      if (authService.status == Status.Authenticated) {
        try {
          var poll = await apiService.getPoll(code);
          setState(() {
            searched = poll;
          });
        } catch (e) {
          print(e);
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text("No polls with given code"),
            ),
          );
        }
      } else {
        setState(() {
          searched = apiService.polls.firstWhere((e) => e.code == code);
        });
      }
    }

    return Scaffold(
      key: _scaffoldKey,
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.analytics),
        onPressed: () async {
          await _showPollDialog(context, _getPoll);
        },
      ),
      body: searched == null ? PollList() : PollTile(searched),
    );
  }
}
