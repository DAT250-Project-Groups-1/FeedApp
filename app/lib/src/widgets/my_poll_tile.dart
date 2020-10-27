import 'package:app/src/models/poll.dart';
import 'package:app/src/views/dialogs/delete_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/src/api/api_service.dart';

class MyPollTile extends StatelessWidget {
  final Poll poll;
  MyPollTile(this.poll);

  void showDeleteDialog(BuildContext context, Future<Null> Function(Poll poll)
  deletePoll) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteDialog(poll, deletePoll);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ApiService apiService = context.watch<ApiService>();

    _deletePoll(Poll p) async {
      try {
        var poll = apiService.deletePoll(p);
      } catch (e) {
      }
    }
    
    return Container(
      child: Card(
        child: ListTile(
          title: Text(poll.question),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  size: 20.0,
                ),
                onPressed: () {
                  showDeleteDialog(context, _deletePoll);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}