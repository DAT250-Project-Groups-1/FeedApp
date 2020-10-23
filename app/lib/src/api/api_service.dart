import 'package:app/src/api/repository.dart';
import 'package:app/src/models/poll.dart';
import 'package:app/src/models/public_vote.dart';
import 'package:app/src/models/user.dart';
import 'package:flutter/material.dart';

class ApiService with ChangeNotifier {
  final _repository = Repository();
  var _polls = List<Poll>();
  var _users = List<User>();

  List<Poll> get polls => _polls;

  List<User> get users => _users;

  getPublicPolls() async {
    var polls = await _repository.getPublicPolls();
    _polls = polls;
    notifyListeners();
  }

  Future<Poll> getPoll(String code) async {
    return await _repository.getPoll(code);
  }

  postPublicVote(PublicVote vote) async {
    await _repository.postPublicVote(vote);
  }

  getUsers() async {
    var users = await _repository.getUsers();
    _users = users;
    notifyListeners();
  }

  Future<User> makeAdmin(String uid) async {
    var user = await _repository.makeAdmin(uid);
    return user;
  }
}
