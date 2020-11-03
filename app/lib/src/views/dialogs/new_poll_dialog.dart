import 'package:flutter/material.dart';
import 'package:app/src/models/poll.dart';
import 'package:faker/faker.dart';

class NewPollDialog extends StatefulWidget {
  final Future<Null> Function(Poll poll) postPoll;

  const NewPollDialog({Key key, this.postPoll}) : super(key: key);

  @override
  _NewPollDialogState createState() => _NewPollDialogState();
}

class _NewPollDialogState extends State<NewPollDialog> {
  final _formKey = GlobalKey<FormState>();
  final textController = TextEditingController();
  bool isPrivate = false;
  bool isOpen = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(title: Text("Create new poll"), children: [
      Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextFormField(
                    controller: textController,
                    decoration: InputDecoration(hintText: "Question"),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter a question";
                      }
                      return null;
                    })),
            SwitchListTile(
              title: const Text("Private"),
              value: isPrivate,
              onChanged: (bool val) => setState(() => isPrivate = val),
            ),
            SwitchListTile(
              title: const Text("Active"),
              value: isOpen,
              onChanged: (bool val) => setState(() => isOpen = val),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false
                        // otherwise.
                        if (_formKey.currentState.validate()) {
                          // Post poll to db
                          widget.postPoll(
                            Poll(
                                question: textController.text,
                                open: isOpen,
                                countYes: 0,
                                countNo: 0,
                                code: faker.internet.userName(),
                                isPrivate: isPrivate,
                                userId: null,
                                votes: null,
                                iotVotes: null),
                          );

                          Navigator.pop(context);
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ]),
            ),
          ],
        ),
      )
    ]);
  }
}
