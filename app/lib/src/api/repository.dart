import 'dart:convert';

import 'package:app/src/models/poll.dart';
import 'package:app/src/models/vote.dart';
import 'package:app/src/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const API_URL =
    String.fromEnvironment('API_URL', defaultValue: 'http://localhost:8080');

class Repository {
  Future<String> get token async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> postUser() async {
    await http.post(
      '$API_URL/users',
      headers: {
        "Authorization": "Bearer ${await token}",
        "Content-Type": "application/json"
      },
    );
  }

  Future<void> postPoll(Poll poll) async {
    await http.post('$API_URL/polls',
        headers: {
          "Authorization": "Bearer ${await token}",
          "Content-Type": "application/json"
        },
        body: json.encode(poll));
  }

  Future<List<Poll>> getPublicPolls() async {
    var res = await http.get('$API_URL/public/polls');
    return (json.decode(res.body) as List)
        .map((p) => Poll.fromJson(p))
        .toList();
  }

  postPublicVote(Vote vote) async {
    await http.post('$API_URL/public/vote',
        body: json.encode(vote), headers: {"Content-Type": "application/json"});
  }

  postVote(Vote vote) async {
    await http.post(
      '$API_URL/votes',
      body: json.encode(vote),
      headers: {
        "Authorization": "Bearer ${await token}",
        "Content-Type": "application/json"
      },
    );
  }

  Future<Poll> getPoll(String code) async {
    var res = await http.get(
      '$API_URL/polls/$code',
      headers: {"Authorization": "Bearer ${await token}"},
    );
    return Poll.fromJson(json.decode(res.body));
  }

  deletePoll(Poll poll) async {
    var uid = poll.id;
    await http.delete(
      '$API_URL/polls/$uid',
      headers: {
        "Authorization": "Bearer ${await token}",
      },
    );
  }

  Future<Poll> openPoll(Poll poll) async {
    var uid = poll.id;
    var res = await http.put(
      '$API_URL/polls/open/$uid',
      headers: {
        "Authorization": "Bearer ${await token}",
      },
    );
    return Poll.fromJson(json.decode(res.body));
  }

  Future<Poll> endPoll(Poll poll) async {
    var uid = poll.id;
    var res = await http.put(
      '$API_URL/polls/end/$uid',
      headers: {
        "Authorization": "Bearer ${await token}",
      },
    );
    return Poll.fromJson(json.decode(res.body));
  }

  Future<User> getUser() async {
    var res = await http.post(
      '$API_URL/users',
      headers: {
        "Authorization": "Bearer ${await token}",
        "Content-Type": "application/json"
      },
    );
    return User.fromJson(json.decode(res.body));
  }

  Future<List<User>> getUsers() async {
    var res = await http.get('$API_URL/admin/users',
        headers: {"Authorization": "Bearer ${await token}"});

    return (json.decode(res.body) as List)
        .map((p) => User.fromJson(p))
        .toList();
  }

  Future<User> makeAdmin(String uid) async {
    var res = await http.put('$API_URL/admin/makeAdmin/$uid',
        headers: {"Authorization": "Bearer ${await token}"});
    return User.fromJson(json.decode(res.body));
  }
}
