import 'package:app/src/api/api_service.dart';
import 'package:app/src/auth/auth_service.dart';
import 'package:app/src/models/poll.dart';
import 'package:app/src/models/public_vote.dart';
import 'package:app/src/models/vote.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PollTile extends StatelessWidget {
  final Poll poll;

  PollTile(this.poll);

  @override
  Widget build(BuildContext context) {
    ApiService apiService = context.watch<ApiService>();
    AuthService authService = context.watch<AuthService>();
    User user = FirebaseAuth.instance.currentUser;

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
                  onPressed: () async {
                    if (poll.isPrivate) {
                      await apiService.postVote(
                        Vote(pollID: poll.id, userID: user.uid, isYes: true),
                      );
                    } else {
                      await apiService.postPublicVote(
                        PublicVote(isYes: true, pollID: poll.id),
                      );
                    }
                  },
                  child: Text(
                    "YES",
                    style: TextStyle(color: Color(0xFFc68400)),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    if (poll.isPrivate) {
                      await apiService.postVote(
                        Vote(pollID: poll.id, userID: user.uid, isYes: false),
                      );
                    } else {
                      await apiService.postPublicVote(
                        PublicVote(isYes: false, pollID: poll.id),
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
