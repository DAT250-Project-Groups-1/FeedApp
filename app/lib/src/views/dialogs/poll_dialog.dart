import 'package:flutter/material.dart';

class PollDialog extends StatelessWidget {
  final TextEditingController _codeController = TextEditingController();
  final Future<Null> Function(String code) getPoll;

  PollDialog(this.getPoll);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("Enter poll code"),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _codeController,
            keyboardType: TextInputType.visiblePassword,
            decoration:
                InputDecoration(border: OutlineInputBorder(), hintText: "Code"),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                await getPoll(_codeController.text);
                Navigator.pop(context);
              },
              child: Text("Go"),
            ),
          ],
        )
      ],
    );
  }
}
