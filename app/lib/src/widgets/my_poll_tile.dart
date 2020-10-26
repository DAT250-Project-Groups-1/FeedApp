import 'package:app/src/models/poll.dart';
import 'package:flutter/material.dart';

class MyPollTile extends StatelessWidget {
  final Poll poll;
  MyPollTile(this.poll);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: ListTile(
          title: Text(poll.question),
        ),
      ),
    );
  }
}