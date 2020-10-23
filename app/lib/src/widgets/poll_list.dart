import 'package:app/src/api/api_service.dart';
import 'package:app/src/views/loading.dart';
import 'package:app/src/widgets/poll_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PollList extends StatefulWidget {
  const PollList({
    Key key,
  }) : super(key: key);

  @override
  _PollListState createState() => _PollListState();
}

class _PollListState extends State<PollList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ApiService>(
      builder: (context, state, _) {
        return ListView.builder(
          itemCount: state.polls.length,
          itemBuilder: (context, i) => PollTile(state.polls[i]),
        );
      },
    );
  }
}
