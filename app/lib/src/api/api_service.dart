import 'package:app/src/api/repository.dart';
import 'package:app/src/models/poll.dart';
import 'package:flutter/material.dart';

class ApiService with ChangeNotifier {
  final _repository = new Repository();
  var _polls = List<Poll>();

  List<Poll> get polls => _polls;

  getPublicPolls() async {
    var polls = await _repository.getPublicPolls();
    _polls = polls;
    notifyListeners();
  }
}
