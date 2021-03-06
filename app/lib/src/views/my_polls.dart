import 'package:app/src/api/api_service.dart';
import 'package:app/src/widgets/my_poll_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/src/views/dialogs/new_poll_dialog.dart';
import 'package:app/src/models/poll.dart';

class MyPolls extends StatefulWidget {
  @override
  _MyPollsState createState() => _MyPollsState();
}

class _MyPollsState extends State<MyPolls> {
  void showNewPollDialog(context, Future<Null> Function(Poll poll) postPoll) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return NewPollDialog(postPoll: postPoll);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<ApiService>().getUser();
  }

  @override
  Widget build(BuildContext context) {
    ApiService apiService = context.watch<ApiService>();

    _deletePoll(Poll p) async {
      try {
        apiService.postPoll(p);
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Successfully submitted poll"),
        ));
      } catch (e) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Successfully submitted poll"),
        ));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("My polls"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showNewPollDialog(context, _deletePoll);
        },
      ),
      body: apiService.user != null
          ? MyPollList()
          : Center(child: CircularProgressIndicator()),
    );
  }
}
