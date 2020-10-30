import 'package:flutter/material.dart';
import 'package:app/src/models/poll.dart';

class CodeDialog extends StatelessWidget {
  final Poll poll;

  CodeDialog(this.poll);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("Poll code"),
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                poll.code,
                style: TextStyle(fontSize: 20)
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Ok"),
            ),
          ],
        )
      ],
    );
  }
}