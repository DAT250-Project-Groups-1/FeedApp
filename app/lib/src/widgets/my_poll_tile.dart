import 'package:app/src/models/poll.dart';
import 'package:app/src/views/dialogs/delete_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/src/api/api_service.dart';
import 'package:app/src/views/dialogs/code_dialog.dart';

class MyPollTile extends StatelessWidget {
  final Poll poll;
  MyPollTile(this.poll);

  void showDeleteDialog(context, Future<Null> Function(Poll poll) deletePoll) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteDialog(poll, deletePoll);
      },
    );
  }

  void showCodeDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CodeDialog(poll);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ApiService apiService = context.watch<ApiService>();

    _deletePoll(Poll p) async {
      apiService.deletePoll(p);
    }

    return Container(
      child: Card(
        child: ListTile(
          onTap: () {
            showCodeDialog(context);
            },
          title: Text(
            poll.question,
            style: poll.open
                ? null
                : TextStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  poll.open ? Icons.pause : Icons.play_arrow,
                  size: 20.0,
                ),
                onPressed: poll.open
                    ? () => apiService.endPoll(poll)
                    : () => apiService.openPoll(poll),
              ),
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
