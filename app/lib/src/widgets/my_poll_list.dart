import 'package:app/src/api/api_service.dart';
import 'package:app/src/widgets/my_poll_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyPollList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ApiService>(
      builder: (context, state, _) {
        return ListView.builder(
          itemCount: state.user.polls.length,
          itemBuilder: (context, i) => MyPollTile(state.user.polls[i]),
        );
      },
    );
  }
}
