import 'package:app/src/api/api_service.dart';
import 'package:app/src/widgets/poll_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyPolls extends StatefulWidget {
  @override
  _MyPollsState createState() => _MyPollsState();
}

class _MyPollsState extends State<MyPolls> {
  @override
  void initState() {
    super.initState();
    Provider.of<ApiService>(context, listen: false).getUserPolls();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My polls"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          //Nothing yet

        },
      ),
      body: PollList(),
    );
  }
}