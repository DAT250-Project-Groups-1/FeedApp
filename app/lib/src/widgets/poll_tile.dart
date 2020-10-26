import 'package:app/src/api/api_service.dart';
import 'package:app/src/models/poll.dart';
import 'package:app/src/models/vote.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PollTile extends StatelessWidget {
  final Poll poll;

  PollTile(this.poll);

  @override
  Widget build(BuildContext context) {
    ApiService apiService = context.watch<ApiService>();

    return Container(
      child: Card(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              poll.question,
              textScaleFactor: 1.3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                TextButton(
                  onPressed: () {
                    if (poll.isPrivate) {
                      apiService.postVote(
                        Vote(isYes: true, pollID: poll.id),
                      );
                    } else {
                      apiService.postPublicVote(
                        Vote(isYes: true, pollID: poll.id),
                      );
                    }
                  },
                  child: Text(
                    "YES",
                    style: TextStyle(color: Color(0xFFc68400)),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (poll.isPrivate) {
                      apiService.postVote(
                        Vote(isYes: false, pollID: poll.id),
                      );
                    } else {
                      apiService.postPublicVote(
                        Vote(isYes: false, pollID: poll.id),
                      );
                    }
                  },
                  child: Text(
                    "NO",
                    style: TextStyle(color: Color(0xFFc68400)),
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}