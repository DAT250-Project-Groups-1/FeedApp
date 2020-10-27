import 'package:flutter/material.dart';
import 'package:app/src/models/poll.dart';

class DeleteDialog extends StatelessWidget {
  final Poll poll;
  final Future<Null> Function(Poll poll) deletePoll;

  DeleteDialog(this.poll, this.deletePoll);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("Are you sure you want to delete this poll?"),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                deletePoll(poll);
                Navigator.pop(context);
              },
              child: Text("Yes"),
            ),
          ],
        )
      ],
    );
  }
}