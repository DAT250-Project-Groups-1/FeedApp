import 'dart:convert';

import 'package:app/src/models/poll.dart';
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

  Future<List<User>> getUsers() async {
    var res = await http.get('$API_URL/admin/users',
        headers: {"Authorization": "Bearer ${await token}"});

    return (json.decode(res.body) as List)
        .map((p) => User.fromJson(p))
        .toList();
  }
}
