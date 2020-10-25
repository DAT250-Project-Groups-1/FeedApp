import 'dart:convert';

import 'package:app/src/models/poll.dart';
import 'package:app/src/models/public_vote.dart';
import 'package:app/src/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const API_URL = "http://localhost:8080";

class Repository {
  Future<String> get token async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> postUser() async {
    await http.post('$API_URL/users',
        headers: {"Authorization": "Bearer ${await token}"});
  }

  Future<List<Poll>> getPublicPolls() async {
    var res = await http.get('$API_URL/public/polls');
    return (json.decode(res.body) as List)
        .map((p) => Poll.fromJson(p))
        .toList();
  }

  postPublicVote(PublicVote publicVote) async {
    await http.post(
      '$API_URL/public/vote',
      body: publicVote.toJson(),
    );
  }

  Future<Poll> getPoll(String code) async {
    var res = await http.get('$API_URL/polls/$code',
        headers: {"Authorization": "Bearer ${await token}"});
    return Poll.fromJson(json.decode(res.body));
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
