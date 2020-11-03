import 'package:app/src/api/api_service.dart';
import 'package:app/src/models/poll.dart';
import 'package:app/src/models/vote.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PollTile extends StatefulWidget {
  final Poll poll;

  PollTile(this.poll);

  @override
  _PollTileState createState() => _PollTileState();
}

class _PollTileState extends State<PollTile> {
  bool voted = false;

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
              widget.poll.question,
              textScaleFactor: 1.3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: voted
                ? Row(
                    children: [
                      TextButton(
                        onPressed: null,
                        child: Text(
                          this.widget.poll.countYes.toString(),
                          style: TextStyle(color: Color(0xFFc68400)),
                        ),
                      ),
                      TextButton(
                        onPressed: null,
                        child: Text(
                          this.widget.poll.countNo.toString(),
                          style: TextStyle(color: Color(0xFFc68400)),
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          if (widget.poll.isPrivate) {
                            apiService.postVote(
                              Vote(isYes: true, pollID: widget.poll.id),
                            );
                          } else {
                            apiService.postPublicVote(
                              Vote(isYes: true, pollID: widget.poll.id),
                            );
                          }
                          setState(() {
                            voted = true;
                          });
                        },
                        child: Text(
                          "YES",
                          style: TextStyle(color: Color(0xFFc68400)),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          if (widget.poll.isPrivate) {
                            apiService.postVote(
                              Vote(isYes: false, pollID: widget.poll.id),
                            );
                          } else {
                            apiService.postPublicVote(
                              Vote(isYes: false, pollID: widget.poll.id),
                            );
                          }
                          setState(() {
                            voted = true;
                          });
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
